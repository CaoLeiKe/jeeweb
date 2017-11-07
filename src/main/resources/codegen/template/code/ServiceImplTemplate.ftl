package ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.service.impl;
<#macro idJava><#list columns as column><#if column.parmaryKey>${column.javaField}</#if></#list></#macro>
<#macro entityLowerName>${entityName?lower_case}</#macro>
<#macro entityCapName>${entityName?cap_first}</#macro>
<#macro entityLowerMapper>${entityName?lower_case}Mapper</#macro>

import ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.entity.<@entityCapName/>;
import ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.mapper.<@entityCapName/>Mapper;
import ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.service.<@entityCapName/>Service;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

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
	public long deleteByPrimaryKey(<@entityCapName/> <@entityLowerName/>) {
		return <@entityLowerMapper/>.deleteByPrimaryKey(<@entityLowerName/>);
	}

	@Override
	public long insertSelective(<@entityCapName/> <@entityLowerName/>) {
		return <@entityLowerMapper/>.insertSelective(<@entityLowerName/>);
	}

	@Override
	public long updateByPrimaryKey(<@entityCapName/> <@entityLowerName/>) {
		return <@entityLowerMapper/>.updateByPrimaryKey(<@entityLowerName/>);
	}

	@Override
	public long updateSelective(<@entityCapName/> <@entityLowerName/>) {
		return <@entityLowerMapper/>.updateSelective(<@entityLowerName/>);
	}

	@Override
	public <@entityCapName/> selectByPrimaryKey(Long <@idJava/>) {
		return <@entityLowerMapper/>.selectByPrimaryKey(<@idJava/>);
	}

	@Override
	public List<<@entityCapName/>> selectSelective(<@entityCapName/> <@entityLowerName/>) {
		return <@entityLowerMapper/>.selectSelective(<@entityLowerName/>);
	}

}
