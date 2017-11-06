package ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.service;
<#macro idJava><#list columns as column><#if column.parmaryKey>${column.javaField}</#if></#list></#macro>
<#macro entityLowerName>${entityName?lower_case}</#macro>
<#macro entityCapName>${entityName?cap_first}</#macro>

import ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.entity.<@entityCapName/>;

/**
 * @Title: ${functionName}
 * @Description: Service 接口
 * @author ${functionAuthor}
 * @date ${time}
 */
public interface <@entityCapName/>Service {

	/**
	 * 根据主键逻辑删除，需传入实体，并包含主键和修改人，其中修改人可有可无
	 *
	 * @param <@entityLowerName/> ${functionName}
	 * @return 受影响的行数
	 */
	int deleteByPrimaryKey(<@entityCapName/> <@entityLowerName/>);

	/**
	 * 新增${functionName}
	 *
	 * @param <@entityLowerName/> ${functionName}
	 * @return 受影响的行数
	 */
	int insertSelective(<@entityCapName/> <@entityLowerName/>);

	/**
	 * 根据主键更新${functionName}，无法更改主键和创建者、创建时间的信息
	 *
	 * @param <@entityLowerName/> ${functionName}
	 * @return 受影响的行数
	 */
	int updateByPrimaryKey(<@entityCapName/> <@entityLowerName/>);

	/**
	 * 根据${functionName}实体中的条件更改数据，无法更改主键和创建者、创建时间的信息
	 *
	 * @param <@entityLowerName/> ${functionName}
	 * @return 受影响的行数
	 */
	int updateSelective(<@entityCapName/> <@entityLowerName/>);

	/**
	 * 根据主键查询${functionName}
	 *
	 * @param <@id/> 主键
	 * @return ${functionName}
	 */
	<@entityCapName/> selectByPrimaryKey(Long <@idJava/>);

	/**
	 * 根据${functionName}实体的条件查询数据
	 *
	 * @param <@entityLowerName/> ${functionName}
	 * @return ${functionName}的集合
	 */
	List<<@entityCapName/>> selectSelective(<@entityCapName/> <@entityLowerName/>);

}

