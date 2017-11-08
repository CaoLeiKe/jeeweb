package ${packageName}.${moduleName}.test.service;
<#macro idCapJava><#list columns as column><#if column.parmaryKey>${column.javaField?cap_first}</#if></#list></#macro>
<#macro idLowerJava><#list columns as column><#if column.parmaryKey>${column.javaField?lower_case}</#if></#list></#macro>
<#macro idJavaType><#list columns as column><#if column.parmaryKey>${column.javaType}</#if></#list></#macro>
<#macro entityCapName>${entityName?cap_first}</#macro>
<#macro entityLowerName>${entityName?lower_case}</#macro>
<#macro entityCapService>${entityName?cap_first}Service</#macro>
<#macro entityLowerService>${entityName?lower_case}Service</#macro>

import ${packageName}.${moduleName}.service.<@entityCapService/>;
import ${packageName}.${moduleName}.core.TestSupport;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @Title: ${functionName}
 * @Description: TestServiceImpl
 * @author ${functionAuthor}
 * @date ${time}
 */
public class <@entityCapService/>Test extends TestSupport {

    @Autowired
    <@entityCapService/> <@entityLowerService/>;

    /**
     * 添加
     */
    @Test
    public void insertSelective() throws Exception {
        <@entityCapName/> <@entityLowerName/> = new <@entityCapName/>();
        SetProperties.setProperties(<@entityLowerName/>);
        Pair<Boolean, Object> pair = <@entityLowerService/>.insertSelective(<@entityLowerName/>);
        Assert.assertTrue(pair.getKey());
        updateByPrimaryKey(<@entityLowerName/>);
    }

    /**
     * 更新
     */
    @Test
    public void updateByPrimaryKey(<@entityCapName/> <@entityLowerName/>) throws Exception {
        <@idJavaType/> <@idLowerJava/> = <@entityLowerName/>.get<@idCapJava/>();
        SetProperties.setRandomProperties(<@entityLowerName/>);
        <@entityLowerName/>.set<@idCapJava/>(<@idLowerJava/>);
        Pair<Boolean, Object> pair = <@entityLowerService/>.updateByPrimaryKey(<@entityLowerName/>);
        Assert.assertTrue(pair.getKey());
        selectByPrimaryKey(<@idLowerJava/>);
    }

    /**
     * 查询
     */
    @Test
    public void selectByPrimaryKey(<@idJavaType/> <@idLowerJava/>) throws Exception {
        Pair<Boolean, Object> pair = <@entityLowerService/>.selectByPrimaryKey(<@idLowerJava/>);
        Assert.assertTrue(pair.getKey());
    }

    /**
     * 删除
     */
    @Test
    public void deleteByPrimaryKey(<@idJavaType/> <@idLowerJava/>) throws Exception {
        <@entityCapName/> <@entityLowerName/> = new <@entityCapName/>();
        <@entityLowerName/>.set<@idCapJava/>(<@idLowerJava/>);
        Pair<Boolean, Object> pair = <@entityLowerService/>.deleteByPrimaryKey(<@entityLowerName/>);
        Assert.assertTrue(pair.getKey());
    }
}
