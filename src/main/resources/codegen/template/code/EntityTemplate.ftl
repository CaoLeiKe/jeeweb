package ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.entity;

<#list importTypes as importType>
import ${importType};
</#list>

/**
 * @Description: ${functionDesc}
 * @author ${functionAuthor}
 * @date ${time}
 *
 */

@Getter
@Setter
@ToString
public class ${entityName?cap_first} implements Serializable {

	private static final long serialVersionUID = 1L;

	<#list attributeInfos as attributeInfo>
	/**${attributeInfo.remarks}*/
	private <#if attributeInfo.type=='this'>${entityName?cap_first}<#else>${attributeInfo.type}</#if> ${attributeInfo.name};

	</#list>
}
