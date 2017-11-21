package ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.controller;
<#macro idJava><#list columns as column><#if column.parmaryKey>${column.javaField}</#if></#list></#macro>
<#macro capIdJava><#list columns as column><#if column.parmaryKey>${column.javaField?cap_first}</#if></#list></#macro>
<#macro entityCapName>${entityName?cap_first}</#macro>
<#macro entityLowerName>${entityName?uncap_first}</#macro>
<#macro entityCapService>${entityName?cap_first}Service</#macro>
<#macro entityLowerService>${entityName?uncap_first}Service</#macro>

import ${packageName}.${moduleName}.entity.<@entityCapName/>;
import ${packageName}.${moduleName}.service.<@entityCapService/>;
import ${packageName}.${moduleName}.valid.Insert;
import ${packageName}.${moduleName}.valid.Update;
import com.github.pagehelper.PageInfo;
import com.richgo.common.CodeConts;
import com.richgo.util.Tool;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.tuple.Pair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

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
    public Map delete<@entityCapName/>(@ApiParam(value = "${functionName}主键", required = true) @RequestParam("<@idJava/>") Long <@idJava/>) {
        log.info("----------------${functionName}，删除${functionName}开始----------------");
        log.info("parameters0:{}", <@idJava/>);
        <@entityCapName/> <@entityLowerName/> = new <@entityCapName/>();
        <@entityLowerName/>.set<@capIdJava/>(<@idJava/>);
        Pair<Boolean, Object> pair = <@entityLowerService/>.deleteByPrimaryKey(<@entityLowerName/>);
        if (pair.getKey()) {
            log.info("result:{}" + pair.getValue());
            log.info("----------------${functionName}，删除${functionName}结束----------------");
            return Tool.resultMap(CodeConts.SUCCESS, "删除${functionName}成功！");
        }
        log.warn("result:{}" + pair.getValue());
        log.info("----------------${functionName}，删除${functionName}结束----------------");
        return Tool.resultMap(CodeConts.FAILURE, "删除${functionName}失败！");
    }

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(httpMethod = "POST", value = "添加${functionName}")
    public Map save<@entityCapName/>(@Validated(Insert.class) @ApiParam(name = "${functionName}实体") @ModelAttribute("<@entityLowerName/>") <@entityCapName/> <@entityLowerName/>) {
        log.info("----------------${functionName}，添加${functionName}开始----------------");
        log.info("parameters0:{}", <@entityLowerName/>);
        Pair<Boolean, Object> pair = <@entityLowerService/>.insertSelective(<@entityLowerName/>);
        if (pair.getKey()) {
            log.info("result:{}" + pair.getValue());
            log.info("----------------${functionName}，添加${functionName}结束----------------");
            return Tool.resultMap(CodeConts.SUCCESS, "添加${functionName}成功！");
        }
        log.info("result:{}" + pair.getValue());
        log.info("----------------${functionName}，添加${functionName}结束----------------");
        return Tool.resultMap(CodeConts.FAILURE, "添加${functionName}失败！");
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(httpMethod = "POST", value = "根据主键修改${functionName}")
    public Map update<@entityCapName/>(@Validated(Update.class) @ApiParam(name = "${functionName}实体") @ModelAttribute("<@entityLowerName/>") <@entityCapName/> <@entityLowerName/>) {
        log.info("----------------${functionName}，修改${functionName}开始----------------");
        log.info("parameters0:{}", <@entityLowerName/>);
        Pair<Boolean, Object> pair = <@entityLowerService/>.updateSelective(<@entityLowerName/>);
        if (pair.getKey()) {
            log.info("result:{}" + pair.getValue());
            log.info("----------------${functionName}，修改${functionName}结束----------------");
            return Tool.resultMap(CodeConts.SUCCESS, "删除${functionName}成功！");
        }
        log.info("result:{}" + pair.getValue());
        log.info("----------------${functionName}，修改${functionName}结束----------------");
        return Tool.resultMap(CodeConts.FAILURE, "修改${functionName}失败！");
    }

    @RequestMapping(value = "/get", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(httpMethod = "POST", value = "根据主键查询${functionName}")
    public Map get<@entityCapName/>(@ApiParam(value = "${functionName}主键", required = true) @RequestParam Long <@idJava/>) {
        log.info("----------------${functionName}，查询${functionName}开始----------------");
        log.info("parameters0:{}", <@idJava/>);
        Pair<Boolean, Object> pair = <@entityLowerService/>.selectByPrimaryKey(<@idJava/>);
        if (pair.getKey()) {
            log.info("result:{}" + pair.getValue());
            log.info("----------------${functionName}，查询${functionName}结束----------------");
            Map<String, Object> resultMap = Tool.resultMap(CodeConts.SUCCESS, "查询${functionName}成功！");
            resultMap.put("data", pair.getValue());
            return resultMap;
        }
        log.info("result:{}" + pair.getValue());
        log.info("----------------${functionName}，${functionName}结束----------------");
        if (CodeConts.DATA_IS_NUll.equals(pair.getValue())) {
            return Tool.resultMap(CodeConts.DATA_IS_NUll, "数据为空！");
        } else {
            return Tool.resultMap(CodeConts.FAILURE, "查询失败！");
        }
    }

    @RequestMapping(value = "/selectList", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(httpMethod = "POST", value = "根据条件分页查询${functionName}")
    public Map selectListByPage(@ApiParam(value = "${functionName}实体") @ModelAttribute("<@entityLowerName/>") <@entityCapName/> <@entityLowerName/>,
                                @ApiParam(value = "分页页码") @RequestParam(defaultValue = "1") Integer pageNum,
                                @ApiParam(value = "每页条目数") @RequestParam(defaultValue = "10") Integer pageSize) {
        log.info("----------------${functionName}，查询${functionName}开始----------------");
        log.info("parameters0:{}", <@idJava/>);
        log.info("parameters1:{}", pageNum);
        log.info("parameters2:{}", pageSize);
        Pair<Boolean, Object> pair = <@entityLowerService/>.selectSelective(<@idJava/>, pageNum, pageSize);
        if (pair.getKey()) {
            log.info("result:{}" + pair.getValue());
            log.info("----------------${functionName}，分页查询${functionName}结束----------------");
            Map<String, Object> resultMap = Tool.resultMap(CodeConts.SUCCESS, "分页查询${functionName}成功！");
            PageInfo pageInfo = (PageInfo) pair.getValue();
            resultMap.put("data", pageInfo.getList());
            resultMap.put("total", pageInfo.getTotal());
            return resultMap;
        }
        log.info("result:{}" + pair.getValue());
        log.info("----------------${functionName}，分页查询${functionName}结束----------------");
        if (CodeConts.DATA_IS_NUll.equals(pair.getValue())) {
            return Tool.resultMap(CodeConts.DATA_IS_NUll, "数据为空！");
        } else {
            return Tool.resultMap(CodeConts.FAILURE, "查询失败！");
        }
    }
}
