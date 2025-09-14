package ${basePackage}.exception;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import static org.junit.jupiter.api.Assertions.assertEquals;

class ReferentialIntegrityExceptionTest {
    static final Logger LOGGER = LoggerFactory.getLogger(ReferentialIntegrityExceptionTest.class);
    ReferentialIntegrityException exception =
            new ReferentialIntegrityException(LOGGER, "Test Entity", 123, new Exception("Test Exception"));

    @Test
    void getters() {
        assertEquals("Test Entity", exception.getEntityName());
        assertEquals(123, exception.getId());
    }
}