package ${packageName}.${moduleName}.agency.controller;
<#macro idJava><#list columns as column><#if column.parmaryKey>${column.javaField}</#if></#list></#macro>
<#macro idCapJava><#list columns as column><#if column.parmaryKey>${column.javaField?cap_first}</#if></#list></#macro>
<#macro capIdJava><#list columns as column><#if column.parmaryKey>${column.javaField?cap_first}</#if></#list></#macro>
<#list columns as column>
    <#if column.javaField?lower_case?contains("createname")><#assign createName=column.javaField/></#if>
    <#if column.javaField?lower_case?contains("createid")><#assign createId=column.javaField/></#if>
    <#if column.javaField?lower_case?contains("updatename")><#assign updateName=column.javaField/></#if>
    <#if column.javaField?lower_case?contains("updateid")><#assign updateId=column.javaField/></#if>
</#list>
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
import ${packageName}.${moduleName}.agency.common.base.ListBean;
import ${packageName}.${moduleName}.agency.common.constant.InsuranceConstant;
import ${packageName}.${moduleName}.agency.common.valid.Insert;
import ${packageName}.${moduleName}.agency.common.valid.Update;
import ${packageName}.${moduleName}.natives.api.entity.<@entityCapNameEntity/>;
import ${packageName}.${moduleName}.natives.api.params.<@entityCapNameParam/>;
import ${packageName}.${moduleName}.natives.api.service.<@entityCapService/>;
import com.github.pagehelper.PageInfo;
import com.user.entity.emp.Emp;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.groups.Default;
import java.util.List;

/**
 * @Title: ${functionName}
 * @Description: Controller层
 * @Author ${functionAuthor}
 * @Date ${time}
 */
@Controller
@RequestMapping("api/<@entityLowerName/>")
@Api(tags = "${functionName}api")
@Slf4j
public class <@entityCapName/>Controller {

    /** ${functionName}Service */
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

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(httpMethod = "POST", value = "添加${functionName}")
    public BaseResponse add<@entityCapName/>(@ApiParam(name = "${functionName}实体") @ModelAttribute("<@entityLowerNameParam/>") @Validated(Insert.class) <@entityCapNameParam/> <@entityLowerNameParam/>,
                           <@entityNameToSpace/>@RequestAttribute(InsuranceConstant.REQUEST_EMP_INFO) Emp emp) {
        log.info("----------------${functionName}，添加${functionName}开始----------------");
        log.info("<@entityLowerNameParam/>:{}", <@entityLowerNameParam/>);

        // 新建人信息
        String empCode = emp.getCode();
        String empName = emp.getName();
        <@entityLowerNameParam/>.set${createId?cap_first}(empCode);
        <@entityLowerNameParam/>.set${createName?cap_first}(empName);
        <@entityLowerNameParam/>.set${updateId?cap_first}(empCode);
        <@entityLowerNameParam/>.set${updateName?cap_first}(empName);

        long rowCount = <@entityLowerService/>.insert(<@entityLowerNameParam/>);
        if (rowCount == 1) {
            log.info("rowCount:{}" + rowCount);
            log.info("----------------${functionName}，添加${functionName}结束----------------");
            return BaseResponse.successCustom("添加${functionName}成功！").setData(<@entityLowerNameParam/>.get<@idCapJava/>()).build();
        }
        log.info("rowCount:{}" + rowCount);
        log.info("----------------${functionName}，添加${functionName}结束----------------");
        return BaseResponse.failedCustom("添加${functionName}失败！").build();
    }

