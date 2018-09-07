trigger CalculatePoints on Assignment__c (after update) {
     
    for (Assignment__c a :Trigger.new) {	
            
     String idRecodType = a.RecordTypeId;   
     Contact contObject =  [Select Id,Name,Total_Points__c from Contact WHERE Id =: a.Contact_Name__c Limit 1];
   
    switch on idRecodType {
   		 when '0120b000000ZIcBAAW' {		
       		//TO-DO     
       
       		 if(a.Status__c  == 'Completed' && a.LastModifiedDate < a.EndDate__c){         
       		   contObject.Total_Points__c = contObject.Total_Points__c + a.Points__c;            
       		 } 
        
        	if(a.Status__c  == 'Completed' && a.LastModifiedDate > a.EndDate__c){              
       		  contObject.Total_Points__c = contObject.Total_Points__c - a.Points__c;          
       		 }         
   
    }	
    	when '0120b000000ZIcGAAW' {		 
        	 //Daily
        	 
        	 if(a.Status__c  == 'Completed' && a.LastModifiedDate.day() >= a.CreatedDate.addDays(1).day()){
                 System.debug('no igual');
                 contObject.Total_Points__c = contObject.Total_Points__c - a.Points__c; 
      	 	 } 
        
       		 if(a.Status__c  == 'Completed' && a.LastModifiedDate.day() < a.CreatedDate.addDays(1).day()){ 
                  System.debug(' igual');
        	         contObject.Total_Points__c = contObject.Total_Points__c + a.Points__c;
       		 }         
       
    }    
    	when else {		  
         	//Habit         	     
			    contObject.Total_Points__c = contObject.Total_Points__c + a.Points__c;
      }
    }
         upsert contObject;   
  }

}