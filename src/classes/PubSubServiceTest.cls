@isTest
private class PubSubServiceTest {
    private static final String INCOMING_OBJECT_CHANNEL = 'IncomingObjects';
    private static final String EXPECTED_ASSISTANT_NAME = 'Gordon Freeman';

    private static List<Contact> getContacts() {
        return [SELECT Id, FirstName, LastName, AssistantName FROM Contact];
    }

    private static List<Lead> getLeads() {
        return [SELECT Id, FirstName, LastName FROM Lead];
    }

    @isTest
    private static void handleMessage_withContact_expectInsertedWithAlteredAssistantName() {
        Contact testContact = new Contact(
                FirstName = 'Test',
                LastName = 'Tester',
                AssistantName = 'None');

        Lead testLead = new Lead(
                FirstName = 'TestLead',
                LastName = 'Tester');

        IHandleMessages testHandler = new IncomingContactHandler();
        IHandleMessages testHandler2 = new IncomingLeadWithObjectChannelHandler();

        //Subscribing to multiple IHandleMessages
        PubSubService.Instance.subscribe(testHandler);
        PubSubService.Instance.subscribe(testHandler2);

        List<Contact> contacts = getContacts();
        List<Lead> leads = getLeads();

        System.assert(contacts.isEmpty(), 'Expected no contacts.');
        System.assert(leads.isEmpty(), 'Expected no leads.');

        Test.startTest();
        PubSubService.Instance.emit(INCOMING_OBJECT_CHANNEL, testContact);
        PubSubService.Instance.emit(INCOMING_OBJECT_CHANNEL, testLead);
        Test.stopTest();

        contacts = getContacts();
        leads = getLeads();

        System.assertEquals(1, contacts.size(), 'Expected one contact.');
        System.assertEquals(1, leads.size(), 'Expected one lead.');
        System.assertEquals(testContact.FirstName, contacts[0].FirstName, 'Expected the test contact.');
        System.assertEquals(testLead.FirstName, leads[0].FirstName, 'Expected the test lead.');
        System.assertEquals(EXPECTED_ASSISTANT_NAME, contacts[0].AssistantName,
                'Expected the interface implementation to have altered the assistant name.');
    }

    /**
     * @description A test implementation of IHandleMessages which alters the passed in Contact and inserts it.
     */
    public class IncomingContactHandler implements IHandleMessages {
        /**
         * @description Handles a message on a subscribed channel.
         * @param channel The channel emitting the message.
         * @param data The accompanying data for the message.
         */
        public void handleMessage(String channel, Object data) {
            if (!(data instanceof Contact) || !channel.equalsIgnoreCase(INCOMING_OBJECT_CHANNEL)) {
                return;
            }

            Contact contactToInsert = (Contact)data;
            contactToInsert.AssistantName = EXPECTED_ASSISTANT_NAME;

            Database.insert(contactToInsert);
        }

        /**
         * @description Gets a list of channels an implementation subscribes to.
         * @return A List<String> of channel names this implementation is subscribed to.
         */
        public List<String> getSubscribedChannels() {
            return new List<String> {
                    INCOMING_OBJECT_CHANNEL
            };
        }
    }

    /**
     * @description A test implementation of IHandleMessages which alters the passed in Lead and inserts it.
     */
    public class IncomingLeadWithObjectChannelHandler implements IHandleMessages {
        /**
         * @description Handles a message on a subscribed channel.
         * @param channel The channel emitting the message.
         * @param data The accompanying data for the message.
         */
        public void handleMessage(String channel, Object data) {
            if (!(data instanceof Lead) || !channel.equalsIgnoreCase(INCOMING_OBJECT_CHANNEL)) {
                return;
            }

            Lead leadToInsert = (Lead)data;
            leadToInsert.FirstName = EXPECTED_ASSISTANT_NAME;

            Database.insert(leadToInsert);
        }

        /**
         * @description Gets a list of channels an implementation subscribes to.
         * @return A List<String> of channel names this implementation is subscribed to.
         */
        public List<String> getSubscribedChannels() {
            return new List<String> {
                    INCOMING_OBJECT_CHANNEL
            };
        }
    }
}