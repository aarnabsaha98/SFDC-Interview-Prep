import { LightningElement, api  } from 'lwc';

export default class ChildCom extends LightningElement {

    @api greetings;

    constructor() {
        super();
        // Access the .heading element after the component has been rendered
        let messageElement = this.template.querySelector('.greetings');
        // let heading = this.template.querySelector('.heading');
        if (messageElement) {
            // Set the text content only if the element exists
            messageElement.textContent = this.greetings;


        }
    }

}