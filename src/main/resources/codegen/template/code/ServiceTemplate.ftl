package ${packageName}.${moduleName}.service;
<#-- 大写类名 -->
<#assign entityCapName=entityName?cap_first/>
<#-- 小写类名 -->
<#assign entityLowerName=entityName?uncap_first/>

import com.zoomdu.controller.base.responseEntity.BaseResponse;
import com.zoomdu.entity.erp.app.guide.account.GuideAccount;
import com.zoomdu.exception.ERPExceptionUtil;
import com.zoomdu.service.base.BaseService;
import com.zoomdu.util.BaseUtil;
import com.zoomdu.util.CheckParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @title: ${functionName}
 * @description: ${functionDesc}
 * @author: ${functionAuthor}
 * @date: ${time}
 */
@Component
public class ${entityCapName}Service extends BaseService {

	@Autowired
	private ${entityCapName}Dao ${entityLowerName}Dao;

	private Specification<${entityCapName}> build${entityCapName}Specification(Map<String , ?> searchMap) {
		return (root, query, builder) -> {
			List<Predicate> predicate = build${entityCapName}PredicateList(searchMap, root, builder);
			return query.where(predicate.toArray(new Predicate[0])).getRestriction();
		};
	}

	// ${functionName}
	private List<Predicate> build${entityCapName}PredicateList(Map<String, ?> searchMap, Root<${entityCapName}> root, CriteriaBuilder builder) {

	<#list attributeInfos as attributeInfo>
		<#if attributeInfo.parmaryKey>
		<#elseif attributeInfo.type?lower_case?contains("long") || attributeInfo.type?lower_case?contains("string") || attributeInfo.type?lower_case?contains("integer") || attributeInfo.type?lower_case?contains("date")  || attributeInfo.type?lower_case?contains("int")>
		Object ${attributeInfo.dbName} = searchMap.get("${attributeInfo.dbName}");// ${attributeInfo.remarks}
		</#if>
	</#list>

		List<Predicate> predicateList = new ArrayList<>();

	<#list attributeInfos as attributeInfo>
		<#if attributeInfo.parmaryKey>
		<#elseif attributeInfo.type?lower_case?contains("long") || attributeInfo.type?lower_case?contains("integer") || attributeInfo.type?lower_case?contains("int")>
		if (CheckParam.isInteger(${attributeInfo.dbName})) {
			predicateList.add(builder.equal(root.get("${attributeInfo.dbName}"), toLong(${attributeInfo.dbName})));
		}
		<#elseif attributeInfo.type?lower_case?contains("string")>
		if (!CheckParam.isNull(${attributeInfo.dbName})) {
			predicateList.add(builder.equal(root.get("${attributeInfo.dbName}"), ${attributeInfo.dbName}.toString()));
		}
		<#elseif attributeInfo.type?lower_case?contains("date")>
		if (${attributeInfo.dbName} != null && CheckParam.isDate(${attributeInfo.dbName}.toString())) {
			predicateList.add(builder.greaterThanOrEqualTo(root.get("${attributeInfo.dbName}"), BaseUtil.strToDate(${attributeInfo.dbName}.toString())));
		}
		<#else >
		</#if>
	</#list>

		return predicateList;
	}

