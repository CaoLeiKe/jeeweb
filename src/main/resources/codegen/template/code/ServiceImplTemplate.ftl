package ${packageName}.${moduleName}.natives.provider.service.impl;
<#macro idJava><#list columns as column><#if column.parmaryKey>${column.javaField?uncap_first}</#if></#list></#macro>
<#macro idCapJava><#list columns as column><#if column.parmaryKey>${column.javaField?cap_first}</#if></#list></#macro>
<#macro entityLowerName>${entityName?uncap_first}</#macro>
<#macro entityCapName>${entityName?cap_first}</#macro>
<#macro entityCapNameEntity>${entityName?cap_first}Entity</#macro>
<#macro entityLowerMapper>${entityName?uncap_first}Mapper</#macro>
<#macro entityCapService>${entityName?cap_first}Service</#macro>
<#macro idJavaType><#list columns as column><#if column.parmaryKey>${column.javaType}</#if></#list></#macro>
<#macro entityCapNameParam>${entityName?cap_first}Param</#macro>
<#macro entityLowerNameParam>${entityName?uncap_first}Param</#macro>

import ${packageName}.${moduleName}.natives.api.entity.<@entityCapNameEntity/>;
import ${packageName}.${moduleName}.natives.api.params.<@entityCapNameParam/>;
import ${packageName}.${moduleName}.natives.api.service.<@entityCapService/>;
import ${packageName}.${moduleName}.natives.provider.mapper.<@entityCapName/>Mapper;
import com.common.seq.sql.SqlSeqUtil;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * @Title: ${functionName}
 * @Description: serviceImpl 实现类
 * @author ${functionAuthor}
 * @date ${time}
 */
@Transactional
public class <@entityCapName/>ServiceImpl implements <@entityCapName/>Service {

    @Autowired
    private <@entityCapName/>Mapper <@entityLowerName/>Mapper;
<#--
    @Override
    public long deleteByPrimaryKey(<@entityCapName/> <@entityLowerName/>) {
        return <@entityLowerMapper/>.deleteByPrimaryKey(<@entityLowerName/>);
    } -->

    @Override
    public long insertSelective(<@entityCapNameParam/> <@entityLowerNameParam/>) {
        <@idJavaType/> <@idJava/> = SqlSeqUtil.get("${tableName}");
        <@entityLowerNameParam/>.set<@idCapJava/>(<@idJava/>);
        return <@entityLowerMapper/>.insertSelective(<@entityLowerNameParam/>);
    }

    @Override
    public long updateSelective(<@entityCapNameParam/> <@entityLowerNameParam/>) {
        return <@entityLowerMapper/>.updateSelective(<@entityLowerNameParam/>);
    }

    @Override
    public <@entityCapNameEntity/> selectByPrimaryKey(<@idJavaType/> <@idJava/>) {
        return <@entityLowerMapper/>.selectByPrimaryKey(<@idJava/>);
    }

    @Override
    public List<<@entityCapNameEntity/>> selectSelective(<@entityCapNameParam/> <@entityLowerNameParam/>) {
        return <@entityLowerMapper/>.selectSelective(<@entityLowerNameParam/>);
    }

    @Override
    public List<<@entityCapNameEntity/>> selectSelectiveByPage(<@entityCapNameParam/> <@entityLowerNameParam/>, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize, true);
        return <@entityLowerMapper/>.selectSelective(<@entityLowerNameParam/>);
    }

}
