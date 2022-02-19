import { LightningElement } from 'lwc';

export default class InputBinding extends LightningElement {
    name
    email
    password
    result = false
    
    handleChange(e) {
        if(e.target.name === 'name') this.name = e.target.value;
        if(e.target.name === 'email') this.email = e.target.value;
        if(e.target.name === 'password') this.password = e.target.value;
    }

    handleClick(e) {
        this.result = !this.result;
    }


}