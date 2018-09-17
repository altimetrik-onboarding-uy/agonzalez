({
	handleActive: function (cmp, event, helper) {
        helper.handleActive(cmp, event);
    },

    reloadGrid: function (component, event, helper){
        var paramEvent = event.getParam("idContact");
		component.set('v.idContact', paramEvent);   
    }
})