    @RequestMapping(value = "/addList", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(httpMethod = "POST", value = "批量添加${functionName}")
    public BaseResponse add<@entityCapName/>s(@ApiParam(name = "${functionName}实体") @RequestBody @Validated(Insert.class) ListBean<<@entityCapNameParam/>> <@entityLowerNameParam/>List,
                            <@entityNameToSpace/>@RequestAttribute(InsuranceConstant.REQUEST_EMP_INFO) Emp emp) {
        log.info("----------------${functionName}，添加${functionName}开始----------------");
        List<<@entityCapNameParam/>> <@entityLowerNameParam/>s = <@entityLowerNameParam/>List.getParams();

        // 新建人信息
        String empCode = emp.getCode();
        String empName = emp.getName();
        for (<@entityCapNameParam/> <@entityLowerNameParam/> : <@entityLowerNameParam/>s) {
            <@entityLowerNameParam/>.set${createId?cap_first}(empCode);
            <@entityLowerNameParam/>.set${createName?cap_first}(empName);
            <@entityLowerNameParam/>.set${updateId?cap_first}(empCode);
            <@entityLowerNameParam/>.set${updateName?cap_first}(empName);
        }

        log.info("<@entityLowerNameParam/>s:{}", <@entityLowerNameParam/>s);
        long rowCount = <@entityLowerService/>.batchInsert(<@entityLowerNameParam/>s);
        if (rowCount == <@entityLowerNameParam/>s.size()) {
            log.info("rowCount:{}" + rowCount);
            log.info("----------------${functionName}，添加${functionName}结束----------------");
            return BaseResponse.successCustom("共添加" + rowCount + "个${functionName}！").build();
        }
        log.info("rowCount:{}" + rowCount);
        log.info("----------------${functionName}，添加${functionName}结束----------------");
        return BaseResponse.failedCustom("添加${functionName}数量不匹配！").build();
    }

    @RequestMapping(value = "/modify", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(httpMethod = "POST", value = "根据主键修改${functionName}")
    public BaseResponse modify<@entityCapName/>(@ApiParam(name = "${functionName}实体") @ModelAttribute("<@entityLowerNameParam/>") @Validated(Update.class) <@entityCapNameParam/> <@entityLowerNameParam/>) {
        log.info("----------------${functionName}，修改${functionName}开始----------------");
        log.info("<@entityLowerNameParam/>:{}", <@entityLowerNameParam/>);
        long rowCount = <@entityLowerService/>.updateSelective(<@entityLowerNameParam/>);
        if (rowCount == 1) {
            log.info("rowCount:{}" + rowCount);
            log.info("----------------${functionName}，修改${functionName}结束----------------");
            return BaseResponse.successCustom("删除${functionName}成功！").build();
        }
        log.info("rowCount:{}" + rowCount);
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
        log.info("<@entityLowerNameEntity/>:{}" + <@entityLowerNameEntity/>);
        log.info("----------------${functionName}，查询${functionName}结束----------------");
        return BaseResponse.successCustom("查询${functionName}成功！").setData(<@entityLowerNameEntity/>).build();
    }

    @RequestMapping(value = "/searchByPage", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(httpMethod = "POST", value = "根据条件分页查询${functionName}")
    @ApiImplicitParams({
            @ApiImplicitParam(value = "字段描述", name = "字段名", dataType = "string | long", paramType = "query"),
            @ApiImplicitParam(value = "分页页码", name = "pageNum", dataType = "int", paramType = "query"),
            @ApiImplicitParam(value = "每页条目数", name = "pageSize", dataType = "int", paramType = "query")
    })
    public BaseResponse search<@entityCapName/>ByPage(@Validated(Default.class) <@entityCapNameParam/> <@entityLowerNameParam/>,
                                    <@entityNameToSpace/>@RequestParam(defaultValue = "1") Integer pageNum,
                                    <@entityNameToSpace/>@RequestParam(defaultValue = "10") Integer pageSize) {
        log.info("----------------${functionName}，查询${functionName}开始----------------");
        log.info("<@entityLowerNameParam/>:{}", <@entityLowerNameParam/>);
        log.info("pageNum:{}", pageNum);
        log.info("pageSize:{}", pageSize);
        PageInfo<<@entityCapNameEntity/>> result = <@entityLowerService/>.selectSelectiveByPage(<@entityLowerNameParam/>, pageNum, pageSize);
        log.info("result:{}" + result);
        log.info("----------------${functionName}，分页查询${functionName}结束----------------");
        return BaseResponse.successCustom("分页查询${functionName}成功！").setData(result).build();
    }
}
