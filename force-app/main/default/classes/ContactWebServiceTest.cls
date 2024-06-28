/**
 * @description       : 
 * @author            : HAVARD Julien
 * @group             : 
 * @last modified on  : 06-24-2024
 * @last modified by  : HAVARD Julien
**/
@isTest
private class ContactWebServiceTest {
    @isTest
    static void testDeleteContact() {
        Contact testContact = TestDataFactory.createContact('Test', 'Contact', false);
        testContact.Active__c = true;
        insert testContact;

        Test.startTest();
        RestRequest request = new RestRequest();
        request.requestURI = '/contact/' + testContact.Id;
        request.httpMethod = 'DELETE';
        RestContext.request = request;
        RestContext.response = new RestResponse();
        ContactWebService.deleteContact();
        Test.stopTest();

        Contact deletedContact = [SELECT Id, Active__c FROM Contact WHERE Id = :testContact.Id];
        Assert.areEqual(202, RestContext.response.statusCode, 'We should have received an HTTP OK');
        Assert.areNotEqual(testContact.Active__c, deletedContact.Active__c, 'The contact should have been deactivated');
    }

    @isTest
    static void testDeleteContactNotFound() {
        Test.startTest();
        RestRequest request = new RestRequest();
        request.requestURI = '/contact/123';
        request.httpMethod = 'DELETE';
        RestContext.request = request;
        RestContext.response = new RestResponse();
        ContactWebService.deleteContact();
        Test.stopTest();

        Assert.areEqual(404, RestContext.response.statusCode, 'We should have received an HTTP error');
    }
}