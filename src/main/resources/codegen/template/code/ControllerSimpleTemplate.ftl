package ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.controller;
<#macro entityCapName>${entityName?cap_first}</#macro>
<#macro entityLowerName>${entityName?lower_case}</#macro>

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.entity.<@entityCapName/>;

/**   
 * @Title: ${functionName}
 * @Description: Controller层
 * @author ${functionAuthor}
 * @date ${time}
 */
@Controller
@RequestMapping("${moduleName}/<@entityLowerName/>")
@Api(description = "${functionAuthor}api")
@Slf4j
public class <@entityCapName/>Controller {

}
