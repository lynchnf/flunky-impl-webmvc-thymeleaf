package ${application.basePackage}.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.persistence.Version;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Entity
public class EntityOne implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Version
    private Integer version = 0;
<#list fields as field>
    <#if field.enumType??>
    @Enumerated(EnumType.${field.enumType})
    <#elseif field.type == "Date">
    @Temporal(TemporalType.${field.temporalType})
    </#if>
    <#assign myParms = [] />
    <#if field.length??><#assign myParms = myParms + [ "length = ${field.length}" ] /></#if>
    <#if field.precision??><#assign myParms = myParms + [ "precision = ${field.precision}" ] /></#if>
    <#if field.scale??><#assign myParms = myParms + [ "scale = ${field.scale}" ] /></#if>
    <#if field.nullable?? && field.nullable == "false"><#assign myParms = myParms + [ "nullable = false" ] /></#if>
    <#list myParms>
    @Column(<#items as myParm>${myParm}<#sep>, </#sep></#items>)
    </#list>
    private ${field.type} ${field.fieldName};
</#list>

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }
<#list fields as field>

    public ${field.type} get${field.fieldName?cap_first}() {
        return ${field.fieldName};
    }

    public void set${field.fieldName?cap_first}(${field.type} ${field.fieldName}) {
        this.${field.fieldName} = ${field.fieldName};
    }
</#list>

    @Override
    public String toString() {
        return ${toString};
    }
}
