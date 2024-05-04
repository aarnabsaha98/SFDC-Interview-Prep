trigger CaseTrigger on Case (after insert, after update, after delete) {

    CaseTrigger_Handler caseTrigger_Handler = new CaseTrigger_Handler();
    caseTrigger_Handler.run();
}