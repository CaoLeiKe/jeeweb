package ${packageName}.${moduleName}.natives.api.service;
<#macro idJava><#list columns as column><#if column.parmaryKey>${column.javaField?uncap_first}</#if></#list></#macro>
<#macro entityLowerName>${entityName?uncap_first}</#macro>
<#macro entityCapName>${entityName?cap_first}</#macro>
<#macro entityCapNameEntity>${entityName?cap_first}Entity</#macro>
<#macro entityLowerNameEntity>${entityName?uncap_first}Entity</#macro>
<#macro idJavaType><#list columns as column><#if column.parmaryKey>${column.javaType}</#if></#list></#macro>
<#macro entityCapNameParam>${entityName?cap_first}Param</#macro>
<#macro entityLowerNameParam>${entityName?uncap_first}Param</#macro>
<#macro entityNameToSpace><#list 0..entityName?length as i> </#list></#macro>
<#macro pageNumToSpace><#list 3..entityName?length as i> </#list></#macro>
<#macro pageSizeToSpace><#list 4..entityName?length as i> </#list></#macro>

import ${packageName}.${moduleName}.natives.api.entity.<@entityCapNameEntity/>;
import ${packageName}.${moduleName}.natives.api.params.<@entityCapNameParam/>;
import com.github.pagehelper.PageInfo;

import java.util.List;

/**
 * @Title: ${functionName}
 * @Description: Service 接口
 * @Author ${functionAuthor}
 * @Date ${time}
 */
public interface <@entityCapName/>Service {
<#--
    /**
     * 根据主键逻辑删除，需传入实体，并包含主键和修改人，其中修改人可有可无
     *
     * @param <@entityLowerName/> ${functionName}实体
     * @return 受影响的行数
     */
    long deleteByPrimaryKey(<@entityCapName/> <@entityLowerName/>); -->

    /**
     * 新增${functionName}
     *
     * @param <@entityLowerNameParam/> ${functionName}实体
     * @return 受影响的行数
     */
    long insert(<@entityCapNameParam/> <@entityLowerNameParam/>);

    /**
     * 批量新增${functionName}
     *
     * @param <@entityLowerNameParam/>s ${functionName}集合实体
     * @return 受影响的行数
     */
    long batchInsert(List<<@entityCapNameParam/>> <@entityLowerNameParam/>s);

    /**
     * 根据${functionName}实体中的主键更改数据，无法更改主键和创建者、创建时间的信息
     *
     * @param <@entityLowerNameParam/> ${functionName}实体
     * @return 受影响的行数
     */
    long updateSelective(<@entityCapNameParam/> <@entityLowerNameParam/>);

    /**
     * 根据主键查询${functionName}
     *
     * @param <@idJava/> ${functionName}主键
     * @return 查询的结果
     */
    <@entityCapNameEntity/> selectByPrimaryKey(<@idJavaType/> <@idJava/>);

    /**
     * 根据${functionName}实体的条件分页查询数据
     *
     * @param <@entityLowerNameParam/> ${functionName}实体
     * @param pageNum <@pageNumToSpace/>第几页
     * @param pageSize <@pageSizeToSpace/>每页显示的数量
     * @return 分页查询的结果
     */
    PageInfo<<@entityCapNameEntity/>> selectSelectiveByPage(<@entityCapNameParam/> <@entityLowerNameParam/>, int pageNum, int pageSize);

}

