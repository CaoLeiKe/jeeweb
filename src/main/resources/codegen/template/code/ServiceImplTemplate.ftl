package ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.service.impl;
<#macro idJava><#list columns as column><#if column.parmaryKey>${column.javaField}</#if></#list></#macro>
<#macro idCapJava><#list columns as column><#if column.parmaryKey>${column.javaField?cap_first}</#if></#list></#macro>
<#macro entityLowerName>${entityName?lower_case}</#macro>
<#macro entityCapName>${entityName?cap_first}</#macro>
<#macro entityLowerMapper>${entityName?lower_case}Mapper</#macro>

import ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.entity.<@entityCapName/>;
import ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.mapper.<@entityCapName/>Mapper;
import ${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.service.<@entityCapName/>Service;
import com.common.seq.sql.SqlSeqUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.richgo.common.CodeConts;
import org.apache.commons.lang3.tuple.Pair;
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
    public Pair<Boolean, Object> deleteByPrimaryKey(<@entityCapName/> <@entityLowerName/>) {
        long rowCount = <@entityLowerMapper/>.deleteByPrimaryKey(<@entityLowerName/>);
        if (rowCount == 1) {
            return Pair.of(Boolean.TRUE, rowCount);
        } else {
            return Pair.of(Boolean.FALSE, rowCount);
        }
    }

    @Override
    public Pair<Boolean, Object> insertSelective(<@entityCapName/> <@entityLowerName/>) {
        long <@idJava/> = SqlSeqUtil.get("${tableName}");
        <@entityLowerName/>.set<@idCapJava/>(<@idJava/>);
        long rowCount = <@entityLowerMapper/>.insertSelective(<@entityLowerName/>);
        if (rowCount == 1) {
            return Pair.of(Boolean.TRUE, rowCount);
        } else {
            return Pair.of(Boolean.FALSE, rowCount);
        }
    }

    @Override
    public Pair<Boolean, Object> updateByPrimaryKey(<@entityCapName/> <@entityLowerName/>) {
        long rowCount = <@entityLowerMapper/>.updateByPrimaryKey(<@entityLowerName/>);
        if (rowCount == 1) {
            return Pair.of(Boolean.TRUE, rowCount);
        } else {
            return Pair.of(Boolean.FALSE, rowCount);
        }
    }

    @Override
    public Pair<Boolean, Object> updateSelective(<@entityCapName/> <@entityLowerName/>) {
        long rowCount = <@entityLowerMapper/>.updateSelective(<@entityLowerName/>);
        if (rowCount == 1) {
            return Pair.of(Boolean.TRUE, rowCount);
        } else {
            return Pair.of(Boolean.FALSE, rowCount);
        }
    }

    @Override
    public Pair<Boolean, Object> selectByPrimaryKey(Long <@idJava/>) {
        <@entityCapName/> <@entityLowerName/> = <@entityLowerMapper/>.selectByPrimaryKey(<@idJava/>);
        if (<@entityLowerName/> != null) {
            return Pair.of(Boolean.TRUE, <@entityLowerName/>);
        } else {
            return Pair.of(Boolean.FALSE, CodeConts.DATA_IS_NUll);
        }
    }

    @Override
    public Pair<Boolean, Object> selectSelective(<@entityCapName/> <@entityLowerName/>, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize, true);
        List<<@entityCapName/>> <@entityLowerName/>s = <@entityLowerMapper/>.selectSelective(<@entityLowerName/>);
        if (<@entityLowerName/>s != null && <@entityLowerName/>s.size() > 0) {
            return Pair.of(Boolean.TRUE, new PageInfo<>(<@entityLowerName/>s));
        } else {
            return Pair.of(Boolean.FALSE, CodeConts.DATA_IS_NUll);
        }
    }

}
