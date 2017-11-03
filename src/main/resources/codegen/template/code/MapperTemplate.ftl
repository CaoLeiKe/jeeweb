package ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.mapper;

import ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.entity.${entityName?cap_first};

/**
* @Title: ${functionName}
* @Description: mapper SQL层
* @author ${functionAuthor}
* @date ${time}
*/
public interface ${entityName?cap_first}Mapper{
    
}