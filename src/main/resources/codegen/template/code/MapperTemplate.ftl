package ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.mapper;
<#macro id><#list columns as column><#if column.parmaryKey>${column.javaField}</#if></#list></#macro>
<#macro entityLowerName>${entityName?lower_case}</#macro>
<#macro entityCapName>${entityName?cap_first}</#macro>

import ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.entity.<@entityCapName/>;

/**
 * @Title: ${functionName}
 * @Description: mapper SQL层
 * @author ${functionAuthor}
 * @date ${time}
 */
public interface <@entityCapName/>Mapper{

	/**
	* 根据主键逻辑删除，需传入实体，并包含主键和修改人，其中修改人可有可无
	*
	* @param <@entityCapName/> ${functionName}
	* @return 受影响的行数
	*/
	int deleteByPrimaryKey(<@entityCapName/> <@entityCapName/>);
	
	/**
	* 新增${functionName}
	*
	* @param <@entityCapName/> ${functionName}
	* @return 受影响的行数
	*/
	int insertSelective(<@entityCapName/> <@entityCapName/>);

	/**
	* 根据主键更新${functionName}，无法更改主键和创建者、创建时间的信息
	*
	* @param <@entityCapName/> ${functionName}
	* @return 受影响的行数
	*/
	int updateByPrimaryKey(<@entityCapName/> <@entityCapName/>);

	/**
	* 根据${functionName}实体中的条件更改数据，无法更改主键和创建者、创建时间的信息
	*
	* @param <@entityCapName/> ${functionName}
	* @return 受影响的行数
	*/
	int updateSelective(<@entityCapName/> <@entityCapName/>);

	/**
	* 根据主键查询${functionName}
	*
	* @param <@id/> 主键
	* @return ${functionName}
	*/
	<@entityCapName/> selectByPrimaryKey(Long <@id/>);

	/**
	* 根据${functionName}实体的条件查询数据
	*
	* @param <@entityCapName/> ${functionName}
	* @return ${functionName}的集合
	*/
	List<<@entityCapName/>> selectSelective(<@entityCapName/> <@entityCapName/>);

}