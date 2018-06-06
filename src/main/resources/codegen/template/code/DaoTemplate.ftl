package ${packageName}.${moduleName}.dao;
<#-- 大写类名 -->
<#assign entityCapName=entityName?cap_first/>
<#-- 主键类型 -->
<#assign idJavaType><#list columns as column><#if column.parmaryKey>${column.javaType}</#if></#list></#assign>

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.CrudRepository;

/**
 * @title: ${functionName}
 * @description: ${functionDesc}
 * @author: ${functionAuthor}
 * @date: ${time}
 */
public interface ${entityCapName}Dao extends CrudRepository<${entityCapName}, ${idJavaType}>, JpaSpecificationExecutor<${entityCapName}> {
}
