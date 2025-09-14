<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <property name="LOG_FILE_HOME" value="logs" />
    <property name="LOG_FILE_NAME" value="${artifactId}" />
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger{1}.%method - %message%n</pattern>
        </encoder>
    </appender>
    <appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>${r"${"}LOG_FILE_HOME}/${r"${"}LOG_FILE_NAME}.log</file>
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger - %message%n</pattern>
        </encoder>
        <rollingPolicy class="ch.qos.logback.core.rolling.SizeAndTimeBasedRollingPolicy">
            <fileNamePattern>${r"${"}LOG_FILE_HOME}/${r"${"}LOG_FILE_NAME}-%d{yyyy-MM-dd}-%i.log</fileNamePattern>
            <maxFileSize>50MB</maxFileSize>
            <maxHistory>30</maxHistory>
            <totalSizeCap>10GB</totalSizeCap>
            <cleanHistoryOnStart>true</cleanHistoryOnStart>
        </rollingPolicy>
    </appender>
    <root level="info">
        <appender-ref ref="FILE" />
        <appender-ref ref="STDOUT" />
    </root>
    <logger name="${basePackage}" level="debug" />
    <logger name="org.hibernate.SQL" level="debug" />
    <logger name="org.hibernate.type.descriptor.sql.BasicBinder" level="trace" />
    <logger name="org.hibernate.orm.jdbc.bind" level="trace" />
</configuration>
