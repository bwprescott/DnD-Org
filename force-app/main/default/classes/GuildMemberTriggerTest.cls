/* Name: P0 Guild Member Object Trigger Handler Tests
 * Author: Blake Prescott(blake.prescott@revature.net)
 * Created Date: 7/16/21 
 * Last Modified Date: 7/18/21
 * Description: This is the test class for the guild member trigger. I did tests for success and failure but bulk tests in this particular case don't
 * make a lot of sense to me since nothing in the triggers interacts with anything outside of the record.
 */
@isTest
public class GuildMemberTriggerTest {
	
    @isTest
    public static void singleMinFailTest(){
        Guild_Member__c testGM = new Guild_Member__c(name = 'testName', RecordTypeId = '0125e0000006hYm', Member_Type__c = 'Adventurer', Class__c = 'Bard;Sorcerer', levels__c = 1);
        database.SaveResult sr = database.insert(testGM, false);
        integer numFailed = 0;
        if(!sr.isSuccess()){
            numFailed = 1;
        }        
        system.assertEquals(1, numFailed);
    }
    
    @isTest
    public static void singleMinSuccessTest(){
        Guild_Member__c testGM = new Guild_Member__c(name = 'testName', RecordTypeId = '0125e0000006hYm', Member_Type__c = 'Adventurer', Class__c = 'Bard;Sorcerer', levels__c = 2);
        database.SaveResult sr = database.insert(testGM, false);
        integer numFailed = 0;
        if(!sr.isSuccess()){
            numFailed = 1;
        }
		        
        system.assertEquals(0, numFailed);
    }
    
    @isTest
    public static void singleMaxFailTest(){
        Guild_Member__c testGM = new Guild_Member__c(name = 'testName', RecordTypeId = '0125e0000006hYm', Member_Type__c = 'Adventurer', Class__c = 'Bard;Sorcerer', levels__c = 21);
        database.SaveResult sr = database.insert(testGM, false);
        integer numFailed = 0;
        if(!sr.isSuccess()){
            numFailed = 1;
        }        
        system.assertEquals(1, numFailed);
    }
    
    @isTest
    public static void singleMaxSuccessTest(){
        Guild_Member__c testGM = new Guild_Member__c(name = 'testName', RecordTypeId = '0125e0000006hYm', Member_Type__c = 'Adventurer', Class__c = 'Bard;Sorcerer', levels__c = 20);
        database.SaveResult sr = database.insert(testGM, false);
        integer numFailed = 0;
        if(!sr.isSuccess()){
            numFailed = 1;
        }        
        system.assertEquals(0, numFailed);
    }
    
    @isTest
    public static void singleMinUpdateFailTest(){
        Guild_Member__c testGM = new Guild_Member__c(name = 'testName', RecordTypeId = '0125e0000006hYm', Member_Type__c = 'Adventurer', Class__c = 'Bard;Sorcerer', levels__c = 2);
        insert testGM;
        Guild_Member__c gm = [SELECT levels__c, class__c FROM Guild_Member__c LIMIT 1];
        gm.Levels__c = 1;
        database.SaveResult sr = database.update(gm, false);
        integer numFailed = 0;
        if(!sr.isSuccess()){
            numFailed = 1;
        } 
        system.assertEquals(1, numFailed);
    }
    
    @isTest
    public static void singleMinUpdateSuccessTest(){
        Guild_Member__c testGM = new Guild_Member__c(name = 'testName', RecordTypeId = '0125e0000006hYm', Member_Type__c = 'Adventurer', Class__c = 'Bard;Sorcerer', levels__c = 2);
        insert testGM;
        Guild_Member__c gm = [SELECT levels__c, class__c FROM Guild_Member__c LIMIT 1];
        gm.Levels__c = 3;
        database.SaveResult sr = database.update(gm, false);
        integer numFailed = 0;
        if(!sr.isSuccess()){
            numFailed = 1;
        } 
        system.assertEquals(0, numFailed);
    }
    
    @isTest
    public static void ignoreExpertsTest(){
        Guild_Member__c testGM = new Guild_Member__c(name = 'testName', RecordTypeId = '0125e0000006hYr', Member_Type__c = 'Expert');
        database.SaveResult sr = database.insert(testGM, false);
        integer numFailed = 0;
        if(!sr.isSuccess()){
            numFailed = 1;
        } 
        system.assertEquals(0, numFailed);
    }
}