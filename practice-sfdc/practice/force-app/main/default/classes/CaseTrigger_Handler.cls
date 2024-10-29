public with sharing class CaseTrigger_Handler extends TriggerHandler{
    
    public override void afterInsert(){
        Utility_CaseHanlder.linkCaseWithContact(Trigger.new, null);
        Utility_CaseHanlder.createTaskWithPrimaryContactOfAccount(Trigger.new, null);
    }
    public override void afterUpdate(){
        Utility_CaseHanlder.linkCaseWithContact(Trigger.new, Trigger.oldMap);
        Utility_CaseHanlder.createTaskWithPrimaryContactOfAccount(Trigger.new, Trigger.oldMap);
    }
    public override void afterDelete(){
        Utility_CaseHanlder.linkCaseWithContact(Trigger.old, null);
        Utility_CaseHanlder.sendEmailToAccountOwner(Trigger.old);
    }

}