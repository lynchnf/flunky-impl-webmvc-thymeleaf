package ${application.basePackage}.service;

import ${application.basePackage}.FakeDataFactory;
import ${application.basePackage}.domain.${entityName};
import ${application.basePackage}.domain.repository.${entityName}Repository;
import ${application.basePackage}.exception.NotFoundException;
import ${application.basePackage}.exception.OptimisticLockingException;
import ${application.basePackage}.exception.ReferentialIntegrityException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.orm.ObjectOptimisticLockingFailureException;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.any;
import static org.mockito.Mockito.anyLong;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class ${entityName}ServiceTest {
    static final int PAGE_SIZE = 10;
    ${entityName}Service service;
    ${entityName}Repository repository;

    @BeforeEach
    void setUp() {
        repository = mock(${entityName}Repository.class);
        service = new ${entityName}Service(repository);
    }

    @Test
    void findAll() {
        List<${entityName}> entities = FakeDataFactory.nextRandom${entityName}List(PAGE_SIZE);
        when(repository.findAll()).thenReturn(entities);

        Iterable<${entityName}> entitiesFromService = service.findAll();

        int i = 0;
        for (${entityName} entityFromService : entitiesFromService) {
            ${entityName} entity = entities.get(i++);
            assertEquals(entity.getId(), entityFromService.getId());
            assertEquals(entity.get${mainField?cap_first}(), entityFromService.get${mainField?cap_first}());
        }
    }

    @Test
    void findByPage() {
        List<${entityName}> entities = FakeDataFactory.nextRandom${entityName}List(PAGE_SIZE);
        Sort sort = Sort.by(Sort.Direction.ASC, "${mainField}", "id");
        PageRequest pageable = PageRequest.of(0, PAGE_SIZE, sort);
        Page<${entityName}> page = new PageImpl<>(entities, pageable, PAGE_SIZE * 2);
        when(repository.findAll(any(PageRequest.class))).thenReturn(page);

        Page<${entityName}> pageFromService = service.findAll(pageable);

        assertEquals(2, pageFromService.getTotalPages());
        assertEquals(PAGE_SIZE * 2, pageFromService.getTotalElements());
        assertEquals(0, pageFromService.getNumber());
        assertEquals(PAGE_SIZE, pageFromService.getSize());
        assertEquals(PAGE_SIZE, pageFromService.getNumberOfElements());
        for (int i = 0; i < PAGE_SIZE; i++) {
            assertEquals(entities.get(i).getId(), pageFromService.getContent().get(i).getId());
            assertEquals(entities.get(i).get${mainField?cap_first}(), pageFromService.getContent().get(i).get${mainField?cap_first}());
        }
    }

    @Test
    void findById() throws Exception {
        ${entityName} entity = FakeDataFactory.nextRandom${entityName}();
        when(repository.findById(anyLong())).thenReturn(Optional.of(entity));

        ${entityName} entityFromService = service.findById(1L);

        assertEquals(1L, entityFromService.getId());
        assertEquals(entity.get${mainField?cap_first}(), entityFromService.get${mainField?cap_first}());
    }

    @Test
    void findByIdNotFound() {
        when(repository.findById(anyLong())).thenReturn(Optional.empty());

        assertThrows(NotFoundException.class, () -> service.findById(1L));
    }

    @Test
    void save() throws Exception {
        ${entityName} entity = FakeDataFactory.nextRandom${entityName}();
        when(repository.save(any(${entityName}.class))).thenReturn(entity);

        ${entityName} entityFromService = service.save(entity);

        assertEquals(1L, entityFromService.getId());
        assertEquals(entity.get${mainField?cap_first}(), entityFromService.get${mainField?cap_first}());
    }

    @Test
    void saveLocked() {
        ${entityName} entity = FakeDataFactory.nextRandom${entityName}();
        ObjectOptimisticLockingFailureException e =
                new ObjectOptimisticLockingFailureException("Test Spring Optimistic Lock Exception",
                        new Exception("Test Cause"));
        when(repository.save(any(${entityName}.class))).thenThrow(e);

        assertThrows(OptimisticLockingException.class, () -> service.save(entity));
    }

    @Test
    void delete() throws Exception {
        ${entityName} entity = FakeDataFactory.nextRandom${entityName}();

        service.delete(entity);

        verify(repository).delete(any(${entityName}.class));
    }

    @Test
    void deleteLocked() {
        ${entityName} entity = FakeDataFactory.nextRandom${entityName}();
        ObjectOptimisticLockingFailureException e =
                new ObjectOptimisticLockingFailureException("Test Spring Optimistic Lock Exception",
                        new Exception("Test Cause"));
        doThrow(e).when(repository).delete(any(${entityName}.class));

        assertThrows(OptimisticLockingException.class, () -> service.delete(entity));
    }

    @Test
    void deleteNotDeletable() {
        ${entityName} entity = FakeDataFactory.nextRandom${entityName}();
        DataIntegrityViolationException e = new DataIntegrityViolationException("Test Spring Data Integrity Exception");
        doThrow(e).when(repository).delete(any(${entityName}.class));

        assertThrows(ReferentialIntegrityException.class, () -> service.delete(entity));
    }
}