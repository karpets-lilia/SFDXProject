public class ResourceController {
    
    public String selectedType {set; get; }
    public List<Resource__c> resources {set; get; }
    public boolean isClicked {set; get; }
    
    public ResourceController() {
       getResourcePickValues();
       isClicked = true;
    }
    
    public List<SelectOption> getResourcePickValues() {
        List<SelectOption> options = new List<SelectOption>();
        
        Schema.DescribeFieldResult fieldResult = Resource__c.Type__c.getDescribe();
        List<Schema.PicklistEntry> pickListValues = fieldResult.getPicklistValues();
        options.add(new SelectOption('','--None--'));
        
        for (Schema.PicklistEntry value : pickListValues) {
            options.add(new SelectOption(value.getLabel(), value.getValue()));
        }
        
        return options;         
    }
    
    public void searchResourceRecords(){
        isClicked = true;
        
        resources = [
            SELECT Name, Model__c, Inventory_Number__c, Estimate_Cost__c, Contact__c, Type__c
            FROM Resource__c 
            WHERE Type__c =: selectedType
        ];

    }
}