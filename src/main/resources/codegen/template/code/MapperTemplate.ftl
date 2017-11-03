package ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.mapper;

import ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.entity.${entityName?cap_first};

/**
 * @Title: ${functionName}
 * @Description: mapper SQL层
 * @author ${functionAuthor}
 * @date ${time}
 */
public interface ${entityName?cap_first}Mapper{

	/**
	* 根据主键逻辑删除，需传入实体，并包含主键和修改人，其中修改人可有可无
	*
	* @param ${entityName?lower_case} ${functionName}
	* @return 受影响的行数
	*/
	int deleteByPrimaryKey(${entityName?cap_first} ${entityName?lower_case});
	
	/**
	* 新增${functionName}
	*
	* @param ${entityName?lower_case} ${functionName}
	* @return 受影响的行数
	*/
	int insertSelective(${entityName?cap_first} ${entityName?lower_case});

	/**
	* 根据主键更新${functionName}，无法更改主键和创建者、创建时间的信息
	*
	* @param ${entityName?lower_case} ${functionName}
	* @return 受影响的行数
	*/
	int updateByPrimaryKey(${entityName?cap_first} ${entityName?lower_case});

	/**
	* 根据${functionName}实体中的条件更改数据，无法更改主键和创建者、创建时间的信息
	*
	* @param ${entityName?lower_case} ${functionName}
	* @return 受影响的行数
	*/
	int updateSelective(${entityName?cap_first} ${entityName?lower_case});

	/**
	* 根据主键查询${functionName}
	*
	* @param id 主键
	* @return ${functionName}
	*/
	${entityName?cap_first} selectByPrimaryKey(Long id);

	/**
	* 根据${functionName}实体的条件查询数据
	*
	* @param ${entityName?lower_case} ${functionName}
	* @return ${functionName}的集合
	*/
	List<${entityName?cap_first}> selectSelective(${entityName?cap_first} ${entityName?lower_case});

}