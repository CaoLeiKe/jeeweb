package ${packageName}.${moduleName}.agency.controller;
<#macro idJava><#list columns as column><#if column.parmaryKey>${column.javaField}</#if></#list></#macro>
<#macro idCapJava><#list columns as column><#if column.parmaryKey>${column.javaField?cap_first}</#if></#list></#macro>
<#macro capIdJava><#list columns as column><#if column.parmaryKey>${column.javaField?cap_first}</#if></#list></#macro>
<#macro entityCapName>${entityName?cap_first}</#macro>
<#macro entityLowerName>${entityName?uncap_first}</#macro>
<#macro entityCapNameEntity>${entityName?cap_first}Entity</#macro>
<#macro entityLowerNameEntity>${entityName?uncap_first}Entity</#macro>
<#macro entityCapService>${entityName?cap_first}Service</#macro>
<#macro entityLowerService>${entityName?uncap_first}Service</#macro>
<#macro idJavaType><#list columns as column><#if column.parmaryKey>${column.javaType}</#if></#list></#macro>
<#macro entityCapNameParam>${entityName?cap_first}Param</#macro>
<#macro entityLowerNameParam>${entityName?uncap_first}Param</#macro>
<#macro entityNameToSpace><#list 0..entityName?length as i> </#list></#macro>

import ${packageName}.${moduleName}.agency.common.base.BaseResponse;
import ${packageName}.${moduleName}.agency.common.valid.Insert;
import ${packageName}.${moduleName}.agency.common.valid.Update;
import ${packageName}.${moduleName}.natives.api.entity.<@entityCapNameEntity/>;
import ${packageName}.${moduleName}.natives.api.params.<@entityCapNameParam/>;
import ${packageName}.${moduleName}.natives.api.service.<@entityCapService/>;
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

import javax.validation.groups.Default;
import java.util.List;

/**
 * @Title: ${functionName}
 * @Description: Controller层
 * @author ${functionAuthor}
 * @date ${time}
 */
@Controller
@RequestMapping("api/<@entityLowerName/>")
@Api(tags = "${functionName}api")
@Slf4j
public class <@entityCapName/>Controller {

    /**
     * ${functionName}Service
     */
    @Autowired
    private <@entityCapService/> <@entityLowerService/>;
<#--
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
    } -->

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(httpMethod = "POST", value = "添加${functionName}")
    public BaseResponse save<@entityCapName/>(@ApiParam(name = "${functionName}实体") @ModelAttribute("<@entityLowerNameParam/>") @Validated(Insert.class) <@entityCapNameParam/> <@entityLowerNameParam/>) {
        log.info("----------------${functionName}，添加${functionName}开始----------------");
        log.info("<@entityLowerNameParam/>:{}", <@entityLowerNameParam/>);
        long rowCount = <@entityLowerService/>.insertSelective(<@entityLowerNameParam/>);
        if (rowCount == 1) {
            log.info("result:{}" + rowCount);
            log.info("----------------${functionName}，添加${functionName}结束----------------");
            return BaseResponse.successCustom("添加${functionName}成功！").setData(<@entityLowerNameParam/>.get<@idCapJava/>()).build();
        }
        log.info("result:{}" + rowCount);
        log.info("----------------${functionName}，添加${functionName}结束----------------");
        return BaseResponse.failedCustom("添加${functionName}失败！").build();
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(httpMethod = "POST", value = "根据主键修改${functionName}")
    public BaseResponse update<@entityCapName/>(@ApiParam(name = "${functionName}实体") @ModelAttribute("<@entityLowerNameParam/>") @Validated(Update.class) <@entityCapNameParam/> <@entityLowerNameParam/>) {
        log.info("----------------${functionName}，修改${functionName}开始----------------");
        log.info("<@entityLowerNameParam/>:{}", <@entityLowerNameParam/>);
        long rowCount = <@entityLowerService/>.updateSelective(<@entityLowerNameParam/>);
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
    public BaseResponse get<@entityCapName/>(@ApiParam(value = "${functionName}主键") @RequestParam <@idJavaType/> <@idJava/>) {
        log.info("----------------${functionName}，查询${functionName}开始----------------");
        log.info("<@idJava/>:{}", <@idJava/>);
        <@entityCapNameEntity/> <@entityLowerNameEntity/> = <@entityLowerService/>.selectByPrimaryKey(<@idJava/>);
        log.info("result:{}" + <@entityLowerNameEntity/>);
        log.info("----------------${functionName}，查询${functionName}结束----------------");
        return BaseResponse.successCustom("查询${functionName}成功！").setData(<@entityLowerNameEntity/>).build();
    }

    @RequestMapping(value = "/list", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(httpMethod = "POST", value = "根据条件查询${functionName}")
    public BaseResponse get<@entityCapName/>List(@ApiParam(value = "${functionName}实体") @ModelAttribute("<@entityLowerNameParam/>") @Validated(Default.class) <@entityCapNameParam/> <@entityLowerNameParam/>) {
        log.info("----------------${functionName}，查询${functionName}开始----------------");
        log.info("<@entityLowerNameParam/>:{}", <@entityLowerNameParam/>);
        List<<@entityCapNameEntity/>> <@entityLowerNameEntity/>s = <@entityLowerService/>.selectSelective(<@entityLowerNameParam/>);
        log.info("result:{}" + <@entityLowerNameEntity/>s);
        log.info("----------------${functionName}，查询${functionName}结束----------------");
        return BaseResponse.successCustom("查询${functionName}成功！").setData(<@entityLowerNameEntity/>s).build();
    }

    @RequestMapping(value = "/listByPage", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(httpMethod = "POST", value = "根据条件分页查询${functionName}")
    public BaseResponse get<@entityCapName/>ListByPage(@ApiParam(value = "${functionName}实体") @ModelAttribute("<@entityLowerNameParam/>") @Validated(Default.class) <@entityCapNameParam/> <@entityLowerNameParam/>,
                                     <@entityNameToSpace/>@ApiParam(value = "分页页码") @RequestParam(defaultValue = "1") Integer pageNum,
                                     <@entityNameToSpace/>@ApiParam(value = "每页条目数") @RequestParam(defaultValue = "10") Integer pageSize) {
        log.info("----------------${functionName}，查询${functionName}开始----------------");
        log.info("<@entityLowerNameParam/>:{}", <@entityLowerNameParam/>);
        log.info("pageNum:{}", pageNum);
        log.info("pageSize:{}", pageSize);
        List<<@entityCapNameEntity/>> <@entityLowerNameEntity/>s = <@entityLowerService/>.selectSelectiveByPage(<@entityLowerNameParam/>, pageNum, pageSize);
        log.info("result:{}" + <@entityLowerNameEntity/>s);
        log.info("----------------${functionName}，分页查询${functionName}结束----------------");
        return BaseResponse.successCustom("分页查询${functionName}成功！").setData(new PageInfo<>(<@entityLowerNameEntity/>s)).build();
    }
}
