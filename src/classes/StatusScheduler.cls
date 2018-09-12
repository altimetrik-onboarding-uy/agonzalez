global class StatusScheduler implements  Schedulable {
List<Assignment__c> toUpdate = new List<Assignment__c>();
List<Contact> toUpdateContact = new List<Contact>();
    global void  execute(SchedulableContext sc){
       
        for(Assignment__c task: [SELECT Id, Name,Contact_Name__c, Points__c, Condition__c,Status__c, RecordTypeId 
                                 FROM Assignment__c]){
             String type = [SELECT Id,Name,SobjectType FROM RecordType WHERE SobjectType = 'Assignment__c' And Id =: task.RecordTypeId].Name; 
              
            if(type == 'Habit'){
             task.Condition__c = 'New';
             }
           
            if(type == 'Daily'){
                if(task.Status__c != 'Completed'){
                    Contact contObject =  [Select Id,Name,Total_Points__c from Contact WHERE Id =: task.Contact_Name__c Limit 1];
                    contObject.Total_Points__c = contObject.Total_Points__c - task.Points__c; 
                    toUpdateContact.add(contObject);
                }
            task.Status__c = 'New';
        }
            toUpdate.add(task);
        }
        update toUpdateContact;
        update toUpdate;       
    }       

}