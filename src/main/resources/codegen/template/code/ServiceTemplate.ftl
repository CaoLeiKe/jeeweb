package ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.service;
<#macro idJava><#list columns as column><#if column.parmaryKey>${column.javaField}</#if></#list></#macro>
<#macro entityLowerName>${entityName?lower_case}</#macro>
<#macro entityCapName>${entityName?cap_first}</#macro>

import ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.entity.<@entityCapName/>;

import java.util.List;

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
	 * @param <@entityLowerName/> ${functionName}实体
	 * @return 受影响的行数
	 */
	long deleteByPrimaryKey(<@entityCapName/> <@entityLowerName/>);

	/**
	 * 新增${functionName}
	 *
	 * @param <@entityLowerName/> ${functionName}实体
	 * @return 受影响的行数
	 */
	long insertSelective(<@entityCapName/> <@entityLowerName/>);

	/**
	 * 根据主键更新${functionName}，无法更改主键和创建者、创建时间的信息
	 *
	 * @param <@entityLowerName/> ${functionName}实体
	 * @return 受影响的行数
	 */
	long updateByPrimaryKey(<@entityCapName/> <@entityLowerName/>);

	/**
	 * 根据${functionName}实体中的条件更改数据，无法更改主键和创建者、创建时间的信息
	 *
	 * @param <@entityLowerName/> ${functionName}实体
	 * @return 受影响的行数
	 */
	long updateSelective(<@entityCapName/> <@entityLowerName/>);

	/**
	 * 根据主键查询${functionName}
	 *
	 * @param <@idJava/> ${functionName}主键
	 * @return ${functionName}
	 */
	<@entityCapName/> selectByPrimaryKey(Long <@idJava/>);

	/**
	 * 根据${functionName}实体的条件查询数据
	 *
	 * @param <@entityLowerName/> ${functionName}实体
	 * @return ${functionName}的集合
	 */
	List<<@entityCapName/>> selectSelective(<@entityCapName/> <@entityLowerName/>);

}

