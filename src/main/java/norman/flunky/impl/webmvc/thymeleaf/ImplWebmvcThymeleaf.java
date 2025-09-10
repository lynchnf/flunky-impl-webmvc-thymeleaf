package norman.flunky.impl.webmvc.thymeleaf;

import norman.flunky.api.GenerationBean;
import norman.flunky.api.ProjectType;

import java.util.ArrayList;
import java.util.List;

import static norman.flunky.api.TemplateType.COPY;
import static norman.flunky.api.TemplateType.GENERATE;

public class ImplWebmvcThymeleaf implements ProjectType {
    private List<GenerationBean> applicationGenerationProperties = new ArrayList<>();
    private List<GenerationBean> enumGenerationProperties = new ArrayList<>();
    private List<GenerationBean> entityGenerationProperties = new ArrayList<>();

    public ImplWebmvcThymeleaf() {
        applicationGenerationProperties.add(
                new GenerationBean("application.properties", "/src/main/resources/application.properties", COPY));
        applicationGenerationProperties.add(new GenerationBean("Application-java.ftl",
                "/src/main/java/${basePackage?replace(\".\", \"/\")}/Application.java", GENERATE));
        applicationGenerationProperties.add(new GenerationBean("pom-xml.ftl", "/pom.xml", GENERATE));
        applicationGenerationProperties.add(new GenerationBean("readme-md.ftl", "/README.md", GENERATE));
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
