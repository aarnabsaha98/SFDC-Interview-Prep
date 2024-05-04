public with sharing class OpportunityTrigger_Handler extends TriggerHandler {


    

    public override void afterInsert(){
        Utility_OpportunityHanlder.updateAccountDescription(trigger.new, null);

    }

     public override void afterUpdate(){
         Utility_OpportunityHanlder.updateAccountDescription(trigger.new , trigger.oldmap);

    }

    public override void afterDelete(){
        Utility_OpportunityHanlder.updateAccountDescription(trigger.old, null);

    }
}