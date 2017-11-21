package ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.service.impl;
<#macro idJava><#list columns as column><#if column.parmaryKey>${column.javaField?uncap_first}</#if></#list></#macro>
<#macro idCapJava><#list columns as column><#if column.parmaryKey>${column.javaField?cap_first}</#if></#list></#macro>
<#macro entityLowerName>${entityName?uncap_first}</#macro>
<#macro entityCapName>${entityName?cap_first}</#macro>
<#macro entityLowerMapper>${entityName?uncap_first}Mapper</#macro>

import ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.entity.<@entityCapName/>;
import ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.mapper.<@entityCapName/>Mapper;
import ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.service.<@entityCapName/>Service;
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

    @Override
    public long deleteByPrimaryKey(<@entityCapName/> <@entityLowerName/>) {
        return <@entityLowerMapper/>.deleteByPrimaryKey(<@entityLowerName/>);
    }

    @Override
    public long insertSelective(<@entityCapName/> <@entityLowerName/>) {
        long <@idJava/> = SqlSeqUtil.get("${tableName}");
        <@entityLowerName/>.set<@idCapJava/>(<@idJava/>);
        return <@entityLowerMapper/>.insertSelective(<@entityLowerName/>);
    }

    @Override
    public long updateSelective(<@entityCapName/> <@entityLowerName/>) {
        return <@entityLowerMapper/>.updateSelective(<@entityLowerName/>);
    }

    @Override
    public <@entityCapName/> selectByPrimaryKey(Long <@idJava/>) {
        return <@entityLowerMapper/>.selectByPrimaryKey(<@idJava/>);
    }

    @Override
    public List<<@entityCapName/>> selectSelective(<@entityCapName/> <@entityLowerName/>, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize, true);
        return <@entityLowerMapper/>.selectSelective(<@entityLowerName/>);
    }

}
