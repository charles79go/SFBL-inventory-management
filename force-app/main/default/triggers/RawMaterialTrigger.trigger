trigger RawMaterialTrigger on Raw_Material__c (before insert, before update, before delete) {
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            RawMaterialTriggerHandler.setProjectedQtyInitialQty(Trigger.new);
        }
        when BEFORE_UPDATE, BEFORE_DELETE {
            RawMaterialTriggerHandler.adjustProjectedWhenActualIsUpdated(Trigger.oldMap, Trigger.newMap);
        }
    }
}