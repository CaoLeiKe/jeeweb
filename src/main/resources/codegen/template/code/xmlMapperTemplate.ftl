<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<#macro idJdbc><#list columns as column><#if column.parmaryKey>t.${column.columnName} = ${r"#"}{${column.javaField}, jdbcType=${column.typeName}}</#if></#list></#macro>
<#macro entityCapName>${entityName?cap_first}</#macro>
<mapper namespace="${packageName}<#if moduleName?exists><#if moduleName!=''>.${moduleName}</#if></#if>.mapper.<@entityCapName/>Mapper">

    <!-- 结果集映射 -->
    <resultMap id="BaseResultMap" type="${packageName}.${moduleName}.entity.${entityName}">
    <#list columns as column>
        <#if column.parmaryKey>
        <id column="${column.columnName}" property="${column.javaField}" jdbcType="${column.typeName}"/>
        <#else>
        <result column="${column.columnName}" property="${column.javaField}" jdbcType="${column.typeName}"/>
        </#if>
    </#list>
    </resultMap>

    <!-- 字段 -->
    <sql id="Base_Column_List">
        <#list columns as column><#if column_index%5 == 0 && column_index != 0>

        </#if><#if column_index == 0>        </#if>t.${column.columnName}<#if column_has_next>, </#if></#list>
    </sql>

    <!-- 根据主键逻辑删除，需传入实体，并包含主键和修改人，其中修改人可有可无 -->
    <update id="deleteByPrimaryKey" parameterType="${packageName}.${moduleName}.entity.${entityName}">
        update ${tableName} t set t.is_delete = 1
    <#list columns as column>
        <#if column.columnName?lower_case?contains("update") && column.columnName?lower_case?contains("time")>
        , ${column.columnName} = now()
        <#elseif column.columnName?lower_case?contains("update") && column.columnName?lower_case?contains("id")>
        <if test="${column.javaField} != null">
            , ${column.columnName} = ${r"#"}{${column.javaField}, jdbcType=${column.typeName}}
        </if>
        </#if>
    </#list>
        where <@idJdbc/>
    </update>

    <!-- 插入数据 -->
    <insert id="insertSelective" parameterType="${packageName}.${moduleName}.entity.${entityName}">
        insert into ${tableName}
        <trim prefix="(" suffix=")" suffixOverrides=",">
        <#list columns as column>
            <#if column.columnName?starts_with("is_")>
            ${column.columnName},
            <#else>
            <if test="${column.javaField} != null">
                ${column.columnName},
            </if>
            </#if>
        </#list>
        </trim>
        <trim prefix="values (" suffix=")" suffixOverrides=",">
        <#list columns as column>
            <#if column.columnName?lower_case?ends_with("time")>
            now(),
            <#elseif column.columnName?starts_with("is_")>
            <choose>
                <when test="${column.javaField} != null">
                    ${r'#{'}${column.javaField}, jdbcType=${column.typeName}},
                </when>
                <otherwise>
                    0,
                </otherwise>
            </choose>
            <#else>
            <if test="${column.javaField} != null">
                ${r'#{'}${column.javaField}, jdbcType=${column.typeName}},
            </if>
            </#if>
        </#list>
        </trim>
    </insert>

    <!-- 根据实体中的主键条件更改数据，无法更改主键和创建者、创建时间的信息 -->
    <update id="updateSelective" parameterType="${packageName}.${moduleName}.entity.${entityName}">
        update ${tableName}
        <set>
        <#list columns as column>
            <#if column.parmaryKey || column.columnName?lower_case?contains("create")>
            <#-- 主键跳过,创建人跳过，创建时间跳过 -->
            <#elseif column.columnName?lower_case?contains("update") && column.columnName?lower_case?contains("time")>
            ${column.columnName} = now(),
            <#else>
            <if test="${column.javaField} != null">
                ${column.columnName} = ${r"#"}{${column.javaField}, jdbcType=${column.typeName}},
            </if>
            </#if>
        </#list>
        </set>
        <where>
            <@idJdbc/>
        </where>
    </update>

    <!-- 根据主键查询 -->
    <select id="selectByPrimaryKey" resultMap="BaseResultMap" parameterType="java.lang.Long">
        select
        <include refid="Base_Column_List"/>
        from ${tableName} t
        where <@idJdbc/>
    </select>

    <!-- 根据条件查询，如果是时间则查找的是当天的时间 -->
    <select id="selectSelective" resultMap="BaseResultMap" parameterType="${packageName}.${moduleName}.entity.${entityName}">
        select
        <include refid="Base_Column_List"/>
        from ${tableName} t
        <where>
        <#list columns as column>
            <#-- 如果是时间类型则匹配当天 -->
            <#if column.columnName?lower_case?contains("time")>
            <if test="${column.javaField} != null">
                and UNIX_TIMESTAMP(Date(${column.columnName})) = UNIX_TIMESTAMP(Date(${r"#"}{${column.javaField}, jdbcType=${column.typeName}}))
            </if>
            <#else>
            <if test="${column.javaField} != null">
                and ${column.columnName} = ${r"#"}{${column.javaField}, jdbcType=${column.typeName}}
            </if>
            </#if>
        </#list>
        </where>
    </select>
</mapper>