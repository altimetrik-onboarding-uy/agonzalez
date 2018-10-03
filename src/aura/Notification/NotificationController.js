({
	//Destroy component Notification
	closeNotify: function (cmp, event, helper) {
		var toggleText = cmp.find("notify");
		$A.util.toggleClass(toggleText, "toggle");
	},
	
	//Read
    doInit: function (cmp, event, helper) {
		var toggleText = cmp.find("notify");
		$A.util.toggleClass(toggleText, "toggle");
	},
	

	ShowNotification : function(cmp, event) {
		var before = event.getParam("before");
		var now = event.getParam("now");

        // set the handler attributes based on event data
		cmp.set("v.before", before);      
		cmp.set("v.now", now); 
		var toggleText = cmp.find("notify");
		$A.util.removeClass(toggleText, "toggle");
	
		
	//	$A.util.toggleClass(toggleText, 'notifi');
        
    }


})