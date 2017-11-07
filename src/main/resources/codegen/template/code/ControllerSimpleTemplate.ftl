package ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.controller;
<#macro idJava><#list columns as column><#if column.parmaryKey>${column.javaField}</#if></#list></#macro>
<#macro capIdJava><#list columns as column><#if column.parmaryKey>${column.javaField?cap_first}</#if></#list></#macro>
<#macro entityCapName>${entityName?cap_first}</#macro>
<#macro entityLowerName>${entityName?lower_case}</#macro>
<#macro entityCapService>${entityName?cap_first}Service</#macro>
<#macro entityLowerService>${entityName?lower_case}Service</#macro>

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
@Api(description = "${functionName}api")
@Slf4j
public class <@entityCapName/>Controller {

	/**
	 * ${functionName}Service
	 */
	@Autowired
	private <@entityCapService/> <@entityLowerService/>;

	@RequestMapping(value = "/deleteByPrimaryKey", method = RequestMethod.POST)
	@ResponseBody
	@ApiOperation(httpMethod = "POST", value = "根据主键删除${functionName}")
	public Map deleteByPrimaryKey(@ApiParam(value = "${functionName}主键", required = true) @RequestParam("<@idJava/>") Long <@idJava/>) {
		log.info("----------------${functionName}，删除${functionName}开始----------------");
		log.info("parameters0:{}", <@idJava/>Id);
		<@entityCapName/> <@entityLowerName/> = new <@entityCapName/>();
		<@idJava/>.set<@capIdJava/>(<@idJava/>);
		Pair<Boolean, Object> pair = <@entityLowerService/>.deleteByPrimaryKey(<@idJava/>);
		if (pair.getKey()) {
			log.info("result:{}" + pair.getValue());
			log.info("----------------${functionName}，删除${functionName}结束----------------");
			return Tool.resultMap(CodeConts.SUCCESS, "删除${functionName}成功！");
		}
		log.warn("result:{}" + pair.getValue());
		log.info("----------------${functionName}，删除${functionName}结束----------------");
		return Tool.resultMap(CodeConts.FAILURE, pair.getValue().toString());
	}

	@RequestMapping(value = "/insertSelective", method = RequestMethod.POST)
	@ResponseBody
	@ApiOperation(httpMethod = "POST", value = "新增${functionName}")
	public Map insertSelective(@Validated(First.class) @ApiParam(name = "${functionName}实体") @ModelAttribute("<@idJava/>") <@entityCapName/> <@idJava/>) {
		log.info("----------------${functionName}，新增${functionName}开始----------------");
		log.info("parameters0:{}", <@idJava/>);
		Pair<Boolean, Object> pair = <@entityLowerService/>.insertSelective(<@idJava/>);
		if (pair.getKey()) {
			log.info("result:{}" + pair.getValue());
			log.info("----------------${functionName}，新增${functionName}结束----------------");
			return Tool.resultMap(CodeConts.SUCCESS, "新增${functionName}成功！");
		}
		log.info("result:{}" + pair.getValue());
		log.info("----------------${functionName}，新增${functionName}结束----------------");
		return Tool.resultMap(CodeConts.FAILURE, pair.getValue().toString());
	}

	@RequestMapping(value = "/updateByPrimaryKey", method = RequestMethod.POST)
	@ResponseBody
	@ApiOperation(httpMethod = "POST", value = "根据主键修改${functionName}")
	public Map updateByPrimaryKey(@Validated(value = {Second.class}) @ApiParam(name = "${functionName}实体") @ModelAttribute("<@idJava/>") <@entityCapName/> <@idJava/>) {
		log.info("----------------${functionName}，修改${functionName}开始----------------");
		log.info("parameters0:{}", <@idJava/>);
		Pair<Boolean, Object> pair = <@entityLowerService/>.updateByPrimaryKey(<@idJava/>);
		if (pair.getKey()) {
			log.info("result:{}" + pair.getValue());
			log.info("----------------${functionName}，修改${functionName}结束----------------");
			return Tool.resultMap(CodeConts.SUCCESS, "删除${functionName}成功！");
		}
		log.info("result:{}" + pair.getValue());
		log.info("----------------${functionName}，修改${functionName}结束----------------");
		return Tool.resultMap(CodeConts.FAILURE, pair.getValue().toString());
	}

