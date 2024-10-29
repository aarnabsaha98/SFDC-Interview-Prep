import { LightningElement } from 'lwc';
import { createRecord } from "lightning/uiRecordApi";

import ACCOUNT from "@salesforce/schema/Account";
import NAME_FIELD from "@salesforce/schema/Account.Name";
import Website_FIELD from "@salesforce/schema/Account.Website";
import Email_FIELD from "@salesforce/schema/Account.Email__c";

export default class WirePracticePart1 extends LightningElement { name = '';
    email = '';
    website = '';
    accountId ;

    handleChangeName(event){
        this.name = event.target.value;
        this.label = event.target.label;   
    }

    handleChangeEmail(event){
        this.email = event.target.value;
        this.label = event.target.label;   
    }

    handleChangeWebsite(event){
        this.website = event.target.value;
        this.label = event.target.label;   
    }

    async createAccount(){
        const fields = {}
        fields[NAME_FIELD.fieldApiName] = this.name;
        fields[Website_FIELD.fieldApiName] = this.email;
        fields[Email_FIELD.fieldApiName] = this.website;

        const recordInput = { apiName: ACCOUNT.objectApiName, fields };
        try {
            const account = await createRecord(recordInput);
            console.log('account :' + account);
            this.accountId = account.id;
            console.log('account :' + this.accountId);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Account created',
                    variant: 'success'
                })
            );
        } catch (error) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: reduceErrors(error).join(', '),
                    variant: 'error'
                })
            );
        }
    }

}