package norman.flunky.impl.webmvc.thymeleaf;

import norman.flunky.api.GenerationBean;
import norman.flunky.api.ProjectType;
import norman.flunky.api.TemplateType;

import java.util.ArrayList;
import java.util.List;

import static norman.flunky.api.TemplateType.COPY;
import static norman.flunky.api.TemplateType.GENERATE;

public class ImplWebmvcThymeleaf implements ProjectType {
    private List<GenerationBean> applicationGenerationProperties = new ArrayList<>();
    private List<GenerationBean> enumGenerationProperties = new ArrayList<>();
    private List<GenerationBean> entityGenerationProperties = new ArrayList<>();

    public ImplWebmvcThymeleaf() {
        // There is some weirdness with Maven not copying the .gitignore resource into the .jar file, so I have
        // side-stepped this issue by removing the leading dot in the template file's name.
        applicationGenerationProperties.add(new GenerationBean("gitignore", "/.gitignore", TemplateType.COPY));
        applicationGenerationProperties.add(
                new GenerationBean("application.properties", "/src/main/resources/application.properties", COPY));
        applicationGenerationProperties.add(new GenerationBean("Application-java.ftl",
                "/src/main/java/${basePackage?replace(\".\", \"/\")}/Application.java", GENERATE));
        applicationGenerationProperties.add(new GenerationBean("ApplicationTest-java.ftl",
                "/src/test/java/${basePackage?replace(\".\", \"/\")}/ApplicationTest.java", GENERATE));
        applicationGenerationProperties.add(
                new GenerationBean("common.js", "/src/main/resources/static/js/common.js", COPY));
        applicationGenerationProperties.add(new GenerationBean("FakeDataFactory-java.ftl",
                "/src/test/java/${basePackage?replace(\".\", \"/\")}/FakeDataFactory.java", GENERATE));
        applicationGenerationProperties.add(
                new GenerationBean("index-html.ftl", "/src/main/resources/templates/index.html", GENERATE));
        applicationGenerationProperties.add(
                new GenerationBean("jquery-3.7.1.min.js", "/src/main/resources/static/js/jquery-3.7.1.min.js", COPY));
        applicationGenerationProperties.add(
                new GenerationBean("logback-xml.ftl", "/src/main/resources/logback.xml", GENERATE));
        applicationGenerationProperties.add(
                new GenerationBean("main.css", "/src/main/resources/static/css/main.css", COPY));
        applicationGenerationProperties.add(new GenerationBean("NotFoundException-java.ftl",
                "/src/main/java/${basePackage?replace(\".\", \"/\")}/exception/NotFoundException.java", GENERATE));
        applicationGenerationProperties.add(new GenerationBean("NotFoundExceptionTest-java.ftl",
                "/src/test/java/${basePackage?replace(\".\", \"/\")}/exception/NotFoundExceptionTest.java", GENERATE));
        applicationGenerationProperties.add(new GenerationBean("OptimisticLockingException-java.ftl",
                "/src/main/java/${basePackage?replace(\".\", \"/\")}/exception/OptimisticLockingException.java",
                GENERATE));
        applicationGenerationProperties.add(new GenerationBean("OptimisticLockingExceptionTest-java.ftl",
                "/src/test/java/${basePackage?replace(\".\", \"/\")}/exception/OptimisticLockingExceptionTest.java",
                GENERATE));
        applicationGenerationProperties.add(new GenerationBean("pom-xml.ftl", "/pom.xml", GENERATE));
        applicationGenerationProperties.add(new GenerationBean("readme-md.ftl", "/README.md", GENERATE));
        applicationGenerationProperties.add(new GenerationBean("ReferentialIntegrityException-java.ftl",
                "/src/main/java/${basePackage?replace(\".\", \"/\")}/exception/ReferentialIntegrityException.java",
                GENERATE));
        applicationGenerationProperties.add(new GenerationBean("ReferentialIntegrityExceptionTest-java.ftl",
                "/src/test/java/${basePackage?replace(\".\", \"/\")}/exception/ReferentialIntegrityExceptionTest.java",
                GENERATE));

        enumGenerationProperties.add(new GenerationBean("Enum-java.ftl",
                "/src/main/java/${application.basePackage?replace(\".\", \"/\")}/domain/${enumName}.java", GENERATE));

        entityGenerationProperties.add(new GenerationBean("Entity-java.ftl",
                "/src/main/java/${application.basePackage?replace(\".\", \"/\")}/domain/${entityName}.java", GENERATE));
        entityGenerationProperties.add(new GenerationBean("EntityRepository-java.ftl",
                "/src/main/java/${application.basePackage?replace(\".\", \"/\")}/domain/repository/${entityName}Repository.java",
                GENERATE));
        entityGenerationProperties.add(new GenerationBean("EntityService-java.ftl",
                "/src/main/java/${application.basePackage?replace(\".\", \"/\")}/service/${entityName}Service.java",
                GENERATE));
        entityGenerationProperties.add(new GenerationBean("EntityServiceTest-java.ftl",
                "/src/test/java/${application.basePackage?replace(\".\", \"/\")}/service/${entityName}ServiceTest.java",
                GENERATE));
    }

    @Override
    public String getTemplatePrefix() {
        return "flunky/impl/webmvc/thymeleaf";
    }

    @Override
    public List<GenerationBean> getApplicationGenerationProperties() {
        return applicationGenerationProperties;
    }

    @Override
    public List<GenerationBean> getEntityGenerationProperties() {
        return entityGenerationProperties;
    }

    @Override
    public List<GenerationBean> getEnumGenerationProperties() {
        return enumGenerationProperties;
    }
}