	@RequestMapping(value = "/updateSelective", method = RequestMethod.POST)
	@ResponseBody
	@ApiOperation(httpMethod = "POST", value = "根据条件修改${functionName}")
	public Map updateSelective(@ApiParam(name = "${functionName}实体") @ModelAttribute("<@idJava/>") <@entityCapName/> <@idJava/>) {
		log.info("----------------${functionName}，修改${functionName}开始----------------");
		log.info("parameters0:{}", <@idJava/>);
		Pair<Boolean, Object> pair = <@entityLowerService/>.updateSelective(<@idJava/>);
		if (pair.getKey()) {
			log.info("result:{}" + pair.getValue());
			log.info("----------------${functionName}，修改${functionName}结束----------------");
			return Tool.resultMap(CodeConts.SUCCESS, "删除${functionName}成功！");
		}
		log.info("result:{}" + pair.getValue());
		log.info("----------------${functionName}，修改${functionName}结束----------------");
		return Tool.resultMap(CodeConts.FAILURE, pair.getValue().toString());
	}

	@RequestMapping(value = "/selectByPrimaryKey", method = RequestMethod.POST)
	@ResponseBody
	@ApiOperation(httpMethod = "POST", value = "根据主键查询${functionName}")
	public Map selectByPrimaryKey(@ApiParam(value = "${functionName}主键", required = true) @RequestParam Long <@idJava/>Id) {
		log.info("----------------${functionName}，查询${functionName}开始----------------");
		log.info("parameters0:{}", <@idJava/>Id);
		Pair<Boolean, Object> pair = <@entityLowerService/>.selectByPrimaryKey(<@idJava/>Id);
		if (pair.getKey()) {
			log.info("result:{}" + pair.getValue());
			log.info("----------------${functionName}，查询${functionName}结束----------------");
			Map<String, Object> resultMap = Tool.resultMap(CodeConts.SUCCESS, "查询${functionName}成功！");
			resultMap.put("data", pair.getValue());
			return resultMap;
		}
		log.info("result:{}" + pair.getValue());
		log.info("----------------${functionName}，${functionName}结束----------------");
		return Tool.resultMap(CodeConts.DATA_IS_NUll, pair.getValue().toString());
	}

	@RequestMapping(value = "/selectSelective", method = RequestMethod.POST)
	@ResponseBody
	@ApiOperation(httpMethod = "POST", value = "根据条件分页查询${functionName}")
	public Map selectSelective(@ApiParam(value = "${functionName}实体") @ModelAttribute("<@idJava/>") <@entityCapName/> <@idJava/>,
	                           @ApiParam(value = "分页页码") @RequestParam(defaultValue = "1") Integer pageNum,
	                           @ApiParam(value = "每页条目数") @RequestParam(defaultValue = "10") Integer pageSize) {
		log.info("----------------${functionName}，查询${functionName}开始----------------");
		log.info("parameters0:{}", <@idJava/>);
		Pair<Boolean, Object> pair = <@entityLowerService/>.selectSelective(<@idJava/>, pageNum, pageSize);
		if (pair.getKey()) {
		log.info("result:{}" + pair.getValue());
		log.info("----------------${functionName}，分页查询${functionName}结束----------------");
		Map<String, Object> resultMap = Tool.resultMap(CodeConts.SUCCESS, "分页查询${functionName}成功！");
			resultMap.put("data", pair.getValue());
			resultMap.put("total", ((List) (pair.getValue())).size());
			return resultMap;
		}
		log.info("result:{}" + pair.getValue());
		log.info("----------------${functionName}，分页查询${functionName}结束----------------");
		return Tool.resultMap(CodeConts.DATA_IS_NUll, pair.getValue().toString());
	}
}
