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
import com.common.exception.MyException;
import com.common.seq.sql.SqlSeqUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * @Title: ${functionName}
 * @Description: serviceImpl 实现类
 * @author ${functionAuthor}
 * @date ${time}
 */
@Slf4j
@Transactional
public class <@entityCapName/>ServiceImpl implements <@entityCapName/>Service {

    /** ${functionName}Mapper */
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
    public long batchInsert(List<<@entityCapNameParam/>> <@entityLowerNameParam/>s) {
        log.info("----------插入${functionName}开始----------");
        int index = 0;
        int length = <@entityLowerNameParam/>s.size();
        for (; index < length; index++) {
            <@idJavaType/> <@idJava/> = SqlSeqUtil.get("${tableName}");
            <@entityLowerNameParam/>s.get(index).set<@idCapJava/>(<@idJava/>);
            log.info("第{}个主键值：{}", index + 1, id);
        }
        long rowCount = <@entityLowerMapper/>.batchInsert(<@entityLowerNameParam/>s);
        log.info("----------插入${functionName}结束----------");

        if (rowCount != length) {
            throw new MyException("${functionName}新增数量不匹配");
        }
        return rowCount;
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
    public PageInfo<<@entityCapNameEntity/>> selectSelectiveByPage(<@entityCapNameParam/> <@entityLowerNameParam/>, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize, true);
        return new PageInfo<<@entityCapNameEntity/>>(<@entityLowerMapper/>.selectSelective(<@entityLowerNameParam/>));
    }

}
