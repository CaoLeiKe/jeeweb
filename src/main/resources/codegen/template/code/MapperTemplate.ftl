package ${packageName}.${moduleName}.natives.provider.mapper;
<#macro idJava><#list columns as column><#if column.parmaryKey>${column.javaField?uncap_first}</#if></#list></#macro>
<#macro entityLowerName>${entityName?uncap_first}</#macro>
<#macro entityCapName>${entityName?cap_first}</#macro>
<#macro idJavaType><#list columns as column><#if column.parmaryKey>${column.javaType}</#if></#list></#macro>
<#macro entityCapNameParam>${entityName?cap_first}Param</#macro>
<#macro entityLowerNameParam>${entityName?uncap_first}Param</#macro>
<#macro entityCapNameEntity>${entityName?cap_first}Entity</#macro>

import ${packageName}.${moduleName}.natives.api.entity.<@entityCapNameEntity/>;
import ${packageName}.${moduleName}.natives.api.params.<@entityCapNameParam/>;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Title: ${functionName}
 * @Description: mapper SQL层
 * @author ${functionAuthor}
 * @date ${time}
 */
@Repository
public interface <@entityCapName/>Mapper {
<#--
    /**
     * 根据主键逻辑删除，需传入${functionName}实体，并包含主键和修改人，其中修改人可有可无
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
    long insertSelective(@Param("<@entityLowerNameParam/>") <@entityCapNameParam/> <@entityLowerNameParam/>);

    /**
     * 批量新增${functionName}
     *
     * @param <@entityLowerNameParam/> ${functionName}实体
     * @return 受影响的行数
     */
    long batchInsert(@Param("<@entityLowerNameParam/>s") List<<@entityCapNameParam/>> <@entityLowerNameParam/>s);

    /**
     * 根据${functionName}实体中的条件更改数据，无法更改主键和创建者、创建时间的信息
     *
     * @param <@entityLowerNameParam/> ${functionName}实体
     * @return 受影响的行数
     */
    long updateSelective(@Param("<@entityLowerNameParam/>") <@entityCapNameParam/> <@entityLowerNameParam/>);

    /**
     * 根据主键查询${functionName}
     *
     * @param <@idJava/> ${functionName}主键
     * @return ${functionName}
     */
    <@entityCapNameEntity/> selectByPrimaryKey(@Param("<@idJava/>") <@idJavaType/> <@idJava/>);

    /**
     * 根据${functionName}实体的条件查询数据
     *
     * @param <@entityLowerNameParam/> ${functionName}实体
     * @return ${functionName}的集合
     */
    List<<@entityCapNameEntity/>> selectSelective(@Param("<@entityLowerNameParam/>") <@entityCapNameParam/> <@entityLowerNameParam/>);

}