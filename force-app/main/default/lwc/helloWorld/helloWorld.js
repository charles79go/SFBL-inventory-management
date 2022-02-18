import { LightningElement } from 'lwc';

export default class HelloWorld extends LightningElement {

    result = false
    buttonText = 'Show Message'

    handleClick(e){
        this.result = !this.result;

        buttonText = this.result ? 'Hide Message' : 'Show Message';
    }


}