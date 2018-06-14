package ${packageName}.${moduleName}.entity;
<#-- 大写类名 -->
<#assign entityCapName=entityName?cap_first/>
<#-- 小写类名 -->
<#assign entityLowerName=entityName?uncap_first/>
<#-- 主键类型 -->
<#assign idJavaType><#list columns as column><#if column.parmaryKey>${column.javaType}</#if></#list></#assign>

import lombok.Data;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
<#-- 下面是自动导入 -->
import java.io.Serializable;
<#list importTypes as importType>
import ${importType};
</#list>

/**
 * @title: ${functionName}
 * @description: ${functionDesc}
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
	<#if attributeInfo.parmaryKey>
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	</#if>
	private <#if attributeInfo.type=='this'>${entityCapName}<#else>${attributeInfo.type}</#if> ${attributeInfo.dbName};
	/** ${attributeInfo.remarks} */
	public static final transient String ${attributeInfo.dbName}_ = "${attributeInfo.dbName}";

</#list>
}
