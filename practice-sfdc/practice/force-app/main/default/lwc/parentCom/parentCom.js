import { LightningElement, api } from 'lwc';

export default class ParentCom extends LightningElement {
    // Define a property to hold the greetings text
        greetings = 'Hi';

    // Handle button click to update greetings
    handleClick() {
        this.greetings = 'Hello! Welcome to Salesforce learning';
        console.log('clicked: ' + this.greetings);
    }
}
