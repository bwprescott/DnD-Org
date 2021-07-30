/* Name: P0 Request Object Trigger Helper Tests
 * Author: Blake Prescott(blake.prescott@revature.net)
 * Created Date: 7/16/21 
 * Last Modified Date: 7/18/21
 * Description: This is the test class for the request trigger.
 */
@isTest
public class RequestTriggerTest {
	
    @testSetup
    static void setup() {
        Account acc = new Account(Name = 'Bob', billingStreet = 'test street', billingCity = 'test city', billingState = 'test state', billingCountry = 'test country', billingPostalCode = '20740', phone = '8675309');
    	insert acc;                
    }
    
    @isTest
    public static void singleLocationTest(){
        Account acc = [SELECT ID, billingStreet, billingCity, billingState, billingPostalCode, billingCountry 
                       From Account 
                       LIMIT 1];
    	
        
        Request__c req = new Request__c(client_account__c = acc.Id, reward__c = 1);
        insert req;
        Request__c r = [SELECT Location__c FROM Request__c WHERE ID =: req.Id limit 1];
        
        System.assertEquals('test street, test city, test state 20740, test country', r.Location__c);
        
        r.Location__c = '';
        update r;
        Request__c r2 = [SELECT Location__c FROM Request__c WHERE ID =: req.Id limit 1];
        
        System.assertEquals('test street, test city, test state 20740, test country', r2.Location__c);
    }
    
    @isTest
    public static void multiLocationTest(){
        Account acc = [SELECT ID, billingStreet, billingCity, billingState, billingPostalCode, billingCountry 
                       From Account 
                       LIMIT 1];        
        List<Request__c> reqList = new List<Request__c>();
        For(integer i = 0; i<100; i++){
            Request__c req = new Request__c(name = 'testRequest' + i, client_account__c = acc.Id, reward__c = 5);
            reqList.add(req);
        }
        insert reqList;
        
        List<Request__c> reqsWithLocations = [SELECT Location__c 
                                              FROM Request__c 
                                              WHERE Location__c LIKE 'test street, test city, test state 20740, test country'];
    	System.assertEquals(100, reqsWithLocations.size());
    }
    
    @isTest
    public static void locationNotNullTest(){
        Account acc = [SELECT ID, billingStreet, billingCity, billingState, billingPostalCode, billingCountry 
                       From Account 
                       LIMIT 1];
        
        Request__c req = new Request__c(client_account__c = acc.Id, reward__c = 1, location__c = 'test location');
        insert req;
        Request__c r = [SELECT Location__c FROM Request__c WHERE ID =: req.Id limit 1];
        
        System.assertEquals('test location', r.Location__c);
    }
    
    @isTest
    public static void detailNotNullTest(){
        Account acc = [SELECT ID, billingStreet, billingCity, billingState, billingPostalCode, billingCountry, phone 
                       From Account 
                       LIMIT 1];
        Request__c r = new Request__c(client_account__c = acc.Id, reward__c = 1, location__c = 'testLocation', request_details__c = 'testDetails');
        insert r;
        
        Request__c req = [SELECT request_details__c FROM Request__c LIMIT 1];
        system.assertEquals('testDetails', req.Request_Details__c);
    }
    
    @isTest
    public static void phoneNotNullTest(){
        Account acc = [SELECT ID, billingStreet, billingCity, billingState, billingPostalCode, billingCountry, phone 
                       From Account 
                       LIMIT 1];
        Request__c r = new Request__c(client_account__c = acc.Id, reward__c = 1);
        insert r;
        
        Request__c req = [SELECT request_details__c FROM Request__c LIMIT 1];
        system.assertEquals('Call 8675309 to speak with the client for further details.', req.Request_Details__c);
    }
    
    @isTest
    public static void locationNotNullDetailTest(){
        Account acc = new Account(Name = 'Bob', billingStreet = 'test street', billingCity = 'test city', billingState = 'test state', billingCountry = 'test country');
        insert acc;
        
        Request__c r = new Request__c(client_account__c = acc.Id, reward__c = 1, location__c = 'testLocation');
        insert r;
        
        Request__c req = [SELECT request_details__c FROM Request__c LIMIT 1];
        system.assertEquals('Speak with the client at testLocation for more details.', req.Request_Details__c);
    }
    
    @isTest
    public static void everythingNullTest(){
        Account acc = new Account(Name = 'Bob');
        insert acc;
        
        Request__c r = new Request__c(client_account__c = acc.Id, reward__c = 1);
        database.SaveResult sr = database.insert(r, false);
        integer numFailed = 0;
        if(!sr.isSuccess()){
            numFailed = 1;
        }
        
        system.assertEquals(1, numFailed);
    }
}