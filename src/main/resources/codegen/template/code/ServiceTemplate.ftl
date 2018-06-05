package ${packageName}.${moduleName}.service;
<#-- 大写类名 -->
<#assign entityCapName=entityName?cap_first/>
<#-- 小写类名 -->
<#assign entityLowerName=entityName?uncap_first/>
import com.zoomdu.service.base.BaseService;
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

	// ${functionName}
	private List<Predicate> build${entityCapName}PredicateList(Map<String, ?> searchMap, Root<${entityCapName}> root, CriteriaBuilder builder) {

	<#list attributeInfos as attributeInfo>
		<#if attributeInfo.parmaryKey>
		<#elseif attributeInfo.type?lower_case?contains("long") || attributeInfo.type?lower_case?contains("string") || attributeInfo.type?lower_case?contains("integer") || attributeInfo.type?lower_case?contains("date")  || attributeInfo.type?lower_case?contains("int")>
		Object ${attributeInfo.name} = searchMap.get("${attributeInfo.name}");// ${attributeInfo.remarks}
		</#if>
	</#list>

		List<Predicate> predicateList = new ArrayList<>();

	<#list attributeInfos as attributeInfo>
		<#if attributeInfo.parmaryKey>
		<#elseif attributeInfo.type?lower_case?contains("long") || attributeInfo.type?lower_case?contains("integer") || attributeInfo.type?lower_case?contains("int")>
		if (CheckParam.isInteger(${attributeInfo.name})) {
			predicateList.add(builder.equal(root.get("${attributeInfo.name}"), toLong(${attributeInfo.name})));
		}
		<#elseif attributeInfo.type?lower_case?contains("string")>
		if (!CheckParam.isNull(${attributeInfo.name})) {
			predicateList.add(builder.equal(root.get("${attributeInfo.name}"), ${attributeInfo.name}.toString()));
		}
		<#elseif attributeInfo.type?lower_case?contains("date")>
		if (CheckParam.isDate(${attributeInfo.name})) {
			predicate.add(builder.equal(root.greaterThanOrEqualTo("${attributeInfo.name}"), BaseUtil.strToDate(${attributeInfo.name})));
		}
		<#else >
		</#if>
	</#list>

		return predicateList;
	}

	/**
	 * 保存${functionName}
	 */
	public BaseResponse save${entityCapName}(HttpRequest request) {

		GuideAccount guideAccount = getGuideAccountByToken(request);

		String ${entityLowerName}Json = request.getParameter("${entityLowerName}Json");

		<#-- 转换成Map -->
		RequestMap<String, Object> ${entityLowerName}Map = fromJsonToMap(${entityLowerName}Json);

	<#-- 把数据获取出来 -->
	<#list attributeInfos as attributeInfo>
		<#if attributeInfo.parmaryKey>
		<#-- 如果是主键则跳过 -->
		<#elseif attributeInfo.type?lower_case?contains("integer") || attributeInfo.type?lower_case?contains("int") || attributeInfo.type?lower_case?contains("long")>
		<#-- 基本类型 -->
		Long ${attributeInfo.name} = ${entityLowerName}Map.getAsLong("${attributeInfo.name}");// ${attributeInfo.remarks}
		<#elseif attributeInfo.type?lower_case?contains("string")>
		<#-- 字符串 -->
		String ${attributeInfo.name} = ${entityLowerName}Map.getAsString("${attributeInfo.name}");// ${attributeInfo.remarks}
		<#elseif attributeInfo.type?lower_case?contains("date")>
		<#-- 日期 -->
		Date ${attributeInfo.name} = ${entityLowerName}Map.getAsDate("${attributeInfo.name}");// ${attributeInfo.remarks}
		<#elseif attributeInfo.type?lower_case?contains("double")>
		<#-- double -->
		Double ${attributeInfo.name} = ${entityLowerName}Map.getDouble("${attributeInfo.name}");// ${attributeInfo.remarks}
		<#else >
		</#if>
	</#list>

	<#-- 数据库不为空判断 -->
	<#list attributeInfos as attributeInfo>
		<#if attributeInfo.parmaryKey>
		<#-- 如果是主键则跳过 -->
		<#elseif (attributeInfo.type?lower_case?contains("integer") || attributeInfo.type?lower_case?contains("int")) && attributeInfo.nullable>
		<#-- 基本类型 -->
		if (${attributeInfo.name} == null) {
			throw new ERPExceptionUtil("${attributeInfo.remarks}必填项，不能为空！");
		}
		<#elseif attributeInfo.type?lower_case?contains("string") && attributeInfo.nullable>
		<#-- 字符串 -->
		if (CheckParam.isNull(${attributeInfo.name}) == null) {
			throw new ERPExceptionUtil("${attributeInfo.remarks}必填项，不能为空！");
		}
		<#elseif attributeInfo.type?lower_case?contains("date")>
		<#-- 日期 -->
		if (${attributeInfo.name} == null) {
			throw new ERPExceptionUtil("${attributeInfo.remarks}必填项，不能为空！");
		}
		<#elseif attributeInfo.type?lower_case?contains("double")>
		<#-- double -->
		if (${attributeInfo.name} == null) {
			throw new ERPExceptionUtil("${attributeInfo.remarks}必填项，不能为空！");
		}
		<#else >
		</#if>
	</#list>


		${entityCapName} ${entityLowerName} = new ${entityCapName}();
	<#list attributeInfos as attributeInfo>
		<#if attributeInfo.parmaryKey>
		<#-- 如果是主键则跳过 -->
		<#elseif attributeInfo.type?lower_case?contains("integer") || attributeInfo.type?lower_case?contains("int") || attributeInfo.type?lower_case?contains("long")>
		<#-- 基本类型 -->
		${entityLowerName}.set${attributeInfo.name?cap_first}(${entityLowerName});
		<#elseif attributeInfo.type?lower_case?contains("string")>
		<#-- 字符串 -->
		${entityLowerName}.set${attributeInfo.name?cap_first}(${entityLowerName});
		<#elseif attributeInfo.type?lower_case?contains("date")>
		<#-- 日期 -->
		${entityLowerName}.set${attributeInfo.name?cap_first}(${entityLowerName});
		<#elseif attributeInfo.type?lower_case?contains("double")>
		<#-- double -->
		${entityLowerName}.set${attributeInfo.name?cap_first}(${entityLowerName});
		</#if>
	</#list>
		${entityLowerName}Dao.save(${entityLowerName});

		return BaseResponse.success().setData(${entityLowerName}).build();
	}

	/**
	 * 根据主键查询${functionName}
	 */
	public BaseResponse find${entityLowerName}ById(HttpServletRequest request) {

		String id = request.getParameter("id");

		if (!CheckParam.isInteger(id)) {
			throw new ERPExceptionUtil("请传入正确的id！");
		}
		${entityCapName} ${entityLowerName} = ${entityLowerName}Dao.findOne(toLong(id));
		if (${entityLowerName} == null) {
			throw new ERPExceptionUtil("${functionName}不存在！");
		}

		return BaseResponse.success().setData(${entityLowerName}).build();
	}

	/**
	 * 根据条件分页查询${functionName}
	 */
	public BaseResponse find${entityCapName}PageBySearchMap(HttpServletRequest request) {

		String searchMap = request.getParameter("searchMap");
		String pageNo = request.getParameter("pageNo");

		Page<${entityCapName}> page = ${entityLowerName}Dao.findAll(build${entityCapName}Specification(searchMap), buildPageRequest(toInteger(pageNo), Sort.Direction.DESC, "id"));

		return BaseResponse.success().setData(page).build();
	}

}