public class TaskController {

    @AuraEnabled
    public static List<Assignment__c> getItems (String typeTask, String status) {
        List<Assignment__c> listHabit = new List<Assignment__c>();
        List<Assignment__c> listDone = new List<Assignment__c>();
        List<Assignment__c> listNotDone = new List<Assignment__c>();
       
       for(Assignment__c task: [SELECT Id, Name, RecordTypeId, Status__c  FROM Assignment__c]){
                String type = [SELECT Id,Name,SobjectType FROM RecordType WHERE SobjectType = 'Assignment__c' And Id =: task.RecordTypeId].Name; 
                             
                //Done 
                if(type == typeTask && task.Status__c == 'Completed' ) {
                    listDone.add(task);
                }
                //NotDone 
                 if(type == typeTask && task.Status__c != 'Completed') {
                    listNotDone.add(task);
                } 
                //All Habit              
                  if(type == typeTask){
                    
                    listHabit.add(task);
                } 
             }

        switch on status {
   		 when 'Completed' {	
       		 return listDone;
                          }	
         when 'NotCompleted' {	
        	 return listNotDone;
                             }   
         when 'All' {	
             listNotDone.addAll(listDone);
        	 return listNotDone ;
                             }  
    	 when else           {
            	  
         	 return listHabit;
                             }
             }			
    }
    


  @AuraEnabled
    public static Assignment__c updateHabit(String id, String status, Boolean habit) {
        Assignment__c item = [SELECT Id, Name, Condition__c,Status__c,Points__c  
         FROM Assignment__c Where Id =: id]; 
        // Perform isUpdatable() checking first, then
        if(habit){
             item.Condition__c = status;
        }else{
            item.Status__c = status;
        }
       
        upsert item;
        return item;
    }

 
}