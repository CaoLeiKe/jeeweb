package ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.controller;
<#macro idJava><#list columns as column><#if column.parmaryKey>${column.javaField}</#if></#list></#macro>
<#macro idCapJava><#list columns as column><#if column.parmaryKey>${column.javaField?cap_first}</#if></#list></#macro>
<#macro capIdJava><#list columns as column><#if column.parmaryKey>${column.javaField?cap_first}</#if></#list></#macro>
<#macro entityCapName>${entityName?cap_first}</#macro>
<#macro entityLowerName>${entityName?uncap_first}</#macro>
<#macro entityCapService>${entityName?cap_first}Service</#macro>
<#macro entityLowerService>${entityName?uncap_first}Service</#macro>

import ${packageName}.${moduleName}.entity.<@entityCapName/>;
import ${packageName}.${moduleName}.service.<@entityCapService/>;
import ${packageName}.${moduleName}.valid.Insert;
import ${packageName}.${moduleName}.valid.Update;
import com.chtwm.insurance.agency.common.base.BaseResponse;
import com.github.pagehelper.PageInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Title: ${functionName}
 * @Description: Controller层
 * @author ${functionAuthor}
 * @date ${time}
 */
@Controller
@RequestMapping("<@entityLowerName/>")
@Api(description = "${functionName}api")
@Slf4j
public class <@entityCapName/>Controller {

    /**
     * ${functionName}Service
     */
    @Autowired
    private <@entityCapService/> <@entityLowerService/>;

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(httpMethod = "POST", value = "根据主键删除${functionName}")
    public BaseResponse delete<@entityCapName/>(@ApiParam(value = "${functionName}主键", required = true) @RequestParam("<@idJava/>") Long <@idJava/>) {
        log.info("----------------${functionName}，删除${functionName}开始----------------");
        log.info("parameters0:{}", <@idJava/>);
        <@entityCapName/> <@entityLowerName/> = new <@entityCapName/>();
        <@entityLowerName/>.set<@capIdJava/>(<@idJava/>);
        long rowCount = <@entityLowerService/>.deleteByPrimaryKey(<@entityLowerName/>);
        if (rowCount == 1) {
            log.info("result:{}" + rowCount);
            log.info("----------------${functionName}，删除${functionName}结束----------------");
            return BaseResponse.successCustom("删除${functionName}成功！").build();
        }
        log.warn("result:{}" + rowCount);
        log.info("----------------${functionName}，删除${functionName}结束----------------");
        return BaseResponse.failedCustom("删除${functionName}失败！").build();
    }

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(httpMethod = "POST", value = "添加${functionName}")
    public BaseResponse save<@entityCapName/>(@ApiParam(name = "${functionName}实体") @ModelAttribute("<@entityLowerName/>") @Validated(Insert.class) <@entityCapName/> <@entityLowerName/>) {
        log.info("----------------${functionName}，添加${functionName}开始----------------");
        log.info("parameters0:{}", <@entityLowerName/>);
        long rowCount = <@entityLowerService/>.insertSelective(<@entityLowerName/>);
        if (rowCount == 1) {
            log.info("result:{}" + rowCount);
            log.info("----------------${functionName}，添加${functionName}结束----------------");
            return BaseResponse.successCustom("添加${functionName}成功！").setObj(<@entityLowerName/>.get<@idCapJava/>).build();
        }
        log.info("result:{}" + rowCount);
        log.info("----------------${functionName}，添加${functionName}结束----------------");
        return BaseResponse.failedCustom("添加${functionName}失败！").build();
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(httpMethod = "POST", value = "根据主键修改${functionName}")
    public BaseResponse update<@entityCapName/>(@ApiParam(name = "${functionName}实体") @ModelAttribute("<@entityLowerName/>") @Validated(Update.class) <@entityCapName/> <@entityLowerName/>) {
        log.info("----------------${functionName}，修改${functionName}开始----------------");
        log.info("parameters0:{}", <@entityLowerName/>);
        long rowCount = <@entityLowerService/>.updateSelective(<@entityLowerName/>);
        if (rowCount == 1) {
            log.info("result:{}" + rowCount);
            log.info("----------------${functionName}，修改${functionName}结束----------------");
            return BaseResponse.successCustom("删除${functionName}成功！").build();
        }
        log.info("result:{}" + rowCount);
        log.info("----------------${functionName}，修改${functionName}结束----------------");
        return BaseResponse.failedCustom("修改${functionName}失败！").build();
    }

    @RequestMapping(value = "/get", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(httpMethod = "POST", value = "根据主键查询${functionName}")
    public BaseResponse get<@entityCapName/>(@ApiParam(value = "${functionName}主键", required = true) @RequestParam Long <@idJava/>) {
        log.info("----------------${functionName}，查询${functionName}开始----------------");
        log.info("parameters0:{}", <@idJava/>);
        <@entityCapName/> <@entityLowerName/> = <@entityLowerService/>.selectByPrimaryKey(<@idJava/>);
        if (<@entityLowerName/> != null) {
            log.info("result:{}" + <@entityLowerName/>);
            log.info("----------------${functionName}，查询${functionName}结束----------------");
            return BaseResponse.successCustom("查询${functionName}成功！").setObj(<@entityLowerName/>).build();
        }
        log.info("result:{}" + <@entityLowerName/>);
        log.info("----------------${functionName}，${functionName}结束----------------");
        return BaseResponse.successCustom("查询${functionName}结果为空！").setObj(<@entityLowerName/>).build();
    }

    @RequestMapping(value = "/selectList", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(httpMethod = "POST", value = "根据条件分页查询${functionName}")
    public BaseResponse selectListByPage(@ApiParam(value = "${functionName}实体") @ModelAttribute("<@entityLowerName/>") <@entityCapName/> <@entityLowerName/>,
                                         @ApiParam(value = "分页页码") @RequestParam(defaultValue = "1") Integer pageNum,
                                         @ApiParam(value = "每页条目数") @RequestParam(defaultValue = "10") Integer pageSize) {
        log.info("----------------${functionName}，查询${functionName}开始----------------");
        log.info("parameters0:{}", <@entityLowerName/>);
        log.info("parameters1:{}", pageNum);
        log.info("parameters2:{}", pageSize);
        List<<@entityCapName/>> <@entityLowerName/>s = <@entityLowerService/>.selectSelective(<@entityLowerName/>, pageNum, pageSize);
        if (<@entityLowerName/>s != null && <@entityLowerName/>s.size() != 0) {
            log.info("result:{}" + <@entityLowerName/>s);
            log.info("----------------${functionName}，分页查询${functionName}结束----------------");
            PageInfo pageInfo = new PageInfo<>(<@entityLowerName/>s);
            BaseResponse result = BaseResponse.successCustom("分页查询${functionName}成功！").setObj(pageInfo.getList()).addParam("total", pageInfo.getTotal());
            return result.builder();
        }
        log.info("result:{}" + <@entityLowerName/>s);
        log.info("----------------${functionName}，分页查询${functionName}结束----------------");
        BaseResponse result = BaseResponse.successCustom("分页查询${functionName}结果为空！").setObj(pageInfo.getList()).addParam("total", pageInfo.getTotal());
        return result.builder();
    }
}
