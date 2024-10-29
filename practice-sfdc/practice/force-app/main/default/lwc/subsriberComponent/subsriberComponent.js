import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import practiceMessageChannel from '@salesforce/messageChannel/PracticeMessageChannel__c';

export default class SubscriberComponent extends LightningElement {
    receivedMessage = '';

    subscription = null;

    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        console.log('called connected call back');
        this.subscribeToMessageChannel();
    }

/*
The disconnectedCallback is a lifecycle hook provided by the Lightning Web Component framework. 
It is automatically invoked when a component is removed from the DOM, 
which can happen for various reasons such as navigating away from a page, hiding a modal dialog, or removing a component dynamically from the UI.*/
    disconnectedCallback() {
        // Unsubscribe from message channel when component is disconnected
        console.log('called dis-connected call back');

        if (this.subscription) {
            this.subscription.unsubscribe();
            this.subscription = null;
        }
    }

    subscribeToMessageChannel() {
        console.log('Subscribed...');
        this.subscription = subscribe(
            this.messageContext,
            practiceMessageChannel,
            (message) => {
                this.handleMessage(message);
            },
           
        );
    }

    handleMessage(message) {
        this.receivedMessage = message.message;
    }
}