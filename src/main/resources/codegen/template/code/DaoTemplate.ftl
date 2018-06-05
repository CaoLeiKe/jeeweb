package ${packageName}.${moduleName}.natives.api.entity;
<#-- 大写类名 -->
<#assign entityCapName=entityName?cap_first/>
<#-- 小写类名 -->
<#assign entityCapName=entityName?uncap_first/>
<#-- 主键 -->
<#assign idJavaType><#list columns as column><#if column.parmaryKey>${column.javaType}</#if></#list></#assign>

<#list attributeInfos as attributeInfo>
    <#if attributeInfo.type == "Date">
import com.fasterxml.jackson.annotation.JsonFormat;
        <#break/>
    </#if>
</#list>
import lombok.Data;

import java.io.Serializable;
<#list importTypes as importType>
import ${importType};
</#list>

/**
 * @title: ${functionName}
 * @author: ${functionAuthor}
 * @date: ${time}
 */

@Data
@DynamicInsert
@DynamicUpdate
@Entity
@Table(name = "${tableName}")
public class ${entityCapName} implements Serializable {

    private static final long serialVersionUID = 1L;

<#list attributeInfos as attributeInfo>
    /** ${attributeInfo.remarks} */
    <#if attributeInfo.type == "Date">
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    </#if>
    private <#if attributeInfo.type=='this'>${entityCapName}<#else>${attributeInfo.type}</#if> ${attributeInfo.name};

</#list>
}
