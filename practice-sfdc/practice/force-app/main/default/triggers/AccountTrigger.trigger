trigger AccountTrigger on Account (before insert, after insert, after update) {

    AccountTrigger_Handler accountTrigger_Handler = new AccountTrigger_Handler();
    accountTrigger_Handler.run();
}