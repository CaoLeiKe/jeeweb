package ${packageName}.${moduleName}.natives.api.params;
<#macro entityCapName>${entityName?cap_first}</#macro>

import ${packageName}.${moduleName}.agency.common.valid.Insert;
import ${packageName}.${moduleName}.agency.common.valid.Update;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

<#list attributeInfos as attributeInfo>
    <#if attributeInfo.type == "BigDecimal">
import javax.validation.constraints.Digits;
        <#break/>
    </#if>
</#list>
<#list attributeInfos as attributeInfo>
    <#if !attributeInfo.nullable && attributeInfo.columnDef?trim?length == 0 && !(attributeInfo.name?lower_case?contains("update") || attributeInfo.name?lower_case?contains("create"))>
import javax.validation.constraints.NotNull;
        <#break/>
    </#if>
</#list>
<#list attributeInfos as attributeInfo>
    <#if !attributeInfo.nullable && attributeInfo.columnDef?trim?length == 0 && !(attributeInfo.name?lower_case?contains("update") || attributeInfo.name?lower_case?contains("create")) && attributeInfo.type == "String">
import javax.validation.constraints.Size;
        <#break/>
    </#if>
</#list>
<#list attributeInfos as attributeInfo>
    <#if attributeInfo.type == "String" && !(attributeInfo.name?lower_case?contains("update") || attributeInfo.name?lower_case?contains("create"))>
import javax.validation.groups.Default;
        <#break/>
    </#if>
</#list>
import java.io.Serializable;
<#list importTypes as importType>
import ${importType};
</#list>

/**
 * @Title: ${functionName}
 * @Description: param实体
 * @Author ${functionAuthor}
 * @Date ${time}
 */

@Data
public class <@entityCapName/>Param implements Serializable {

    private static final long serialVersionUID = 1L;

    <#list attributeInfos as attributeInfo>
    /** ${attributeInfo.remarks} */
    <#-- 数据库为notNull，且没有默认值，并且不是创建修改人和时间-->
    <#if !attributeInfo.nullable && attributeInfo.columnDef?trim?length == 0 && !(attributeInfo.name?lower_case?contains("update") || attributeInfo.name?lower_case?contains("create"))>
        <#-- 如果是主键-->
        <#if attributeInfo.parmaryKey>
    @ApiModelProperty(value = "${attributeInfo.remarks}")
    @NotNull(message = "${attributeInfo.remarks}不能为空！", groups = {Update.class})
        <#-- 如果是String类型 -->
        <#elseif attributeInfo.type == "String">
    @ApiModelProperty(value = "${attributeInfo.remarks}")
    @NotNull(message = "${attributeInfo.remarks}不能为空！", groups = {Insert.class})
    @Size(max = ${attributeInfo.length}, groups = {Insert.class, Update.class, Default.class}, message = "${attributeInfo.remarks}最多${attributeInfo.length}个字符！")
        <#-- 其他 -->
        <#else>
    @ApiModelProperty(value = "${attributeInfo.remarks}")
    @NotNull(message = "${attributeInfo.remarks}不能为空！", groups = {Insert.class})
        </#if>
    <#-- 如果是String并且不是创建人、修改人 -->
    <#elseif attributeInfo.type == "String" && !(attributeInfo.name?lower_case?contains("update") || attributeInfo.name?lower_case?contains("create"))>
    @Size(max = ${attributeInfo.length}, groups = {Insert.class, Update.class, Default.class}, message = "${attributeInfo.remarks}最多${attributeInfo.length}个字符！")
    @ApiModelProperty(value = "${attributeInfo.remarks}")
    <#-- 其他 -->
    <#else>
    @ApiModelProperty(value = "${attributeInfo.remarks}")
    </#if>
    <#-- bigDecimal类型 -->
    <#if attributeInfo.type == "BigDecimal">
    @Digits(integer = ${attributeInfo.length?number - attributeInfo.decimalDigits?number}, fraction = ${attributeInfo.decimalDigits}, message = "${attributeInfo.remarks}小数不能超过${attributeInfo.decimalDigits}位，整数不能超过${attributeInfo.length?number - attributeInfo.decimalDigits?number}位！")
    </#if>
    private <#if attributeInfo.type=='this'><@entityCapName/><#else>${attributeInfo.type}</#if> ${attributeInfo.name};

    </#list>
}
