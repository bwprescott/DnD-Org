/* Name: P0 Request Object Trigger
 * Author: Blake Prescott(blake.prescott@revature.net)
 * Created Date: 7/12/21 
 * Last Modified Date: 7/13/21
 * Description: This is the trigger for the Request object for my P0, the Fantasy Guild Org.
 */
trigger RequestTrigger on Request__c (before insert, before update ,before delete ,after insert, after update, after delete, after undelete) {
    switch on trigger.operationType {
        when BEFORE_INSERT{
            RequestTriggerHandler.LinkEmptyLocationsToAccountAddress(Trigger.new);
            RequestTriggerHandler.SetDefaultDescription(Trigger.new);
        }
        when BEFORE_UPDATE{
            RequestTriggerHandler.LinkEmptyLocationsToAccountAddress(Trigger.new);
            RequestTriggerHandler.SetDefaultDescription(Trigger.new);
        }
        when BEFORE_DELETE{
            
        }
        when AFTER_INSERT{
            
        }
        when AFTER_UPDATE{
            
        }
        when AFTER_DELETE{
            
        }
        when AFTER_UNDELETE{
            
        }
    }
}