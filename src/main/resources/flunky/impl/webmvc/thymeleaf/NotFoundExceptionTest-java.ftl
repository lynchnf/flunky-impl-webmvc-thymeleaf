package ${basePackage}.exception;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import static org.junit.jupiter.api.Assertions.assertEquals;

class NotFoundExceptionTest {
    static final Logger LOGGER = LoggerFactory.getLogger(NotFoundExceptionTest.class);
    NotFoundException exception = new NotFoundException(LOGGER, "Test Entity", 123);

    @Test
    void getters() {
        assertEquals("Test Entity", exception.getEntityName());
        assertEquals(123, exception.getId());
    }
}