String NAMESPACE = 'RDNACadence__' ;
List<RDNACadence__Cadence__c> sequenceList = Database.query('Select id,Name from '+NAMESPACE+'Cadence__c ');
List<RDNACadence__Action__c> actionList = Database.query('Select id,Name,'+NAMESPACE+'Email_Type__c,'+NAMESPACE+'Activation_Type__c,'+NAMESPACE+'Type__c from '+NAMESPACE+'Action__c ');
List<RDNACadence__CadenceAction__c> cadenceActionList =new List<RDNACadence__CadenceAction__c>();
for(RDNACadence__Cadence__c sequence : sequenceList){
    RDNACadence__CadenceAction__c cadAction = null ;
    if(String.ValueOf(sequence.name).contains('Email')){ 

            Integer index = 0;
            integer i =0;
            while( i!=4){  
 
                cadAction = new RDNACadence__CadenceAction__c();
                cadAction.RDNACadence__Cadence_Id__c = sequence.Id;
                cadAction.RDNACadence__Action_Id__c = actionList[i].Id;
                cadAction.Name = 'SequenceAction_'+actionList[i].RDNACadence__Type__c+'_'+actionList[i].RDNACadence__Email_Type__c+'_'+actionList[i].RDNACadence__Activation_Type__c;
                cadAction.RDNACadence__Trigger_Type__c = 'Immediate';
                cadAction.RDNACadence__Index__c =index; 
                index++;
                i+=2 ;
                cadenceActionList.add(cadAction);
            } 
        
            i =1;
            while( i!=5){    				
                cadAction = new RDNACadence__CadenceAction__c();
                cadAction.RDNACadence__Cadence_Id__c = sequence.Id;
                cadAction.RDNACadence__Action_Id__c = actionList[i].Id;
                cadAction.Name = 'SequenceAction_'+actionList[i].RDNACadence__Type__c+'_'+actionList[i].RDNACadence__Email_Type__c+'_'+actionList[i].RDNACadence__Activation_Type__c;
                cadAction.RDNACadence__Trigger_Type__c = 'Immediate';
                cadAction.RDNACadence__Index__c =index; 
                index++;
                i+=2;
                cadenceActionList.add(cadAction);
            } 
        
    }
    if(String.ValueOf(sequence.name).contains('Task')){
        Integer index = 0;
        cadAction = new RDNACadence__CadenceAction__c();
        cadAction.RDNACadence__Cadence_Id__c = sequence.Id;
        cadAction.RDNACadence__Action_Id__c = actionList[5].Id;
        cadAction.Name = 'SequenceAction_'+actionList[5].RDNACadence__Type__c+'_'+actionList[5].RDNACadence__Activation_Type__c;
        cadAction.RDNACadence__Trigger_Type__c = 'Immediate';
        cadAction.RDNACadence__Index__c =index; 
        index++; 
        cadenceActionList.add(cadAction);
    }
    if(String.ValueOf(sequence.name).contains('Call')){
        Integer index = 0;
        cadAction = new RDNACadence__CadenceAction__c();
        cadAction.RDNACadence__Cadence_Id__c = sequence.Id;
        cadAction.RDNACadence__Action_Id__c = actionList[6].Id;
        cadAction.Name = 'SequenceAction_'+actionList[6].RDNACadence__Type__c+'_'+actionList[6].RDNACadence__Activation_Type__c;
        cadAction.RDNACadence__Trigger_Type__c = 'Immediate';
        cadAction.RDNACadence__Index__c =index; 
        index++; 
        cadenceActionList.add(cadAction);
        
    }
    if(String.ValueOf(sequence.name).contains('SMS')){
        Integer index = 0;
        cadAction = new RDNACadence__CadenceAction__c();
        cadAction.RDNACadence__Cadence_Id__c = sequence.Id;
        cadAction.RDNACadence__Action_Id__c = actionList[4].Id;
        cadAction.Name = 'SequenceAction_'+actionList[4].RDNACadence__Type__c+'_'+actionList[4].RDNACadence__Activation_Type__c;
        cadAction.RDNACadence__Trigger_Type__c = 'Immediate';
        cadAction.RDNACadence__Index__c =index; 
        index++; 
        cadenceActionList.add(cadAction);
        
    }
    if(String.ValueOf(sequence.name).contains('All Actions')){
        Integer index = 0;
        for(integer i=0;i<7;i++){
            cadAction = new RDNACadence__CadenceAction__c();
            cadAction.RDNACadence__Cadence_Id__c = sequence.Id;
            cadAction.RDNACadence__Action_Id__c = actionList[i].Id;
			if(actionList[i].RDNACadence__Email_Type__c != null || actionList[i].RDNACadence__Email_Type__c != ''){
			cadAction.Name = 'SequenceAction_'+actionList[i].RDNACadence__Type__c+'_'+actionList[i].RDNACadence__Email_Type__c+'_'+actionList[i].RDNACadence__Activation_Type__c;
            
			}
			else{
			cadAction.Name = 'SequenceAction_'+actionList[i].RDNACadence__Type__c+'_'+actionList[i].RDNACadence__Activation_Type__c;
			}
            cadAction.RDNACadence__Trigger_Type__c = 'Immediate';
            cadAction.RDNACadence__Index__c =index; 
            index++;
            cadenceActionList.add(cadAction);
        } 
    }
}        

Insert cadenceActionList ;