package ${application.basePackage}.service;

import ${application.basePackage}.domain.${entityName};
import ${application.basePackage}.domain.repository.${entityName}Repository;
import ${application.basePackage}.exception.NotFoundException;
import ${application.basePackage}.exception.OptimisticLockingException;
import ${application.basePackage}.exception.ReferentialIntegrityException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.orm.ObjectOptimisticLockingFailureException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class ${entityName}Service {
    private static final Logger LOGGER = LoggerFactory.getLogger(${entityName}Service.class);
    private ${entityName}Repository repository;

    public ${entityName}Service(${entityName}Repository repository) {
        this.repository = repository;
    }

    public Iterable<${entityName}> findAll() {
        Sort sort = Sort.by(Sort.Direction.ASC, "stringField", "id");
        return repository.findAll(sort);
    }

    public Page<${entityName}> findAll(PageRequest pageable) {
        return repository.findAll(pageable);
    }

    public ${entityName} findById(Long id) throws NotFoundException {
        Optional<${entityName}> optional = repository.findById(id);
        if (optional.isEmpty()) {
            throw new NotFoundException(LOGGER, "${entityLabel}", id);
        }
        return optional.get();
    }

    public ${entityName} save(${entityName} entity) throws OptimisticLockingException {
        try {
            return repository.save(entity);
        } catch (ObjectOptimisticLockingFailureException e) {
            throw new OptimisticLockingException(LOGGER, "${entityLabel}", entity.getId(), e);
        }
    }

    public void delete(${entityName} entity) throws OptimisticLockingException, ReferentialIntegrityException {
        try {
            repository.delete(entity);
        } catch (ObjectOptimisticLockingFailureException e) {
            throw new OptimisticLockingException(LOGGER, "${entityLabel}", entity.getId(), e);
        } catch (DataIntegrityViolationException e) {
            throw new ReferentialIntegrityException(LOGGER, "${entityLabel}", entity.getId(), e);
        }
    }
}
