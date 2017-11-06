package ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.entity;
<#macro entityCapName>${entityName?cap_first}</#macro>

import ${packageName}.${moduleName}.valid.First;
import ${packageName}.${moduleName}.valid.Second;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.validation.constraints.NotNull;
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
	<#if !attributeInfo.nullable && attributeInfo.columnDef?trim?length == 0>
		<#if attributeInfo.parmaryKey>
	@ApiModelProperty(value = "${attributeInfo.remarks}")
	@NotNull(message = "${attributeInfo.remarks}不能为空！", groups = {Second.class})
		<#else >
	@ApiModelProperty(value = "${attributeInfo.remarks}", required = true)
	@NotNull(message = "${attributeInfo.remarks}不能为空！", groups = {First.class, Second.class})
		</#if>
	<#else>
	@ApiModelProperty(value = "${attributeInfo.remarks}")
	</#if>
	<#if attributeInfo.type == "Date">
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8" )
	</#if>
	private <#if attributeInfo.type=='this'><@entityCapName/><#else>${attributeInfo.type}</#if> ${attributeInfo.name};

	</#list>
}
