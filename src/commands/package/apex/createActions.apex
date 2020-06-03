EmailTemplate validEmailTemplate = [Select id,Name from EmailTemplate where Name= 'TestTemplate__00110011' limit 1];
List <RDNACadence__Action__c> listOfAction = new List<RDNACadence__Action__c>();
for(integer i=1;i<=7;i++){
    RDNACadence__Action__c act = new RDNACadence__Action__c();
    if(i==1){
        act.Name = 'Email SFDC Automatic Action';
        act.RDNACadence__Type__c = 'Email';
        act.RDNACadence__Activation_Type__c = 'Automatic' ;
        act.RDNACadence__Delivery_Preference__c = 'Immediate';
        act.RDNACadence__Template_Id__c = validEmailTemplate.Id;
		act.RDNACadence__Template_Name__c = validEmailTemplate.Name;
		act.RDNACadence__Email_Type__c = 'SFDC' ;
    }
    if(i==2){
        act.Name = 'Email SFDC Manual Action';
        act.RDNACadence__Type__c = 'Email';
        act.RDNACadence__Activation_Type__c = 'Manual';
        act.RDNACadence__Delivery_Preference__c = 'Immediate';
        act.RDNACadence__Template_Id__c = validEmailTemplate.Id;
		act.RDNACadence__Template_Name__c = validEmailTemplate.Name;
		act.RDNACadence__Email_Type__c = 'SFDC';
    }
    if(i==3){
        act.Name = 'Email Native Automatic Action';
        act.RDNACadence__Type__c = 'Email';
        act.RDNACadence__Activation_Type__c = 'Automatic';
        act.RDNACadence__Delivery_Preference__c = 'Immediate';
        act.RDNACadence__Template_Id__c = validEmailTemplate.Id;
		act.RDNACadence__Template_Name__c = validEmailTemplate.Name;
		act.RDNACadence__Email_Type__c = 'NATIVE';
    }if(i==4){
        act.Name = 'Email Native Manual Action';
        act.RDNACadence__Type__c = 'Email';
        act.RDNACadence__Activation_Type__c = 'Manual';
        act.RDNACadence__Delivery_Preference__c = 'Immediate';
        act.RDNACadence__Template_Id__c = validEmailTemplate.Id;
		act.RDNACadence__Template_Name__c = validEmailTemplate.Name;
		act.RDNACadence__Email_Type__c = 'NATIVE';
    }
    if(i==5){
        act.Name = 'SMS Action';
        act.RDNACadence__Type__c = 'SMS';
        act.RDNACadence__Activation_Type__c = 'Manual';
        act.RDNACadence__Delivery_Preference__c = 'Immediate';

    }
    if(i==6){
        act.Name = 'Task Action';
        act.RDNACadence__Type__c = 'Task';
        act.RDNACadence__Activation_Type__c = 'Manual';
        act.RDNACadence__Delivery_Preference__c = 'Immediate';
		act.RDNACadence__Task_Description__c = '{"attributes":{"type":"Task"},"Status":"In Progress"}' ;
    }
    if(i==7){
        act.Name = 'Call Action';
        act.RDNACadence__Type__c = 'Call';
        act.RDNACadence__Activation_Type__c = 'Manual';
        act.RDNACadence__Delivery_Preference__c = 'Immediate';
    }
    
    listOfAction.add(act) ;

}

Insert listOfAction ;