package ${packageName}.${moduleName}.service;
<#-- 大写类名 -->
<#assign entityCapName=entityName?cap_first/>
<#-- 小写类名 -->
<#assign entityLowerName=entityName?uncap_first/>
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;

import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @title: ${functionName}
 * @author: ${functionAuthor}
 * @date: ${time}
 */
@Component
public class ${entityCapName}Service extends BaseService {

	@Autowired
	private ${entityCapName}Dao ${entityLowerName}Dao;

	private Specification<${entityCapName}> build${entityCapName}Specification(Map<String , ?> searchMap) {
		return (root, query, builder) -> {
			List<Predicate> predicate = buildGuideBlogPredicateList(searchMap, root, builder);
			return query.where(predicate.toArray(new Predicate[0])).getRestriction();
		};
	}

	private List<Predicate> build${entityCapName}PredicateList(Map<String, ?> searchMap, Root<${entityCapName}> root, CriteriaBuilder builder) {

	<#list attributeInfos as attributeInfo>
		<#if attributeInfo.type?lower_case?contains("long") || attributeInfo.type?lower_case?contains("string") || attributeInfo.type?lower_case?contains("integer") || attributeInfo.type?lower_case?contains("date")  || attributeInfo.type?lower_case?contains("int")>
		Object ${attributeInfo.name} = searchMap.get("${attributeInfo.name}");// ${attributeInfo.remarks}
		</#if>
	</#list>

		List<Predicate> predicateList = new ArrayList<>();

	<#list attributeInfos as attributeInfo>
		<#if attributeInfo.type?lower_case?contains("long") || attributeInfo.type?lower_case?contains("integer") || attributeInfo.type?lower_case?contains("int")>
		if (CheckParam.isInteger(${attributeInfo.name})) {
			predicateList.add(builder.equal(root.get("${attributeInfo.name}"), toLong(${attributeInfo.name})));
		}
		<#elseif attributeInfo.type?lower_case?contains("string")>
		if (!CheckParam.isNull(${attributeInfo.name})) {
			predicateList.add(builder.equal(root.get("${attributeInfo.name}"), ${attributeInfo.name}.toString()));
		}
		<#elseif attributeInfo.type?lower_case?contains("date")>
		if (CheckParam.isDate(${attributeInfo.name})) {
			predicate.add(builder.equal(root.get("${attributeInfo.name}"), BaseUtil.strToDate(${attributeInfo.name})));
		}
		<#else >
		</#if>
	</#list>

		return predicateList;
	}

}