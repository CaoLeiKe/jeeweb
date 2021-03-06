package ${packageName}.${moduleName}.test.service;
<#macro idCapJava><#list columns as column><#if column.parmaryKey>${column.javaField?cap_first}</#if></#list></#macro>
<#macro idLowerJava><#list columns as column><#if column.parmaryKey>${column.javaField?uncap_first}</#if></#list></#macro>
<#macro idJavaType><#list columns as column><#if column.parmaryKey>${column.javaType}</#if></#list></#macro>
<#macro entityCapName>${entityName?cap_first}</#macro>
<#macro entityLowerName>${entityName?uncap_first}</#macro>
<#macro entityCapService>${entityName?cap_first}Service</#macro>
<#macro entityLowerService>${entityName?uncap_first}Service</#macro>

import ${packageName}.${moduleName}.core.TestSupport;
import ${packageName}.${moduleName}.entity.<@entityCapName/>;
import ${packageName}.${moduleName}.service.<@entityCapService/>;
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
    public void insert<@entityCapName/>() throws Exception {
        <@entityCapName/> <@entityLowerName/> = new <@entityCapName/>();
        SetPropertiesUtil.setProperties(<@entityLowerName/>);
        long rowCount = <@entityLowerService/>.insertSelective(<@entityLowerName/>);
        Assert.assertEquals(1, rowCount);
        update<@entityCapName/>(<@entityLowerName/>);
    }

    /**
     * 更新
     */
    @Test
    public void update<@entityCapName/>(<@entityCapName/> <@entityLowerName/>) throws Exception {
        <@idJavaType/> <@idLowerJava/> = <@entityLowerName/>.get<@idCapJava/>();
        SetPropertiesUtil.setProperties(<@entityLowerName/>);
        <@entityLowerName/>.set<@idCapJava/>(<@idLowerJava/>);
        long rowCount = <@entityLowerService/>.updateSelective(<@entityLowerName/>);
        Assert.assertEquals(1, rowCount);
        get<@entityCapName/>(<@idLowerJava/>);
    }

    /**
     * 查询
     */
    @Test
    public void get<@entityCapName/>(<@idJavaType/> <@idLowerJava/>) throws Exception {
        <@entityCapName/> <@entityLowerName/> = <@entityLowerService/>.selectByPrimaryKey(<@idLowerJava/>);
        Assert.assertNotNull(<@entityLowerName/>);
        <#-- delete<@entityCapName/>(<@entityLowerName/>.get<@idCapJava/>()); -->
    }
<#--
    /**
     * 删除
     */
    @Test
    public void delete<@entityCapName/>(<@idJavaType/> <@idLowerJava/>) throws Exception {
        <@entityCapName/> <@entityLowerName/> = new <@entityCapName/>();
        <@entityLowerName/>.set<@idCapJava/>(<@idLowerJava/>);
        long rowCount = <@entityLowerService/>.deleteByPrimaryKey(<@entityLowerName/>);
        Assert.assertEquals(1, rowCount);
    } -->
}
