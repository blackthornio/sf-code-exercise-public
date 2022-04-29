/**
 * @description Classes which implement this interface are designed to handle messages coming from PubSubService.
 *              Implementations of this interface will only receive messages emitted on channels they subscribe to.
 *              However, since implementations may subscribe to multiple channels, it is up to the implementation
 *              to route the request correctly.
 */
public interface IHandleMessages {
    /**
     * @description Handles a message on a subscribed channel.
     * @param channel The channel emitting the message.
     * @param data The accompanying data for the message.
     * @throws ArgumentNullException if channel is null.
     */
    void handleMessage(String channel, Object data);

    /**
     * @description Gets a list of channels an implementation subscribes to.
     * @return A List<String> of channel names this implementation is subscribed to.
     */
    List<String> getSubscribedChannels();
}