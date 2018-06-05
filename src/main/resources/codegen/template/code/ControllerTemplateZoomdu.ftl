package com.zoomdu.controller;

<#-- 大写类名 -->
<#assign entityCapName=entityName?cap_first/>
<#-- 小写类名 -->
<#assign entityLowerName=entityName?uncap_first/>
import com.zoomdu.controller.base.responseEntity.BaseResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("${tableName?replace("_", ".")}")
public class ${entityCapName}Controller {

	@Autowired
	private ${entityCapName}Service ${entityLowerName}Service;

	@RequestMapping(params = "method=find${entityCapName}ById")
	public BaseResponse find${entityCapName}ById(HttpServletRequest request) {
		return ${entityLowerName}Service.find${entityCapName}ById(request);
	}

	@RequestMapping(params = "method=find${entityCapName}PageBySearchMap")
	public BaseResponse find${entityCapName}ById(HttpServletRequest request) {
		return ${entityLowerName}Service.find${entityCapName}PageBySearchMap(request);
	}

	@RequestMapping(params = "method=save${entityCapName}")
	public BaseResponse save${entityCapName}(HttpServletRequest request) {
		return ${entityLowerName}Service.save${entityCapName}(request);
	}

}
