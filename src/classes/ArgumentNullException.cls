/**
 * @description An exception type to be used when a passed
 *              argument is unexpectedly null.
 **/
public class ArgumentNullException extends Exception {
    @TestVisible private static final String NULL_ARGUMENT_ERROR = 'Unexpected null argument: {0}.';

    /**
     * @description Throw an ArgumentNullException if the given parameter is null.
     * @param param The argument to null check.
     * @param argument The name of the argument that is being null checked.
     */
    public static void throwIfNull(Object param, String argument) {
        if (param == null) {
            throw new ArgumentNullException(String.format(NULL_ARGUMENT_ERROR, new List<String> { argument }));
        }
    }
}