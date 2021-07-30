/* Name: P0 Guild Member Object Trigger
 * Author: Blake Prescott(blake.prescott@revature.net)
 * Created Date: 7/18/21 
 * Last Modified Date: 7/18/21
 * Description: This is the trigger for the Guild Member object.
 */
trigger GuildMemberTrigger on Guild_Member__c (before insert, before update ,before delete ,after insert, after update, after delete, after undelete) {
    switch on trigger.operationType {
        when BEFORE_INSERT{
            GuildMemberTriggerHandler.maxMinMemberLevels(trigger.new);
        }
        when BEFORE_UPDATE{
            GuildMemberTriggerHandler.maxMinMemberLevels(trigger.new);
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