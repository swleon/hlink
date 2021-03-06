package com.haibao.admin.web.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.google.common.collect.Maps;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.haibao.admin.utils.HelpUtils;
import com.haibao.admin.utils.OkHttpUtil;
import com.haibao.admin.web.entity.TCluster;
import com.haibao.admin.web.entity.TDs;
import com.haibao.admin.web.entity.TDsJsonField;
import com.haibao.admin.web.entity.TJob;
import com.haibao.admin.web.entity.TJobDs;
import com.haibao.admin.web.entity.TJobDsSink;
import com.haibao.admin.web.entity.TJobLog;
import com.haibao.admin.web.service.ClusterService;
import com.haibao.admin.web.service.DsJsonFieldService;
import com.haibao.admin.web.service.DsSchemaColumnService;
import com.haibao.admin.web.service.DsService;
import com.haibao.admin.web.service.FlinkApiService;
import com.haibao.admin.web.service.JobDsService;
import com.haibao.admin.web.service.JobDsSinkService;
import com.haibao.admin.web.service.JobLogService;
import com.haibao.admin.web.service.JobService;
import com.haibao.admin.web.vo.JobDsVO;
import com.haibao.admin.web.vo.JobVO;
import com.haibao.flink.enums.CheckpointStatebackendTypeEnum;
import com.haibao.flink.enums.DsTypeEnum;
import com.haibao.flink.log.LogEvent;
import com.haibao.flink.log.LogLevelEnum;
import com.haibao.flink.utils.GsonUtils;
import com.nextbreakpoint.flinkclient.api.ApiException;
import com.nextbreakpoint.flinkclient.model.ExecutionExceptionInfo;
import com.nextbreakpoint.flinkclient.model.JarFileInfo;
import com.nextbreakpoint.flinkclient.model.JarListInfo;
import com.nextbreakpoint.flinkclient.model.JobExceptionsInfo;
import com.haibao.admin.web.common.enums.CodeEnum;
import com.haibao.admin.web.common.enums.JobStatusEnum;
import com.haibao.admin.web.common.enums.JobTypeEnum;
import com.haibao.admin.web.common.result.Response;
import com.haibao.admin.web.mapper.JobMapper;
import com.haibao.admin.web.vo.templete.JsonField;
import freemarker.template.TemplateException;
import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by baoyu on 2020/2/5.
 * Describe
 */
@Service
public class JobServiceImpl extends ServiceImpl<JobMapper, TJob> implements JobService {

    private Logger LOGGER = LoggerFactory.getLogger(JobServiceImpl.class);

    @Autowired
    private JobDsService jobDsService;
    @Autowired
    private JobDsSinkService jobDsSinkService;
    @Autowired
    private JobLogService jobLogService;

    @Autowired
    private FlinkApiService flinkApiService;

    @Autowired
    private ClusterService clusterService;
    @Autowired
    private DsService dsService;
    @Autowired
    private DsJsonFieldService dsJsonFieldService;
    @Autowired
    private DsSchemaColumnService dsSchemaColumnService;

    @Autowired
    private HttpServletRequest request;

    /**
     * ????????? ?????????????????????????????????????????????
     */
    @Value("${flink.job.checkpoint-statebackend-type}")
    private String checkpointStatebackendType;
    @Value("${flink.job.checkpoint-statebackend-path}")
    private String checkpointStatebackendPath;
    @Value("${spring.profiles.active}")
    private String profilesActive;

