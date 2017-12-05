package ${packageName}.${moduleName}.natives.provider;
<#macro idCapJava><#list columns as column><#if column.parmaryKey>${column.javaField?cap_first}</#if></#list></#macro>
<#macro idLowerJava><#list columns as column><#if column.parmaryKey>${column.javaField?uncap_first}</#if></#list></#macro>
<#macro idJavaType><#list columns as column><#if column.parmaryKey>${column.javaType}</#if></#list></#macro>
<#macro entityCapName>${entityName?cap_first}</#macro>
<#macro entityCapNameEntity>${entityName?cap_first}Entity</#macro>
<#macro entityLowerNameEntity>${entityName?uncap_first}Entity</#macro>
<#macro entityLowerName>${entityName?uncap_first}</#macro>
<#macro entityCapService>${entityName?cap_first}Service</#macro>
<#macro entityLowerService>${entityName?uncap_first}Service</#macro>
<#macro entityCapNameParam>${entityName?cap_first}Param</#macro>
<#macro entityLowerNameParam>${entityName?uncap_first}Param</#macro>

import ${packageName}.${moduleName}.core.TestSupport;
import ${packageName}.${moduleName}.natives.api.entity.<@entityCapNameEntity/>;
import ${packageName}.${moduleName}.natives.api.params.<@entityCapNameParam/>;
import ${packageName}.${moduleName}.natives.api.service.<@entityCapService/>;
import ${packageName}.${moduleName}.utils.SetPropertiesUtil;
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

    /** ${functionName}Service */
    @Autowired
    <@entityCapService/> <@entityLowerService/>;

    /**
     * 添加
     */
    @Test
    public void insert<@entityCapName/>() throws Exception {
        <@entityCapNameParam/> <@entityLowerNameParam/> = new <@entityCapNameParam/>();
        SetPropertiesUtil.setProperties(<@entityLowerNameParam/>);
        long rowCount = <@entityLowerService/>.insertSelective(<@entityLowerNameParam/>);
        Assert.assertEquals(1, rowCount);
        update<@entityCapName/>(<@entityLowerNameParam/>);
    }

    /**
     * 更新
     */
    public void update<@entityCapName/>(<@entityCapNameParam/> <@entityLowerNameParam/>) throws Exception {
        <@idJavaType/> <@idLowerJava/> = <@entityLowerNameParam/>.get<@idCapJava/>();
        SetPropertiesUtil.setProperties(<@entityLowerNameParam/>);
        <@entityLowerNameParam/>.set<@idCapJava/>(<@idLowerJava/>);
        long rowCount = <@entityLowerService/>.updateSelective(<@entityLowerNameParam/>);
        Assert.assertEquals(1, rowCount);
        get<@entityCapName/>(<@idLowerJava/>);
    }

    /**
     * 查询
     */
    public void get<@entityCapName/>(<@idJavaType/> <@idLowerJava/>) throws Exception {
        <@entityCapNameEntity/> <@entityLowerNameEntity/> = <@entityLowerService/>.selectByPrimaryKey(<@idLowerJava/>);
        Assert.assertNotNull(<@entityLowerNameEntity/>);
        batchInsert<@entityCapName/>();
    }



   /**
    * 批量新增
    */
    public void batchInsert<@entityCapName/>() throws Exception {
        List<<@entityCapName/>> <@entityLowerName/>s = new ArrayList<>();
        for (int i = 0; i < 5; i++) {
            <@entityCapName/> <@entityLowerName/> = new <@entityCapName/>();
            SetPropertiesUtil.setProperties(<@entityLowerName/>);
            <@entityLowerName/>s.add(<@entityLowerName/>);
        }
        long rowCount = <@entityLowerService/>.batchInsert(<@entityLowerName/>s);
        Assert.assertEquals(5, rowCount);
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
