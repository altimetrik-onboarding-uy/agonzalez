@isTest
public class TestStatusScheduler {
    
       static String status = 'New';
       public static String CRON_EXP = '0 0 0 15 3 ? 2022';
       static testmethod void testScheduledJobHabit() {      
       Integer siize = TestDataFactory.createContact(3, 2 , 'Habit', false, status).size();
          
       Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('Update Contact and Assignment__c', CRON_EXP, new StatusScheduler()); 
        Test.stopTest();
        
         System.assertEquals(6, [Select count() from Assignment__c where Condition__c = 'New']);
    }
    
       static testmethod void testScheduledJobDaily() {       
       Decimal result = 0;    
       TestDataFactory.createContact(3, 5 , 'Daily', false, status);
      
       Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('Update Contact and Assignment__c', CRON_EXP, new StatusScheduler()); 
        Test.stopTest();
        	for (Contact cont : [Select Total_Points__c from Contact]){
                system.debug(cont.Total_Points__c);
  			 			result = result + cont.Total_Points__c;		
			}
         System.assertEquals(-15, result);
    }

}