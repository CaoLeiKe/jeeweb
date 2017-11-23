package ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.entity;
<#macro entityCapName>${entityName?cap_first}</#macro>

<#list attributeInfos as attributeInfo>
    <#if attributeInfo.type == "Date">
import com.fasterxml.jackson.annotation.JsonFormat;
        <#break/>
    </#if>
</#list>
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;
<#list importTypes as importType>
import ${importType};
</#list>

/**
 * @Title: ${functionName}
 * @Description: PO实体
 * @author ${functionAuthor}
 * @date ${time}
 */

@Getter
@Setter
@ToString
public class <@entityCapName/> implements Serializable {

    private static final long serialVersionUID = 1L;

    <#list attributeInfos as attributeInfo>
    /**${attributeInfo.remarks}*/
    <#if attributeInfo.type == "Date">
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    </#if>
    private <#if attributeInfo.type=='this'><@entityCapName/><#else>${attributeInfo.type}</#if> ${attributeInfo.name};

    </#list>
}
