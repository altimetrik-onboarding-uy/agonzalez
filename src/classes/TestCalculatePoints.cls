@isTest
public class TestCalculatePoints {

     static String status = 'New';  
    
      @isTest static void TestAssigmentHabit() {
        String habit = 'Habit';   
        Decimal aux = 0; 
        list<Contact> contactTest = TestDataFactory.createContact(2, 3, habit, false, status); 
       
        Test.startTest();
        TestDataFactory.UpdateStatus(contactTest, habit);
        Test.stopTest();
       
          for(Contact cont : [Select Total_Points__c from Contact where FirstName like '%Contact%']){
              aux = aux + cont.Total_Points__c;
          }
        // after the testing stops, assert records were updated properly
         System.assertEquals(2, aux);
        
    }
    
      @isTest static void TestAssigmentTodoCompleted() {
        String todo = 'TO-DO';    
        Decimal aux = 0; 
        list<Contact> contactTest = TestDataFactory.createContact(2, 3, todo, false, status); 
       
        Test.startTest();
        TestDataFactory.UpdateStatus(contactTest, todo);
        Test.stopTest();
       
          for(Contact cont : [Select Total_Points__c from Contact where FirstName like '%Contact%']){
              aux = aux + cont.Total_Points__c;
          }
        // after the testing stops, assert records were updated properly
         System.assertEquals(4, aux);
    }
     
      @isTest static void TestAssigmentTodoFailed() {
        String todo = 'TO-DO';    
        Decimal aux = 0; 
        list<Contact> contactTest = TestDataFactory.createContact(2, 3, todo, true, status); 
       
        Test.startTest();
        TestDataFactory.UpdateStatus(contactTest, todo);
        Test.stopTest();
       
          for(Contact cont : [Select Total_Points__c from Contact where FirstName like '%Contact%']){
              aux = aux + cont.Total_Points__c;
          }
        // after the testing stops, assert records were updated properly
         System.assertEquals(-4, aux);
        
    }
    
      @isTest static void TestAssigmentDailyCompleted() {
        String todo = 'Daily';
        Decimal aux = 0; 
        list<Contact> contactTest = TestDataFactory.createContact(2, 3, todo, false, status); 
       
        Test.startTest();
        TestDataFactory.UpdateStatus(contactTest, todo);
        Test.stopTest();
       
          for(Contact cont : [Select Total_Points__c from Contact where FirstName like '%Contact%']){
              aux = aux + cont.Total_Points__c;
          }
        // after the testing stops, assert records were updated properly
         System.assertEquals(2, aux);
        
    }
    
      @isTest static void TestAssigmentDailyFailed() {
        String todo = 'Daily';
        Decimal aux = 0; 
        list<Contact> contactTest = TestDataFactory.createContact(2, 3, todo, true, status); 
       
        Test.startTest();
        TestDataFactory.UpdateStatus(contactTest, todo);
        Test.stopTest();
       
          for(Contact cont : [Select Total_Points__c from Contact where FirstName like '%Contact%']){
              aux = aux + cont.Total_Points__c;
          }
        // after the testing stops, assert records were updated properly
         System.assertEquals(-2, aux);        
    }

}