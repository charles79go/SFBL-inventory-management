public class GetRmData {

    @AuraEnabled(Cacheable=true)
    public static List<Raw_Material__c> getListOfRms(){
        return [SELECT Name, Actual_Quantity__c FROM Raw_Material__c LIMIT 10];
    }
}
