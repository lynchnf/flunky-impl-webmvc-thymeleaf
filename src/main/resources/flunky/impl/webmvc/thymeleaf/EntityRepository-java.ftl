package ${application.basePackage}.domain.repository;

import ${application.basePackage}.domain.${entityName};
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface ${entityName}Repository
        extends CrudRepository<${entityName}, Long>, PagingAndSortingRepository<${entityName}, Long> {
}
