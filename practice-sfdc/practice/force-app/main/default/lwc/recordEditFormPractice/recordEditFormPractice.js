import { LightningElement, api } from 'lwc';

import NAME_FIELD from '@salesforce/schema/Account.Name';
import website from '@salesforce/schema/Account.website';
import AccountNumber from '@salesforce/schema/Account.AccountNumber';
import BillingCountry from '@salesforce/schema/Account.BillingCountry';

export default class RecordEditFormPractice extends LightningElement {
        // Expose a field to make it available in the template
        fields = [NAME_FIELD, website, AccountNumber, BillingCountry];

        // Flexipage provides recordId and objectApiName
        @api recordId;
        @api objectApiName;

        accountId;
        handleSuccess(event) {
            this.accountId = event.detail.id;
        }
        handleReset(event) {
            const inputFields = this.template.querySelectorAll(
                '.lightning-input-field'
            );
            if (inputFields) {
                inputFields.forEach(field => {
                    field.reset();
                });
            }
        }
}