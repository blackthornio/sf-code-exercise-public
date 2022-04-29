/**
 * @description Test suite helper, to easily assert expectations.
 **/
@isTest
public class TestHelper {
    private static final String NOT_ARGUMENT_NULL_EXCEPTION =
            'Thrown argument is of type {0}, not ArgumentNullException.';
    private static final String NOT_ARGUMENT_EXCEPTION =
            'Thrown argument is of type {0}, not ArgumentException.';
    private static final String EXPECTED_EXCEPTION_NOT_THROWN =
            'The expected exception: {0}, was not thrown.';

    /**
     * @description Assert that the given exception is an ArgumentNullException.
     * @param e The exception to check.
     * @param param The parameter passed into the ArgumentNullException.
     * @throws An ArgumentNullException if e is null.
     */
    public static void assertArgumentNullException(Exception e, String param) {
        ArgumentNullException.throwIfNull(e, 'e');

        if (!(e instanceof ArgumentNullException)) {
            System.assert(false, String.format(NOT_ARGUMENT_NULL_EXCEPTION, new List<String> { e.getTypeName() }));
        }

        String expectedMessage = String.format(ArgumentNullException.NULL_ARGUMENT_ERROR, new List<String> { param });
        if (e.getMessage() != expectedMessage) {
            System.assert(false, 'Expected Message: ' + expectedMessage + ' :: Returned Message: ' + e.getMessage());
        }
    }

    /**
     * @description Assert that the given exception is an ArgumentException.
     * @param e The exception to check.
     * @throws An ArgumentNullException if e is null.
     */
    public static void assertArgumentException(Exception e) {
        ArgumentNullException.throwIfNull(e, 'e');

        if (!(e instanceof ArgumentException)) {
            System.assert(false, String.format(NOT_ARGUMENT_EXCEPTION, new List<String> { e.getTypeName() }));
        }
    }

    /**
     * @description Assert that there was no exception thrown when an
     *              ArgumentNullException was expected.
     */
    public static void expectedArgumentNullException() {
        expectedException(ArgumentNullException.class.getName());
    }

    /**
     * @description Assert that there was no exception thrown when an
     *              ArgumentException was expected.
     */
    public static void expectedArgumentException() {
        expectedException(ArgumentException.class.getName());
    }

    /**
     * @description Assert that there was no exception thrown when one was expected.
     * @exceptionName The name of the exception expected.
     * @throws An ArgumentNullException if exceptionName is null.
     */
    public static void expectedException(String exceptionName) {
        ArgumentNullException.throwIfNull(exceptionName, 'exceptionName');

        System.assert(false, String.format(EXPECTED_EXCEPTION_NOT_THROWN, new List<String> { exceptionName }));
    }
}