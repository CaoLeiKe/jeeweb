package ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.entity;
<#macro entityCapName>${entityName?cap_first}</#macro>

import com.fasterxml.jackson.annotation.JsonFormat;
import ${packageName}.${moduleName}.valid.First;
import ${packageName}.${moduleName}.valid.Second;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
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
@ApiModel(description = "${functionName}PO实体")
public class <@entityCapName/> implements Serializable {

    private static final long serialVersionUID = 1L;

    <#list attributeInfos as attributeInfo>
    /**${attributeInfo.remarks}*/
    <#-- 数据库为notNull，且没有默认值，且不是创建修改人和时间-->
    <#if !attributeInfo.nullable && attributeInfo.columnDef?trim?length == 0 && !(attributeInfo.name?lower_case?contains("update") || attributeInfo.name?lower_case?contains("create"))>
        <#-- 如果是主键-->
        <#if attributeInfo.parmaryKey>
    @ApiModelProperty(value = "${attributeInfo.remarks}")
    @NotNull(message = "${attributeInfo.remarks}不能为空！", groups = {Second.class})
        <#elseif attributeInfo.type == "String">
    @ApiModelProperty(value = "${attributeInfo.remarks}", required = true)
    @NotNull(message = "${attributeInfo.remarks}不能为空！", groups = {First.class, Second.class})
    @Size(max = ${attributeInfo.length}, min = 1, message = "${attributeInfo.remarks}必填。最多${attributeInfo.length}个字符！")
        <#else>
    @ApiModelProperty(value = "${attributeInfo.remarks}", required = true)
    @NotNull(message = "${attributeInfo.remarks}不能为空！", groups = {First.class, Second.class})
        </#if>
    <#elseif attributeInfo.type == "String" && !(attributeInfo.name?lower_case?contains("update") || attributeInfo.name?lower_case?contains("create"))>
    @Size(max = ${attributeInfo.length}, message = "${attributeInfo.remarks}最多${attributeInfo.length}个字符！")
    @ApiModelProperty(value = "${attributeInfo.remarks}")
    <#else>
    @ApiModelProperty(value = "${attributeInfo.remarks}")
    </#if>
    <#if attributeInfo.type == "Date">
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8" )
    </#if>
    private <#if attributeInfo.type=='this'><@entityCapName/><#else>${attributeInfo.type}</#if> ${attributeInfo.name};

    </#list>
}
