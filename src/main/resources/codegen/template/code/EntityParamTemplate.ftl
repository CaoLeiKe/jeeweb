package com.chtwm.insurance.natives.api.params;
<#macro entityCapName>${entityName?cap_first}</#macro>

import com.chtwm.insurance.agency.common.valid.Insert;
import com.chtwm.insurance.agency.common.valid.Update;
<#list attributeInfos as attributeInfo>
    <#if attributeInfo.type == "Date">
import com.fasterxml.jackson.annotation.JsonFormat;
        <#break/>
    </#if>
</#list>
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

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
import java.io.Serializable;
<#list importTypes as importType>
import ${importType};
</#list>

/**
 * @Title: ${functionName}
 * @Description: VO实体
 * @author ${functionAuthor}
 * @date ${time}
 */

@Getter
@Setter
@ToString
@ApiModel(description = "${functionName}PO实体")
public class <@entityCapName/>Param implements Serializable {

    private static final long serialVersionUID = 1L;

    <#list attributeInfos as attributeInfo>
    /**${attributeInfo.remarks}*/
    <#-- 数据库为notNull，且没有默认值，且不是创建修改人和时间-->
    <#if !attributeInfo.nullable && attributeInfo.columnDef?trim?length == 0 && !(attributeInfo.name?lower_case?contains("update") || attributeInfo.name?lower_case?contains("create"))>
        <#-- 如果是主键-->
        <#if attributeInfo.parmaryKey>
    @ApiModelProperty(value = "${attributeInfo.remarks}")
    @NotNull(message = "${attributeInfo.remarks}不能为空！", groups = {Update.class})
        <#elseif attributeInfo.type == "String">
    @ApiModelProperty(value = "${attributeInfo.remarks}", required = true)
    @NotNull(message = "${attributeInfo.remarks}不能为空！", groups = {Insert.class, Update.class})
    @Size(max = ${attributeInfo.length}, min = 1, message = "${attributeInfo.remarks}不能为空，且最多${attributeInfo.length}个字符！")
        <#else>
    @ApiModelProperty(value = "${attributeInfo.remarks}", required = true)
    @NotNull(message = "${attributeInfo.remarks}不能为空！", groups = {Insert.class, Update.class})
        </#if>
    <#elseif attributeInfo.type == "String" && !(attributeInfo.name?lower_case?contains("update") || attributeInfo.name?lower_case?contains("create"))>
    @Size(max = ${attributeInfo.length}, message = "${attributeInfo.remarks}最多${attributeInfo.length}个字符！")
    @ApiModelProperty(value = "${attributeInfo.remarks}")
    <#else>
    @ApiModelProperty(value = "${attributeInfo.remarks}")
    </#if>
    <#if attributeInfo.type == "Date">
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    <#elseif attributeInfo.type == "BigDecimal">
    @Digits(integer = ${attributeInfo.length?number - attributeInfo.decimalDigits?number}, fraction = ${attributeInfo.decimalDigits}, message = "${attributeInfo.remarks}小数不能超过${attributeInfo.decimalDigits}位，整数不能超过${attributeInfo.length?number - attributeInfo.decimalDigits?number}位！")
    </#if>
    private <#if attributeInfo.type=='this'><@entityCapName/><#else>${attributeInfo.type}</#if> ${attributeInfo.name};

    </#list>
}
