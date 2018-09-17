@isTest
public class TestDataFactory {


   public static Contact createAssigment(Integer paramFirst, String types, Boolean fecha, String status) {
         Contact contacTest = new Contact(FirstName='Contact', LastName = 'Test',Total_Points__c = 0,Email = 'arodriguez@altimetrik.com');   
         insert contacTest;
         List<Assignment__c> taskList = new List<Assignment__c>();
       
         for(Integer i = 0; i < paramFirst  ; i++) {
             String record = Schema.SObjectType.Assignment__c.getRecordTypeInfosByName().get(types).getRecordTypeId();
             Date nowDate = Date.today();
             if(fecha){
                 nowDate = Date.today().addDays(-5);
             }          	
             
             Assignment__c task = new Assignment__c(Name= 'Test ' + String.valueOf(i),
                              Difficulty__c= 'Easy',  
                              RecordTypeId= record,
                              Contact_Name__c = contacTest.Id,
                              Status__c= status, 
                              EndDate__c = nowDate                     
                             );
             
           if(types == 'Habit'){
               task.Condition__c= status;
              }
             
             if(types == 'Daily'){
               task.DailyDate__c= nowDate;
              }
            
         try {
           insert task;
        } catch(Exception ex) {
             System.Debug(ex);
        }
           
        }   
       
        return contacTest;
    }
  

   public static void UpdateStatus(Contact cont, String types){
       List<Assignment__c> toUpdate = new List<Assignment__c>(); 
          
       for (Assignment__c a : [select Condition__c from Assignment__c where Contact_Name__c =: cont.Id ]) {	
            
           if(types == 'Habit'){
           a.Condition__c = 'Completed';
           toUpdate.add(a);
           } else{
           a.Status__c = 'Completed';
           toUpdate.add(a);  
           }          
       }
        update toUpdate;    
    }
    
   
   public static List<Contact> createContact(Integer numAccts, Integer paramFirst, String types, Boolean fecha, String status) {
        List<Contact> accts = new List<Contact>();
        
        for(Integer i=0;i<numAccts;i++) {
            Contact a =  new Contact(FirstName='Contact' + String.valueOf(i) , LastName = 'Test' + String.valueOf(i),Total_Points__c = 0, Email = 'arodriguez@altimetrik.com'); 
            accts.add(a);
        }
        insert accts ;
         
        List<Assignment__c> opps = new List<Assignment__c>();
            for (Integer j=0;j < numAccts ; j++) {
             Contact acct = accts[j];
            // For each account just inserted, add opportunities
            for (Integer i=0; i < paramFirst; i++) {
             String record = Schema.SObjectType.Assignment__c.getRecordTypeInfosByName().get(types).getRecordTypeId();
             Date nowDate = Date.today();
             if(fecha){
                 nowDate = Date.today().addDays(-5);
             }          	
            
             Assignment__c task = new Assignment__c(Name= 'Test ' + String.valueOf(i),
                              Difficulty__c= 'Easy',  
                              RecordTypeId= record,
                              Contact_Name__c = acct.Id,
                              Status__c= status, 
                              EndDate__c = nowDate                     
                             );
             
           if(types == 'Habit'){
               task.Condition__c= status;
              }
             
             if(types == 'Daily'){
               task.DailyDate__c= nowDate;
              }  
			opps.add(task);            
        }  
     }             
          try {
           insert opps;
        } catch(Exception ex) {
             System.Debug(ex);
        }
       
        
        return accts;
    }

}