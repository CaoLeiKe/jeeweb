package ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.service.impl;
<#macro id><#list columns as column><#if column.parmaryKey>${column.javaField}</#if></#list></#macro>
<#macro entityLowerName>${entityName?lower_case}</#macro>
<#macro entityCapName>${entityName?cap_first}</#macro>
<#macro entityLowerMapper>${entityName?lower_case}Mapper</#macro>

import ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.entity.<@entityCapName/>;
import ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.mapper.<@entityCapName/>Mapper;
import ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.service.<@entityCapName/>Service;

/**
 * @Title: ${functionName}
 * @Description: serviceImpl 实现类
 * @author ${functionAuthor}
 * @date ${time}
 */
@Transactional
public class <@entityCapName/>ServiceImpl implements <@entityCapName/>Service {

	@Autowired
	private <@entityCapName/>Mapper <@entityLowerName/>Mapper;

	@Override
	public int deleteByPrimaryKey(<@entityCapName/> <@entityLowerName/>) {
		return <@entityLowerMapper/>.deleteByPrimaryKey(<@entityLowerName/>);
	}

	@Override
	public int insertSelective(<@entityCapName/> <@entityLowerName/>) {
		return <@entityLowerMapper/>.insertSelective(<@entityLowerName/>);
	}

	@Override
	public int updateByPrimaryKey(<@entityCapName/> <@entityLowerName/>) {
		return <@entityLowerMapper/>.updateByPrimaryKey(<@entityLowerName/>);
	}

	@Override
	public int updateSelective(<@entityCapName/> <@entityLowerName/>) {
		return <@entityLowerMapper/>.updateSelective(<@entityLowerName/>);
	}

	@Override
	public <@entityCapName/> selectByPrimaryKey(Long <@id/>) {
		return <@entityLowerMapper/>.selectByPrimaryKey(<@id/>);
	}

	@Override
	public List<<@entityCapName/>> selectSelective(<@entityCapName/> <@entityLowerName/>) {
		return <@entityLowerMapper/>.selectSelective(<@entityLowerName/>);
	}

}
