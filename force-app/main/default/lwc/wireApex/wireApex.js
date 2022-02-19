import { LightningElement, wire } from 'lwc';
import getListOfRms from '@salesforce/apex/GetRmData.getListOfRms';

export default class WireApex extends LightningElement {

    rms = []
    withError = false
    withData = false

    @wire(getListOfRms)
    getData({error, data}){
        if(error) {
            this.withError = true;
        } else if(data) {
            this.rms = data;
            this.withData = true;
        }
    }

}