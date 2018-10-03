({
     //In Progress
     doInit: function (component, event, helper) {
        helper.read(component, event);
    },
   
    //In Progress
    failed: function (component, event, helper) {
        helper.updatedStatus(component, event, 'In Progress');
    },

    //Completed
    completed: function (component, event, helper) {
        helper.updatedStatus(component, event, 'Completed');
    },

    //Failed
    failedHabit: function (component, event, helper) {
        helper.updatedStatus(component, event, 'Failed');
    },

    reloadGrid: function (component, event, helper){
        var paramEvent = event.getParam("idContact");
		component.set('v.idContact', paramEvent);   	  
        helper.read(component, event);
    }

})