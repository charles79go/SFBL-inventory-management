@isTest
public with sharing class TestDataFactory {

    public static List<Raw_Material__c> rawMaterialsList(Integer num) {
        List<Raw_Material__c> rms = new List<Raw_Material__c>();

        for(Integer i = 0; i < num; i++) {
            String testName = 'test rm' + i;
            Raw_Material__c rm = new Raw_Material__c(Name=testName, Low_Threshold__c=100, Type__c='Colorant');
            rms.add(rm);
        }

        return rms;
    }
}
