@isTest
private class RawMaterialTriggerHandlerTest {

    @isTest static void setProjectedQtyInitialQtyTest(){
        List<Raw_Material__c> rms  = TestDataFactory.rawMaterialsList(5);
        Integer num = 10;
        List<String> rmNames = new List<String>();

        for(Raw_Material__c rm : rms) {
            rm.Actual_Quantity__c = 200 + num;
            num=+num;
            rmNames.add(rm.Name);
        }

        Test.startTest();
        insert rms;
        Test.stopTest();

        List<Raw_Material__c> commitedRms = [   SELECT Name, Actual_Quantity__c, Projected_Quantity__c 
                                                FROM Raw_Material__c
                                                WHERE Name IN :rmNames ];

        for(Raw_Material__c rm : commitedRms){
            System.assert(rm.Actual_Quantity__c == rm.Projected_Quantity__c, 'Actual Quantity should equal Projected Quantity');
        }
    }

    @isTest static void adjustProjectedWhenActualIsUpdatedTestException() {
        Raw_Material__c rm = TestDataFactory.rawMaterialsList(1).get(0);
        String rmName;

        rm.Actual_Quantity__c = 200;
        rmName = rm.Name;
        insert rm;

        rm = [SELECT Name, Actual_Quantity__c, Projected_Quantity__c FROM Raw_Material__c WHERE Name = :rmName];
        rm.Projected_Quantity__c = 50;
        update rm;
        
        rm = [SELECT Name, Actual_Quantity__c, Projected_Quantity__c FROM Raw_Material__c WHERE Name = :rmName];
       	rm.Actual_Quantity__c = 100;
        
        Boolean result = false;

        try {
            Test.startTest();
            update rm;
            Test.stopTest();
        } catch (Exception e) {
            result = true;
        }        
        System.assert(result == true, 'The test should have thrown an error.');
    }

    @isTest static void adjustProjectedWhenActualIsUpdatedTestAddingQty() {
        Raw_Material__c rm = TestDataFactory.rawMaterialsList(1).get(0);
        String rmName;

        rm.Actual_Quantity__c = 200;
        rmName = rm.Name;
        insert rm;

        rm = [SELECT Name, Actual_Quantity__c, Projected_Quantity__c FROM Raw_Material__c WHERE Name = :rmName];
        rm.Projected_Quantity__c = 50;
        update rm;
        
        rm = [SELECT Name, Actual_Quantity__c, Projected_Quantity__c FROM Raw_Material__c WHERE Name = :rmName];
       	rm.Actual_Quantity__c = 240;

        Test.startTest();
        update rm;
        Test.stopTest();

        rm = [SELECT Name, Actual_Quantity__c, Projected_Quantity__c FROM Raw_Material__c WHERE Name = :rmName];

        System.assert(rm.Projected_Quantity__c == 90, 'Projected Qty should be 90');
    }

    @isTest static void adjustProjectedWhenActualIsUpdatedTestDeductingQty() {
        Raw_Material__c rm = TestDataFactory.rawMaterialsList(1).get(0);
        String rmName;

        rm.Actual_Quantity__c = 200;
        rmName = rm.Name;
        insert rm;

        rm = [SELECT Name, Actual_Quantity__c, Projected_Quantity__c FROM Raw_Material__c WHERE Name = :rmName];
        rm.Projected_Quantity__c = 50;
        update rm;
        
        rm = [SELECT Name, Actual_Quantity__c, Projected_Quantity__c FROM Raw_Material__c WHERE Name = :rmName];
       	rm.Actual_Quantity__c = 160;

        Test.startTest();
        update rm;
        Test.stopTest();

        rm = [SELECT Name, Actual_Quantity__c, Projected_Quantity__c FROM Raw_Material__c WHERE Name = :rmName];

        System.assert(rm.Projected_Quantity__c == 10, 'Projected Qty should be 10');
    }
}