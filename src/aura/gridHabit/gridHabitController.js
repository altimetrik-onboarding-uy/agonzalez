({
	//Read
	doInit: function(component, event, helper) {		
        helper.read(component, event);
    },

    //Failed
	failed: function(component, event, helper) {		
        helper.updatedStatus(component,event, 'Failed');
    },

     //Completed
	completed: function(component, event, helper) {		
        helper.updatedStatus(component, event, 'Completed');
    },


})