({
	handleActive: function (component, event) {
		var tab = event.getSource();
		switch (tab.get('v.id')) {
			case 'Completed':
				this.injectComponent(component, tab, true);
				break;
			case 'NotCompleted':
				this.injectComponent(component, tab, false);
				break;
			case 'All':
				this.injectComponent(component, tab);
				break;

		}
	},
	injectComponent: function (component, target, val) {

		$A.createComponent(
			"c:Grid", {
				"buttonHabit": component.get('v.habit'),
				"status": target.get('v.id'),
				"typeTask": component.get('v.typeTask'),
				"buttonCompleted": val

				
			}, function (contentComponent, status, error) {
				if (status === "SUCCESS") {					
				   target.set('v.body', contentComponent);
				} else {
					throw new Error(error);
				}
			});
	}
})