/**
 * @description       : 
 * @author            : HAVARD Julien
 * @group             : 
 * @last modified on  : 06-24-2024
 * @last modified by  : HAVARD Julien
**/
@RestResource(urlMapping='/contact/*')
global class ContactWebService {

    @HttpDelete
    global static void deleteContact() {
        RestRequest request = RestContext.request;
        String contactId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
    
        System.debug('Test contact id ::: ' + contactId);
        List<Contact> contactList = [SELECT Id, FirstName, LastName, Email, Active__c FROM Contact WHERE Id = :contactId];
        if (contactList.isEmpty()) {
            RestContext.response.statusCode = 404;
            RestContext.response.responseBody = Blob.valueOf('{ "error" : "The contact with id ' + contactId + ' not found." }');
        } else {
            Contact contact = contactList[0];
            contact.Active__c = false;
            update contact;


            ContactWrapper contactWrapper = new ContactWrapper(contact);
            RestContext.response.statusCode = 202;
            RestContext.response.responseBody = Blob.valueOf(JSON.serialize(contactWrapper));
        }
    }
    
    global class ContactWrapper {
        global ContactWrapper(Contact contact){
            this.firstName = contact.FirstName;
            this.lastName = contact.LastName;
            this.email = contact?.Email;
            this.id = contact.Id;
            this.active = contact.Active__c;
        }

        global String firstName;
        global String lastName;
        global String email;
        global ID id;
        global Boolean active;
    }
}