    /**
     * ????????????
     * @param jobVO
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public Response<TJob> createJob(JobVO jobVO) {

        int jobType=jobVO.getJobType();
        jobVO.setJobCode(HelpUtils.getJobCode(jobType));

        int checkpointStatebackendTypeVO = CheckpointStatebackendTypeEnum.MEMORY.getCode();
        String checkpointStatebackendPathVO = "";

        //???????????? ??????????????????????????????
        if(StrUtil.isNotEmpty(checkpointStatebackendPath)){
            if(CheckpointStatebackendTypeEnum.FS.getType().equals(checkpointStatebackendType) ){
                checkpointStatebackendTypeVO = CheckpointStatebackendTypeEnum.FS.getCode();
                checkpointStatebackendPathVO = checkpointStatebackendPath;
            }else if(CheckpointStatebackendTypeEnum.ROCKSDB.getType().equals(checkpointStatebackendType) ){
                checkpointStatebackendTypeVO = CheckpointStatebackendTypeEnum.FS.getCode();
                checkpointStatebackendPathVO = checkpointStatebackendPath;
            }
        }
        jobVO.setCheckpointStatebackendType(checkpointStatebackendTypeVO);
        jobVO.setCheckpointStatebackendPath(checkpointStatebackendPathVO);

        //???????????????????????????????????????
        TJob tJob;
        if(JobTypeEnum.JAR.getType()==jobType){
            tJob = new TJob();
            BeanUtils.copyProperties(jobVO,tJob);
            save(tJob);
        }else{ //SQL??????????????????????????????????????????
            tJob = saveSQLJob(jobVO);
        }

        return Response.success(tJob);
    }

    /**
     * ??????SQL?????? ??????
     * @param jobVO
     * @return
     */
    TJob saveSQLJob(JobVO jobVO) {
        TJob tJob = new TJob();
        BeanUtils.copyProperties(jobVO,tJob);
        save(tJob);

        List<JobDsVO> jobDsVOS = jobVO.getJobDsVOS();

        //???????????????????????????
        List<TJobDs> jobDsList = jobDsVOS.stream().filter(jobDsVO -> {
            if(!DsTypeEnum.SINK.getType().equals(jobDsVO.getDsType())){
                return true;
            }
            return false;
        }).collect(Collectors.toList())
                .stream().map(jobDsVO -> {
            TJobDs jobDs = new TJobDs();
            BeanUtils.copyProperties(jobDsVO,jobDs);
            jobDs.setJobId(tJob.getId());

            return jobDs;
        }).collect(Collectors.toList());

        jobDsService.saveBatch(jobDsList);

        //?????????????????????
        List<TJobDsSink> jobDsSinkList = jobDsVOS.stream().filter(jobDsVO -> {
            if(DsTypeEnum.SINK.getType().equals(jobDsVO.getDsType())){
                return true;
            }
            return false;
        }).collect(Collectors.toList())
                .stream().map(jobDsVO -> {
                    TJobDsSink jobDsSink = new TJobDsSink();
                    BeanUtils.copyProperties(jobDsVO,jobDsSink);
                    jobDsSink.setJobId(tJob.getId());

                    return jobDsSink;
                }).collect(Collectors.toList());

        jobDsSinkService.saveBatch(jobDsSinkList);

        return tJob;
    }

    /**
     * ????????????
     * @param jobQuery ????????????
     * @return
     */
    @Override
    public Response<IPage<JobVO>> selectJobs(JobVO jobQuery) {

        Page<JobVO> page=new Page<>(jobQuery.getCurPage(),jobQuery.getPageSize());

        IPage<JobVO> result = baseMapper.selectJobList(page,jobQuery);

        List<JobVO> jobList=result.getRecords();
        //???????????????-->??????
        if(CollectionUtils.isNotEmpty(jobList)){
            for(JobVO jobVO:jobList){
                Integer jobStatus=jobVO.getJobStatus();
//                Integer clusterType=jobVO.getClusterType();
                Integer jobType=jobVO.getJobType();
                if(JobStatusEnum.getById(jobStatus)!=null){
                    jobVO.setJobStatusName(JobStatusEnum.getById(jobStatus).getDesc());
                }
                if(JobTypeEnum.getById(jobType)!=null){
                    jobVO.setJobTypeName(JobTypeEnum.getById(jobType).toString());
                }
            }
        }
        return Response.success(result);
    }

