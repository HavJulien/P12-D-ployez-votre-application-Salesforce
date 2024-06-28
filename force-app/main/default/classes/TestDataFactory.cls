/**
 * @description       : 
 * @author            : HAVARD Julien
 * @group             : 
 * @last modified on  : 06-24-2024
 * @last modified by  : HAVARD Julien
**/
@IsTest
public with sharing class TestDataFactory {
    public static Contact createContact(String firstName, String lastName, Boolean isInserted){
        Contact contact = new Contact(
            FirstName = firstName,
            LastName = lastName,
            Email = firstName + '.' + lastName + '@test.test'
        );
        if (isInserted){
            insert contact;
        }
        return contact;
    }
}