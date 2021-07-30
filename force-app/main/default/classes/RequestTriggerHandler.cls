/* Name: P0 Request Object Trigger Helper
 * Author: Blake Prescott(blake.prescott@revature.net)
 * Created Date: 7/12/21 
 * Last Modified Date: 7/18/21
 * Description: This is the trigger helper for the Request object for my P0, the Fantasy Guild Org.
 */
public class RequestTriggerHandler {
    //If the location text area is empty and all of the address fields are empty, set the address fields to match the account's address. 
    //The actual Location field doesn't have to be an address, since quests often involve going into caves and stuff, so if there is a location the address fields aren't required
    public static void LinkEmptyLocationsToAccountAddress(List<Request__c> reqs){
        
        List<ID> clientIds = new List<ID>();
        for(Request__c r : reqs){
            clientIds.add(r.Client_Account__c);
        }
        List<Account> clientAccs = [SELECT billingStreet, billingCity, billingState, billingCountry, billingPostalCode FROM Account WHERE ID IN : clientIds];
        
        for(Request__c r: reqs){
            
            Account acc;
            for(Account a : clientAccs){
                if(a.id == r.Client_Account__c){
                    acc = a;
                    break;
                }
            }
            
            system.debug(acc.billingStreet);
            system.debug(acc.billingCity);
            system.debug(acc.billingState);
            system.debug(acc.billingCountry);
            system.debug(acc.billingPostalCode);
            
            r.Request_Street__c = acc.billingStreet;
            system.debug(r.Request_Street__c);
            
            r.Request_City__c = acc.billingCity;
            system.debug(r.Request_City__c);
            
            r.Request_State__c = acc.billingState;
            system.debug(r.Request_State__c);
            
            r.Request_Country__c = acc.billingCountry;
            system.debug(r.Request_Country__c);
            
            r.Request_Postal_Code__c = acc.billingPostalCode;
            system.debug(r.Request_Postal_Code__c);
            
            if(r.Location__c == null && r.Request_Street__c != null && r.Request_City__c != null && r.Request_State__c != null && r.Request_Country__c != null && r.Request_Postal_Code__c != null){ 
                r.Location__c = r.Request_Street__c + ', ' + r.Request_City__c + ', ' + r.Request_State__c + ' ' + r.Request_Postal_Code__c + ', ' + r.Request_Country__c;
                system.debug(r.location__c);
            }
        }
    }
    
    public static void SetDefaultDescription(List<Request__c> reqs){
        List<ID> clientIds = new List<ID>();
        for(Request__c r : reqs){
            clientIds.add(r.Client_Account__c);
        }
        List<Account> clientAccs = [SELECT billingStreet, billingCity, billingState, billingCountry, billingPostalCode, phone FROM Account WHERE ID IN : clientIds];
        
        for(Request__c r : reqs){
            Account acc;
            for(Account a : clientAccs){
                if(a.id == r.Client_Account__c){
                    acc = a;
                    break;
                }
            }
            if(r.Request_Details__c == null && acc.phone != null){
                r.Request_Details__c = 'Call ' + acc.phone + ' to speak with the client for further details.';
                system.debug(r.Request_Details__c + 'First if fired');
                
            }else if(r.Request_Details__c == null && acc.phone == null && r.Location__c != null){
                r.Request_Details__c = 'Speak with the client at ' + r.Location__c + ' for more details.';
                system.debug(r.Request_Details__c + 'Second if fired');
                
            }else if(r.Request_Details__c == null && acc.phone == null && r.Location__c == null && r.Request_Street__c == null && r.Request_City__c == null && r.Request_State__c == null && r.Request_Country__c == null && r.Request_Postal_Code__c == null){
                r.addError('Insuffecient contact information for this request\'s details to be left blank! Provide details for this request or update the client account\'s contact information!');
            }
        }
    }
}