    /**
     * ????????????
     * @param jobId ??????Id
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public Response deleteJob(Long jobId) {
        TJob jobDO= getById(jobId);
        if(jobDO==null){
            return Response.error(CodeEnum.JOB_NOT_FOUND);
        }
        if(JobStatusEnum.RUNNING.getStatus().equals(jobDO.getJobStatus())){
            return Response.error(CodeEnum.JOB_IS_RUNNING);
        }
        //????????????
        removeById(jobId);

        if(JobTypeEnum.SQL.getType() == jobDO.getJobType().intValue()){
           //???????????????????????????
            QueryWrapper<TJobDs> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("job_id",jobId);
           jobDsService.remove(queryWrapper);

            QueryWrapper<TJobDsSink> queryWrapper2 = new QueryWrapper<>();
            queryWrapper2.eq("job_id",jobId);
            jobDsSinkService.remove(queryWrapper2);
        }
        //????????????????????????
        QueryWrapper<TJobLog> queryWrapper3 = new QueryWrapper<>();
        queryWrapper3.eq("job_id",jobId);
        jobLogService.remove(queryWrapper3);

        return Response.success();
    }

    /**
     * ????????????
     * @param id
     * @return
     */
    @Override
    public Response run(Long id) {

        if(id==null){
            return Response.error(CodeEnum.PARAM_ERROR);
        }
        TJob tJob = getById(id);
        if(tJob==null){
            return Response.error(CodeEnum.JOB_NOT_FOUND);
        }

        if(JobStatusEnum.RUNNING.getStatus().equals(tJob.getJobStatus())){
            return Response.error(CodeEnum.JOB_IS_RUNNING);
        }

        //??????????????????
        TCluster cluster=clusterService.getById(tJob.getClusterId());
        //?????????????????? ?????? (1??????????????????  2???????????????????????? ?????????  3????????????????????? ???)
        Response checkResponse = null;
        try {
            checkResponse = checkEnv(cluster,tJob);
        } catch (Exception e) {
            return Response.error(0,"?????????????????????"+e.getMessage());
        }
        if(!checkResponse.isSuccess()){
            return checkResponse;
        }

        String clusterAddress=cluster.getAddress();
        String savepointPath=tJob.getSavepointPath();
        Integer parallelism=tJob.getParallelism();
        Integer allowNrs = tJob.getAllowNrs();

        try {

            int jobType=tJob.getJobType();
            //JAR????????????
            if(JobTypeEnum.JAR.getType()==jobType){

                String jarId = tJob.getUseJar();
                if(StringUtils.isBlank(jarId)){
                    return Response.error(CodeEnum.PLEASE_CONFIG_JAR_ID);
                }

                Boolean allowNrsBoolean= allowNrs==0?false:true;
                String programArg=tJob.getProgram();
                String entryClass=tJob.getEntryClass();

                //======================????????????========================================
                Map parmMap = Maps.newLinkedHashMap();
                parmMap.put("clusterAddress",clusterAddress);
                parmMap.put("jarId",jarId);
                parmMap.put("allowNrsBoolean",allowNrsBoolean);
                parmMap.put("savepointPath",savepointPath);
                parmMap.put("programArg",programArg);
                parmMap.put("entryClass",entryClass);
                parmMap.put("parallelism",parallelism);

                Map logMap = new LinkedHashMap(2);
                logMap.put("??????",parmMap);
                //====================================================================

                String resultStr = null;
                try {
                    resultStr = flinkApiService.runJar(clusterAddress,jarId,allowNrsBoolean,savepointPath,programArg,entryClass,parallelism);
                } catch (IOException e) {
                    e.printStackTrace();
                    logMap.put("????????????",e.getMessage());
                } catch (ApiException e) {
                    e.printStackTrace();
                    logMap.put("????????????",e.getMessage());
                }

                JsonObject result = null;
                boolean is = false;
                if(null != resultStr){
                    result=JsonParser.parseString(resultStr).getAsJsonObject();
                    
                    String flinkJobId= null;
                    try {
                        flinkJobId = null != result.get("jobid")? result.get("jobid").getAsString():"";
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    if(StrUtil.isNotEmpty(flinkJobId)){
                        tJob.setFlinkJobId(flinkJobId);
                        tJob.setJobStatus(JobStatusEnum.RUNNING.getStatus());
                        updateById(tJob);
                        is = true;
                    }
                }

                logMap.put("????????????",result);
                LogEvent logEvent = new LogEvent();
                logEvent.setTimestamp(System.currentTimeMillis());
                logEvent.setMessage(GsonUtils.gsonString(logMap));
                logEvent.setType("JAR????????????");
                logEvent.setLevel(LogLevelEnum.INFO.name());

                Map tags = Maps.newLinkedHashMap();
                tags.put("URL",request.getRequestURL().toString());
                tags.put("IP",request.getRemoteAddr());
                tags.put("????????????","");

                logEvent.setTags(tags);

                jobLogService.sendLog(id,GsonUtils.gsonString(logEvent),"up", 0);

                if(is){
                    return Response.success();
                }
            }else{
                //SQL?????????????????????shell?????????sql-submit jar,????????????ds?????????????????????
                Map map = new HashMap(5);
                map.put("clusterAddress",clusterAddress);
                map.put("jobID",id);
                map.put("parallelism",parallelism);
                map.put("allowNrs",allowNrs);
                map.put("profilesActive",profilesActive);

                //???????????????????????????????????????????????????
                if(!tJob.getJobStatus().equals(JobStatusEnum.UNCOMMITTED.getStatus())){
                    map.put("savepointPath",savepointPath);
                }

                //????????????????????? ????????? ing
                tJob.setJobStatus(JobStatusEnum.STARTING.getStatus());
                updateById(tJob);

                //??????????????????
                Response<String> response = flinkApiService.runSQLJob(map);

                //??????????????????????????????????????????????????????
                if(response.isSuccess()){
                    return Response.success("??????????????????????????????");
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
        }catch (InterruptedException e) {
            e.printStackTrace();
        } catch (TemplateException e) {
            e.printStackTrace();
        }

        tJob.setJobStatus(JobStatusEnum.FAILED.getStatus());
        updateById(tJob);
        return Response.error(CodeEnum.JOB_START_ERROR);
    }

    /**
     * ?????????????????? ?????? (1??????????????????  2???????????????????????? ?????????  3????????????????????? ???)
     * @param cluster
     * @param tJob
     * @return
     */
    private Response checkEnv(TCluster cluster, TJob tJob) {

        LOGGER.info("????????????????????????????????????...begin...{}",tJob.getJobName());

       //step1??? ???????????????
        if(JobTypeEnum.JAR.getType().equals(tJob.getJobType())){
           //????????????jar???????????????
            Response<JarListInfo> jarListInfoResponse = null;
            try {
                jarListInfoResponse = flinkApiService.getJarLists(cluster.getAddress());
            } catch (Exception e) {
                e.printStackTrace();
            }
            if(null != jarListInfoResponse && jarListInfoResponse.isSuccess()){
                JarListInfo jarListInfo = jarListInfoResponse.getData();
                List<JarFileInfo> jarFileInfos = jarListInfo.getFiles();
                boolean exists = false;
                for (JarFileInfo jarFileInfo : jarFileInfos) {
                    if(jarFileInfo.getId().equals(tJob.getUseJar())){
                        exists = true;
                    }
                }
                if(!exists){
                    return Response.error(0,"?????????jar?????????????????????-"+tJob.getUseJar());
                }
            }else{
                return Response.error(0,"????????????????????????????????????");
            }
        }else{
            //step2???????????????????????? ?????????
            QueryWrapper<TJobDs> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("job_id",tJob.getId());
            List<TJobDs> tJobDsList = jobDsService.list(queryWrapper);

            long sourceCount = 0;
            if(null != tJobDsList){
                sourceCount = tJobDsList.stream().filter(tJobDs -> {
                    if(DsTypeEnum.SOURCE.getType().equals(tJobDs.getDsType())){
                        return true;
                    }
                    return false;
                }).count();
            }
            if(sourceCount < 1){
                return  Response.error(0,"???????????????-???????????????????????????");
            }

            for (TJobDs tJobDs : tJobDsList) {
                TDs tDs = dsService.getById(tJobDs.getDsId());
                if(null == tDs){
                    return  Response.error(0,"??????????????????????????????");
                }
                if(DsTypeEnum.SOURCE.getType().equals(tJobDs.getDsType())){
                    if(StrUtil.isEmpty(tDs.getDsDdl())){
                        return  Response.error(0,"?????????["+tDs.getDsName()+"]??????????????????????????????");
                    };
                }else if(DsTypeEnum.SIDE.getType().equals(tJobDs.getDsType())){
                    QueryWrapper<TDsJsonField> queryWrapper2 = new QueryWrapper();
                    queryWrapper2.eq("ds_id", tDs.getId());
                    TDsJsonField dsJsonField = dsJsonFieldService.getOne(queryWrapper2);
                    if(null == dsJsonField || StrUtil.isEmpty(dsJsonField.getJsonValue())){
                        return  Response.error(0,"?????????["+tDs.getDsName()+"]??????????????????????????????");
                    }
                    List<JsonField> jsonFields = GsonUtils.jsonToList(dsJsonField.getJsonValue(),JsonField.class);

                    boolean checkJsonFields =  dsService.checkJsonFields(jsonFields);
                    if (!checkJsonFields) {
                        return Response.error(CodeEnum.PARAM_ERROR, "?????????["+tDs.getDsName()+"]???????????????????????????");
                    }
                }

            }
            QueryWrapper<TJobDsSink> queryWrapper2 = new QueryWrapper<>();
            queryWrapper2.eq("job_id",tJob.getId());
            List<TJobDsSink> jobDsSinkList =  jobDsSinkService.list(queryWrapper2);

            if(null == jobDsSinkList || jobDsSinkList.size() < 1){
                return  Response.error(0,"???????????????-??????????????????????????????");
            }
            for (TJobDsSink tJobDsSink: jobDsSinkList) {
                String runSql = tJobDsSink.getRunSql();
                if(StrUtil.isEmpty(runSql)){
                    return  Response.error(0,"???????????????????????????????????????");
                }
                if(runSql.lastIndexOf(";") == runSql.length()-1){
                    return  Response.error(0,"???????????????????????????';'??????");
                }

                TDs tDs = dsService.getById(tJobDsSink.getDsId());
                if(null == tDs){
                    return  Response.error(0,"??????????????????????????????");
                }
                if(StrUtil.isEmpty(tDs.getDsDdl())){
                    return  Response.error(0,"?????????["+tDs.getDsName()+"]??????????????????????????????");
                };
            }

        }

        //step3?????????????????????
        if (null == cluster) {
            return Response.error(CodeEnum.CLUSTER_INFO_IS_NULL);
        }
        if(StrUtil.isEmpty(cluster.getAddress())){
            return  Response.error(0,"?????????????????????????????????");
        }
        okhttp3.Response response= null;
        try {
            response = OkHttpUtil.httpAccessibility(cluster.getAddress()+"/config",null);
        } catch (Exception e) {}
        if(response==null||!response.isSuccessful()){
            return  Response.error(0,"?????????????????????????????????");
        }

        //todo ??????????????????????????????


        return Response.success();
    }

    /**
     * ????????????
     * @param jobId
     * @return
     */
    @Override
    public Response cancel(Long jobId) {
        TJob jobDO = this.getById(jobId);
        if(jobDO==null){
            return Response.error(CodeEnum.JOB_NOT_FOUND);
        }
        if(!JobStatusEnum.RUNNING.getStatus().equals(jobDO.getJobStatus())){
            return Response.error(CodeEnum.JOB_NOT_RUNNINT);
        }
        try {
            TCluster tCluster=clusterService.getById(jobDO.getClusterId());
            String address=tCluster.getAddress();
            //?????????????????????????????????
            String savepointRootPath=jobDO.getStateSavepointsDir();
            if(StringUtils.isBlank(savepointRootPath)){
                Response<Map<String,Object>> configMapResponse=flinkApiService.getJobManagerConfig(address);
                if(!configMapResponse.isSuccess()){
                    return configMapResponse;
                }
                Map<String,Object> configMap=configMapResponse.getData();
                if(configMap!=null && configMap.get("state.savepoints.dir")!=null){
                    savepointRootPath= (String) configMap.get("state.savepoints.dir");
                }
            }
            //???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
            if(StringUtils.isNotBlank(savepointRootPath)){
                //?????????????????????????????????
                String triggerId=flinkApiService.terminateJobWithSavePoint(jobDO.getFlinkJobId(),savepointRootPath,address);
                jobDO.setJobStatus(JobStatusEnum.CANCELLING.getStatus());
                jobDO.setModifyTime(new Date());
                updateById(jobDO);
                //???????????????????????????????????????job
                flinkApiService.asyncGetJobSavepointStatus(jobId,triggerId,address);

            }else{
                flinkApiService.terminateJob(jobDO.getFlinkJobId(),address);
                jobDO.setJobStatus(JobStatusEnum.CANCELED.getStatus());
                updateById(jobDO);
            }

            LogEvent logEvent = new LogEvent();
            logEvent.setTimestamp(System.currentTimeMillis());
            logEvent.setMessage("???????????????");
            logEvent.setType("??????????????????");
            logEvent.setLevel(LogLevelEnum.INFO.name());

            Map tags = Maps.newLinkedHashMap();
            tags.put("URL",request.getRequestURL().toString());
            tags.put("IP",request.getRemoteAddr());
            tags.put("????????????","");
            logEvent.setTags(tags);
            jobLogService.sendLog(jobDO.getId(),GsonUtils.gsonString(logEvent),"append", 0);

            return Response.success();
        } catch (ApiException e) {
            e.printStackTrace();
            jobLogService.sendLog(jobId,"???????????????"+e.getMessage(),"append", 1);
            return Response.error(CodeEnum.JOB_CANCEL_ERROR);
        }
    }

    /**
     * ????????????
     * @param jobId
     * @return
     */
    @Override
    public Response overview(Long jobId) {
        String result=flinkApiService.getJobOverview(jobId);
        JsonArray jsonArray=JsonParser.parseString(result).getAsJsonArray();
        return Response.success(jsonArray);
    }

    /**
     * ????????????
     * @param jobVO ????????????
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public Response updateJob(JobVO jobVO) {

        Long id=jobVO.getId();
        if(id==null){
            return Response.error(CodeEnum.PARAM_ERROR);
        }
        TJob tJob=getById(id);
        if(tJob==null){
            return Response.error(CodeEnum.JOB_NOT_FOUND);
        }

        BeanUtils.copyProperties(jobVO,tJob);

        updateById(tJob);

        //??????SQL??????????????????????????????????????????
        if(JobTypeEnum.SQL.getType() == jobVO.getJobType().intValue()){

            //??????????????????????????????
            QueryWrapper<TJobDs> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("job_id",id);
            jobDsService.remove(queryWrapper);

            QueryWrapper<TJobDsSink> queryWrapper2 = new QueryWrapper<>();
            queryWrapper2.eq("job_id",id);
            jobDsSinkService.remove(queryWrapper2);

            List<JobDsVO> jobDsVOS = jobVO.getJobDsVOS();

            //???????????????????????????
            List<TJobDs> jobDsList = jobDsVOS.stream().filter(jobDsVO -> {
                if(!DsTypeEnum.SINK.getType().equals(jobDsVO.getDsType())){
                    return true;
                }
                return false;
            }).collect(Collectors.toList())
                    .stream().map(jobDsVO -> {
                        TJobDs jobDs = new TJobDs();
                        BeanUtils.copyProperties(jobDsVO,jobDs);
                        jobDs.setJobId(tJob.getId());

                        return jobDs;
                    }).collect(Collectors.toList());

            jobDsService.saveBatch(jobDsList);

            //?????????????????????
            List<TJobDsSink> jobDsSinkList = jobDsVOS.stream().filter(jobDsVO -> {
                if(DsTypeEnum.SINK.getType().equals(jobDsVO.getDsType())){
                    return true;
                }
                return false;
            }).collect(Collectors.toList())
                    .stream().map(jobDsVO -> {
                        TJobDsSink jobDsSink = new TJobDsSink();
                        BeanUtils.copyProperties(jobDsVO,jobDsSink);
                        jobDsSink.setJobId(tJob.getId());

                        return jobDsSink;
                    }).collect(Collectors.toList());

            jobDsSinkService.saveBatch(jobDsSinkList);

        }

        return Response.success();
    }

    /**
     * ????????????
     * @param jobId
     * @return
     */
    @Override
    public Response<JobVO> getJobByID(Long jobId) {

        TJob job = this.getById(jobId);

        if(null == job){
           return Response.error(404,"?????????????????????");
        }

        JobVO jobVO = new JobVO();
        BeanUtils.copyProperties(job,jobVO);

        //?????????SQL????????????????????????????????????
        if(JobTypeEnum.SQL.getType() == job.getJobType().intValue()){
            QueryWrapper<TJobDs> queryWrapper = new QueryWrapper<TJobDs>();
            queryWrapper.eq("job_id",jobId);
            List<TJobDs> jobDsList = jobDsService.list(queryWrapper);

            QueryWrapper<TJobDsSink> queryWrapper2 = new QueryWrapper<TJobDsSink>();
            queryWrapper2.eq("job_id",jobId);
            List<TJobDsSink> jobDsSinkList = jobDsSinkService.list(queryWrapper2);

           List<JobDsVO> jobDsVOS = jobDsList.stream().map(tJobDs -> {
                JobDsVO jobDsVO = new JobDsVO();
                BeanUtils.copyProperties(tJobDs,jobDsVO);
                return jobDsVO;
            }).collect(Collectors.toList());

            List<JobDsVO> jobDsVOS2 = jobDsSinkList.stream().map(tJobDs -> {
                JobDsVO jobDsVO = new JobDsVO();
                BeanUtils.copyProperties(tJobDs,jobDsVO);
                jobDsVO.setDsType(DsTypeEnum.SINK.getType());
                return jobDsVO;
            }).collect(Collectors.toList());

            jobDsVOS.addAll(jobDsVOS2);

            jobVO.setJobDsVOS(jobDsVOS);
        }

        return Response.success(jobVO);
    }

    /**
     * ??????
     * @param jobId
     * @return
     */
    @Override
    public Response restart(Long jobId) {

        Response res = this.cancel(jobId);
        if(res.isSuccess()){
            res = this.run(jobId);
        }
        return res;
    }

    /**
     * ???????????????
     * @param jobId
     * @return
     */
    @Override
    public Response triggerSavePoint(Long jobId) {
        TJob jobDO = this.getById(jobId);
        if(jobDO==null){
            return Response.error(CodeEnum.JOB_NOT_FOUND);
        }
        if(!JobStatusEnum.RUNNING.getStatus().equals(jobDO.getJobStatus())){
            return Response.error(CodeEnum.JOB_NOT_RUNNING_CANNOT_TRIGGER_SAVEPOINT);
        }
        if(StringUtils.isBlank(jobDO.getFlinkJobId())){
            return Response.error(CodeEnum.FLINK_JOB_ID_IS_EMPTY);
        }
        TCluster tCluster=clusterService.getById(jobDO.getClusterId());
        String address=tCluster.getAddress();
        //?????????????????????
        String savepointRootPath=jobDO.getStateSavepointsDir();
        if(StringUtils.isBlank(savepointRootPath)){
            //?????????????????????????????????
            Response<Map<String,Object>> configMapResponse=flinkApiService.getJobManagerConfig(address);
            if(!configMapResponse.isSuccess()){
                return configMapResponse;
            }
            Map<String,Object> configMap=configMapResponse.getData();
            //????????????????????????????????????????????????????????????,??????????????????
            if(configMap!=null && configMap.get("state.savepoints.dir")!=null) {
                savepointRootPath = (String) configMap.get("state.savepoints.dir");
            }
        }
        if(StringUtils.isBlank(savepointRootPath)){
            return Response.error(CodeEnum.SAVE_POINT_ROOT_PATH_IS_EMPTY);
        }

        //???????????????????????????????????????????????????
        Response response=flinkApiService.triggerSavepoint(jobDO.getFlinkJobId(),savepointRootPath,address);
        if(!response.isSuccess()){
            jobLogService.sendLog(jobId,GsonUtils.gsonString(response),"append", 1);
            return response;
        }
        String savepointPath= (String) response.getData();

        //???????????????????????????
        String savepointPathOrigin=jobDO.getSavepointPath();
        flinkApiService.triggerSavepointDisposal(savepointPathOrigin,address);

        //?????????????????????
        jobDO.setSavepointPath(savepointPath);
        jobDO.setModifyTime(new Date());
        updateById(jobDO);

        jobLogService.sendLog(jobId,"????????????????????????????????????????????????"+savepointPath,"append", 1);
        return Response.success();
    }

    /**
     * ??????????????????
     * @param jobId
     * @return
     */
    @Override
    public Response getLog(Long jobId) {
        TJob job = this.getById(jobId);

        if(null == job){
            return Response.error(404,"??????????????????????????????");
        }

        //??????flink api ????????????
        Response<JobExceptionsInfo> jobExceptionsInfoResponse = null;
        if(job.getClusterId() > 0 && StrUtil.isNotEmpty(job.getFlinkJobId())){
            TCluster cluster = clusterService.getById(job.getClusterId());
            try {
                jobExceptionsInfoResponse = flinkApiService.getJobExceptions(cluster.getAddress(),job.getFlinkJobId());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        //??????DB??????????????????
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("job_id",jobId);
        TJobLog jobLog = jobLogService.getOne(queryWrapper);

        StringBuffer sb = new StringBuffer();
        if(null != jobLog){
//            sb.append("\n???????????????\n");
            sb.append(jobLog.getJobLog());
        }
        if(null != jobExceptionsInfoResponse && jobExceptionsInfoResponse.isSuccess()){
            sb.append("\n ============================= \n Flink?????????????????????");
            JobExceptionsInfo jobExceptionsInfo = jobExceptionsInfoResponse.getData();
            String rootEx =  jobExceptionsInfo.getRootException();
            List<ExecutionExceptionInfo> executionExceptionInfos = jobExceptionsInfo.getAllExceptions();

            if(StrUtil.isNotEmpty(rootEx)){
                sb.append("\n RootException???\n").append(rootEx);
            }else{
                sb.append("No Root Exception");
            }
            if(executionExceptionInfos.size() > 0){
                sb.append("executionExceptionInfos???\n");
            }
            for (ExecutionExceptionInfo e: executionExceptionInfos) {
                sb.append(GsonUtils.gsonString(e));
            }
        }

        return Response.success(sb.toString());
    }

}
