/* Name: P0 Guild Member Object Trigger Handler
 * Author: Blake Prescott(blake.prescott@revature.net)
 * Created Date: 7/16/21 
 * Last Modified Date: 7/18/21
 * Description: This is the handler for the Guild Member trigger.
 */
public class GuildMemberTriggerHandler {
    public static void maxMinMemberLevels(List<Guild_Member__c> gm){
        for (Guild_Member__c g : gm) {           
            If(g.RecordTypeId == '0125e0000006hYm') {
                Integer minLevels = g.class__c.countMatches(';')+1;
                system.debug(minLevels);
                system.debug(g.class__c);
                If(g.Levels__c < minLevels || g.Levels__c > 20){
                    g.addError('An adventurer cannot have fewer levels than classes and cannot have more than 20 levels.');
                }
            }    
        }
    }
}