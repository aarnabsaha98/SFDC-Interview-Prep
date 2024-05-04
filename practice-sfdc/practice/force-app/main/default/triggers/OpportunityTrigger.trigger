trigger OpportunityTrigger on Opportunity (after insert, after update, after delete){

    OpportunityTrigger_Handler oppTrigger_Handler = new OpportunityTrigger_Handler();
    oppTrigger_Handler.run();
}