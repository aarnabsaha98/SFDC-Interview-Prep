import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import practiceMessageChannel from '@salesforce/messageChannel/PracticeMessageChannel__c';

export default class PublisherComponent extends LightningElement {
    dataToSend = '';
    
    @wire(MessageContext)
    messageContext;

    handleChange(event) {
        this.dataToSend = event.target.value;
    }

    handlePublish() {
        if (!this.dataToSend.trim()) {
            // Show an error message or handle empty data case
            return;
        }

        const message = { message: this.dataToSend };

        publish(this.messageContext, practiceMessageChannel, message)
            .then(result => {
                // Optionally handle successful publish
                console.log('Published message: ', result);
                this.dataToSend = ''; // Clear input after successful publish
            })
            .catch(error => {
                // Handle error in publishing
                console.error('Error publishing message: ', error);
                // Optionally show error message to user
            });
            this.dataToSend  = '';
    }
}