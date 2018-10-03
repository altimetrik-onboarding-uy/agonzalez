global class StatusScheduler implements Database.Batchable<sObject>, Schedulable{   
    
    // instance member to retain state across transactions
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, Name,Total_Points__c,Email FROM Contact';
        return Database.getQueryLocator(query);

    }
    global void execute(Database.BatchableContext bc, List<Contact> scope){       
     	List<Assignment__c> toUpdate = new List<Assignment__c>();
        List<Contact> toUpdateContact = new List<Contact>();  
        Boolean hasTaskIncompleted = false;
        string body = 'Task(s) not Completed:' + '<br/>';
        String [] sendTo = new String[]{};
        
           for(Contact cont: scope){
           			
            for(Assignment__c task: [SELECT Id, Name,Contact_Name__c, Points__c, Condition__c,Status__c, RecordTypeId, DailyDate__c 
                                   FROM Assignment__c Where Contact_Name__c =: cont.Id ]){
                          
            String type = [SELECT Id, Name,SobjectType FROM RecordType WHERE SobjectType = 'Assignment__c' And Id =: task.RecordTypeId].Name; 
              
            if(type == 'Habit'){
                  //Format the Condition                    
             	task.Condition__c = 'New';
             }
         
            if(type == 'Daily'){
                   //I decrease points               
                if(task.Status__c != 'Completed'){                      
                    hasTaskIncompleted = true;
                    body += 'The task: ' + task.Name + ' no was completed lost ' + task.Points__c + ' points' + '<br/>';
                    cont.Total_Points__c = cont.Total_Points__c - task.Points__c;                      
                     
                }
                   //Format the Status and the date
            		task.Status__c = 'New';
           			task.DailyDate__c = Date.today();   
           		}
            toUpdate.add(task);           
          }
              if(hasTaskIncompleted){                 
                  if (cont.Email != null) {  
                       sendTo.add(cont.Email);  
                        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();          
        			    email.setToAddresses(sendTo);
        			    email.setSubject('Bad News');  
         				email.setHtmlBody(body); 
         				Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
                   } 
                  toUpdateContact.add(cont);
            }
            hasTaskIncompleted = false;
      }
        
           update toUpdateContact;
           update toUpdate; 
    }
        
     global void finish(Database.BatchableContext bc){    
       
    }
    
      global void execute(SchedulableContext sc) {
         StatusScheduler statusUpdate = new StatusScheduler();
         database.executebatch(statusUpdate);
     } 
}