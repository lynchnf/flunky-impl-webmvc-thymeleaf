package ${basePackage};

<#list entities as entity>
import ${basePackage}.domain.${entity.entityName};
</#list>
<#list enums as enum>
import ${basePackage}.domain.${enum.enumName};
</#list>
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Random;

public class FakeDataFactory {
    private static final int[] POWERS_OF_10 = {1, 10, 100, 1000, 10000, 100000, 1000000, 100000000, 1000000000};
    private static final long YEAR_IN_MILLIS = 31536000000L;
    private static final int WORD_LENGTH = 4;
    private static final Random random = new Random();
<#list entities as entity>

    public static ${entity.entityName} nextRandom${entity.entityName}() {
        ${entity.entityName} entity = new ${entity.entityName}();
        entity.setId(1L);
        entity.setVersion(0);
    <#list entity.fields as field>
        <#if field.type == "String">
        entity.set${field.fieldName?cap_first}(nextRandomString(${field.length}));
        <#elseif field.type == "BigDecimal">
        entity.set${field.fieldName?cap_first}(nextRandomBigDecimal(${field.precision}, ${field.scale}));
        <#elseif field.type == "Boolean">
        entity.set${field.fieldName?cap_first}(nextRandomBoolean());
        <#elseif field.type == "Byte">
        entity.set${field.fieldName?cap_first}(nextRandomByte());
        <#elseif field.type == "Short">
        entity.set${field.fieldName?cap_first}(nextRandomShort());
        <#elseif field.type == "Integer">
        entity.set${field.fieldName?cap_first}(nextRandomInteger());
        <#elseif field.type == "Long">
        entity.set${field.fieldName?cap_first}(nextRandomLong());
        <#elseif field.type == "Date" && field.temporalType?? && field.temporalType="DATE">
        entity.set${field.fieldName?cap_first}(nextRandomDate());
        <#elseif field.type == "Date" && field.temporalType?? && field.temporalType="TIME">
        entity.set${field.fieldName?cap_first}(nextRandomTime());
        <#elseif field.type == "Date" && field.temporalType?? && field.temporalType="TIMESTAMP">
        entity.set${field.fieldName?cap_first}(nextRandomTimestamp());
        <#else>
        entity.set${field.fieldName?cap_first}(nextRandomEnum(${field.type}.class));
        </#if>
    </#list>
        return entity;
    }

    public static List<${entity.entityName}> nextRandom${entity.entityName}List(int listSize) {
        long id = 1;
        List<${entity.entityName}> entities = new ArrayList<>();
        while (entities.size() < listSize) {
            ${entity.entityName} entity = nextRandom${entity.entityName}();
            entity.setId(id++);
            entities.add(entity);
        }
        entities.sort(Comparator.comparing(${entity.entityName}::get${entity.mainField?cap_first}).thenComparing(${entity.entityName}::getId));
        return entities;
    }
</#list>

    private static String nextRandomString(int length) {
        int count = length / (WORD_LENGTH + 1) + 1;
        StringBuilder data = new StringBuilder();
        for (int i = 0; i < count; i++) {
            String word = RandomStringUtils.randomAlphabetic(WORD_LENGTH);
            word = StringUtils.lowerCase(word);
            word = StringUtils.capitalize(word);
            data.append(word);
            data.append(" ");
        }
        return StringUtils.trimToNull(data.toString().substring(0, length));
    }

    private static BigDecimal nextRandomBigDecimal(int precision, int scale) {
        int bound = POWERS_OF_10[POWERS_OF_10.length - 1];
        if (precision < POWERS_OF_10.length) {
            bound = POWERS_OF_10[precision];
        }
        long unscaledVal = random.nextLong(bound);
        return BigDecimal.valueOf(unscaledVal, scale);
    }

    private static Boolean nextRandomBoolean() {
        return random.nextBoolean();
    }

    private static Byte nextRandomByte() {
        int bound = Byte.MAX_VALUE / 2;
        return (byte) random.nextInt(bound);
    }

    private static Short nextRandomShort() {
        int bound = Short.MAX_VALUE / 2;
        return (short) random.nextInt(bound);
    }

    private static Integer nextRandomInteger() {
        int bound = Integer.MAX_VALUE / 2;
        return random.nextInt(bound);
    }

    private static Long nextRandomLong() {
        long bound = Long.MAX_VALUE / 2;
        return random.nextLong(bound);
    }

    private static long nextRandomTimestampMillis() {
        // returns a random timestamp (in milliseconds since 1/1/1970) equal to the current date plus or minus six months.
        return System.currentTimeMillis() + random.nextLong(YEAR_IN_MILLIS) - (YEAR_IN_MILLIS / 2);
    }

    private static Date nextRandomDate() {
        Calendar cal = Calendar.getInstance();
        cal.setTimeInMillis(nextRandomTimestampMillis());
        cal.set(Calendar.MILLISECOND, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        return cal.getTime();
    }

    private static Date nextRandomTime() {
        Calendar cal = Calendar.getInstance();
        cal.setTimeInMillis(nextRandomTimestampMillis());
        cal.set(Calendar.DAY_OF_MONTH, 1);
        cal.set(Calendar.MONTH, 0);
        cal.set(Calendar.YEAR, 1970);
        return cal.getTime();
    }

    private static Date nextRandomTimestamp() {
        return new Date(nextRandomTimestampMillis());
    }

    private static <T extends Enum<T>> T nextRandomEnum(Class<T> enumClass) {
        T[] enumConstants = enumClass.getEnumConstants();
        return enumConstants[random.nextInt(enumConstants.length)];
    }
}