	/**
	 * 保存${functionName}
	 */
	public BaseResponse save${entityCapName}(HttpServletRequest request) {

		GuideAccount guideAccount = getGuideAccountByToken(request);

		String ${entityLowerName}Json = request.getParameter("${entityLowerName}Json");

		<#-- 转换成Map -->
		RequestMap<String, Object> ${entityLowerName}Map = fromJsonToMap(${entityLowerName}Json);

	<#-- 把数据获取出来 -->
	<#list attributeInfos as attributeInfo>
		<#if attributeInfo.parmaryKey || attributeInfo.dbName?lower_case?contains("create")>
		<#-- 如果是主键则跳过 -->
		<#elseif attributeInfo.type?lower_case?contains("integer") || attributeInfo.type?lower_case?contains("int")>
		<#-- 基本类型 -->
		long ${attributeInfo.dbName} = ${entityLowerName}Map.getAsInt("${attributeInfo.dbName}");// ${attributeInfo.remarks}
		<#elseif attributeInfo.type?lower_case?contains("long")>
		<#-- 基本类型 -->
		Long ${attributeInfo.dbName} = ${entityLowerName}Map.getAsLong("${attributeInfo.dbName}");// ${attributeInfo.remarks}
		<#elseif attributeInfo.type?lower_case?contains("string")>
		<#-- 字符串 -->
		String ${attributeInfo.dbName} = ${entityLowerName}Map.getAsString("${attributeInfo.dbName}");// ${attributeInfo.remarks}
		<#elseif attributeInfo.type?lower_case?contains("date")>
		<#-- 日期 -->
		Date ${attributeInfo.dbName} = ${entityLowerName}Map.getAsDate("${attributeInfo.dbName}");// ${attributeInfo.remarks}
		<#elseif attributeInfo.type?lower_case?contains("double")>
		<#-- double -->
		Double ${attributeInfo.dbName} = ${entityLowerName}Map.getAsDouble("${attributeInfo.dbName}");// ${attributeInfo.remarks}
		<#else >
		</#if>
	</#list>

	<#-- 数据库不为空判断 -->
	<#list attributeInfos as attributeInfo>
		<#if attributeInfo.parmaryKey  || attributeInfo.dbName?lower_case?contains("create")>
		<#-- 如果是主键则跳过 -->
		<#elseif (attributeInfo.type?lower_case?contains("integer") || attributeInfo.type?lower_case?contains("int")) && attributeInfo.nullable>
		<#-- 基本类型 -->
		if (${attributeInfo.dbName} == null) {
			throw new ERPExceptionUtil("${attributeInfo.remarks}必填项，不能为空！");
		}
		<#elseif attributeInfo.type?lower_case?contains("string") && attributeInfo.nullable>
		<#-- 字符串 -->
		if (CheckParam.isNull(${attributeInfo.dbName})) {
			throw new ERPExceptionUtil("${attributeInfo.remarks}必填项，不能为空！");
		}
		<#elseif attributeInfo.type?lower_case?contains("date")>
		<#-- 日期 -->
		if (${attributeInfo.dbName} == null) {
			throw new ERPExceptionUtil("${attributeInfo.remarks}必填项，不能为空！");
		}
		<#elseif attributeInfo.type?lower_case?contains("double")>
		<#-- double -->
		if (${attributeInfo.dbName} == null) {
			throw new ERPExceptionUtil("${attributeInfo.remarks}必填项，不能为空！");
		}
		<#else >
		</#if>
	</#list>

		${entityCapName} ${entityLowerName} = new ${entityCapName}();
	<#list attributeInfos as attributeInfo>
		<#if attributeInfo.parmaryKey>
		<#-- 如果是主键则跳过 -->
		<#elseif attributeInfo.dbName?lower_case?contains("createtime")>
		<#-- 创建时间 -->
		${entityLowerName}.set${attributeInfo.dbName?cap_first}(new Date());
		<#elseif attributeInfo.dbName?lower_case?contains("createuserid")>
		<#-- 创建人 -->
		${entityLowerName}.set${attributeInfo.dbName?cap_first}(guideAccount.getId());
		<#elseif attributeInfo.type?lower_case?contains("integer") || attributeInfo.type?lower_case?contains("int")>
		<#-- 基本类型 -->
		${entityLowerName}.set${attributeInfo.dbName?cap_first}((int)${attributeInfo.dbName});
		<#elseif attributeInfo.type?lower_case?contains("long")>
		<#-- 基本类型 -->
		${entityLowerName}.set${attributeInfo.dbName?cap_first}(${attributeInfo.dbName});
		<#elseif attributeInfo.type?lower_case?contains("string")>
		<#-- 字符串 -->
		${entityLowerName}.set${attributeInfo.dbName?cap_first}(${attributeInfo.dbName});
		<#elseif attributeInfo.type?lower_case?contains("date")>
		<#-- 日期 -->
		${entityLowerName}.set${attributeInfo.dbName?cap_first}(${attributeInfo.dbName});
		<#elseif attributeInfo.type?lower_case?contains("double")>
		<#-- double -->
		${entityLowerName}.set${attributeInfo.dbName?cap_first}(${attributeInfo.dbName});
		</#if>
	</#list>
		${entityLowerName}Dao.save(${entityLowerName});

		return BaseResponse.success().setData(${entityLowerName}).build();
	}

	/**
	 * 根据主键查询${functionName}
	 */
	public BaseResponse find${entityCapName}ById(HttpServletRequest request) {

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

		String searchMapStr = request.getParameter("searchMap");
		String pageNo = request.getParameter("pageNo");

		RequestMap<String, Object> searchMap = fromJsonToMap(searchMapStr);
		Page<${entityCapName}> page = ${entityLowerName}Dao.findAll(build${entityCapName}Specification(searchMap), buildPageRequest(toInteger(pageNo), Sort.Direction.DESC, "id"));

		return BaseResponse.success().setData(page).build();
	}

}