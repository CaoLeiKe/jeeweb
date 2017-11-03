package ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.entity;

<#list importTypes as importType>
import ${importType};
</#list>
import java.io.Serializable;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @Title: ${functionName}
 * @Description: PO实体
 * @author ${functionAuthor}
 * @date ${time}
 */

@Getter
@Setter
@ToString
public class ${entityName?cap_first} implements Serializable {

	private static final long serialVersionUID = 1L;

	<#list attributeInfos as attributeInfo>
	/**${attributeInfo.remarks}*/
	<#if !attributeInfo.nullable && attributeInfo.columnDef?trim?length == 0>
	@NotNull(message = "${attributeInfo.remarks}不能为空！")
	</#if>
	<#if attributeInfo.type == "Date">
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8" )
	</#if>
	private <#if attributeInfo.type=='this'>${entityName?cap_first}<#else>${attributeInfo.type}</#if> ${attributeInfo.name};

	</#list>
}
