public with sharing class RawMaterialTriggerHandler {

    public static void setProjectedQtyInitialQty(List<Raw_Material__c> rms) {
        for(Raw_Material__c rm : rms) {
            rm.Projected_Quantity__c = rm.Actual_Quantity__c;
        }
    }

    public static void adjustProjectedWhenActualIsUpdated(Map<Id, Raw_Material__c> oldRmsMap, Map<Id, Raw_Material__c> newRmsMap) {
        Set<Id> idKeys = oldRmsMap.keySet();

        for(Id idKey : idKeys) {
            Raw_Material__c oldRm = oldRmsMap.get(idKey);
            Raw_Material__c newRm = newRmsMap.get(idKey);
            
            if(oldRm.Actual_Quantity__c != newRm.Actual_Quantity__c) {
                // calculate the difference of projected and actual qty in the old record.
            	Decimal diff = oldRm.Projected_Quantity__c - oldRm.Actual_Quantity__c;

            	// update the new rm projected qty relative to new actuall qty
            	newRm.Projected_Quantity__c = diff + newRm.Actual_Quantity__c; 
            }
            
            if(newRm.Projected_Quantity__c < 0) {
                String errorMsg = 'Adjusting the Actual Quantity to ' + newRm.Actual_Quantity__c + ' will make the Projected Quantity lower than zero.';
                newRm.addError('Actual_Quantity__c', errorMsg);
            }
        }
    }
}