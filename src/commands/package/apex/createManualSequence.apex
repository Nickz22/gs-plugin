List<RDNACadence__Cadence__c> listOfSequence = new List<RDNACadence__Cadence__c>();
for(integer i=0;i<5;i++){
    for(integer j =6 ;j<8;j++){
        String entranceCriteria =null;
        String additionalString =null;

        RDNACadence__Cadence__c cad = new RDNACadence__Cadence__c();
        cad.RDNACadence__Status__c = False ;
        cad.RDNACadence__Participent_Activation__c = 'Automatic'; 
        if(i==0){
            cad.Name+= 'Email' ; 
            additionalString = 'Email';
        }
        if(i==1){
            cad.Name+= 'Task' ; 
            additionalString = 'Task';
        }
        if(i==2){
            cad.Name+= 'Call' ;
            additionalString = 'Call';
        }
        if(i==3){
            cad.Name+= 'SMS' ; 
            additionalString = 'SMS';
        }
        if(i==4){
            cad.Name+= 'All Actions' ; 
            additionalString = 'All Actions';
        }
		if(j==6){
            
            entranceCriteria = 'Sequence Opportunity Manual '+additionalString;
            String E1  =String.valueOf('{"postFixExpression":null,"executionCriterion":"Conditions are met","criterions":{"1":{"value":"');
			String E2  =String.valueOf('","secondValue":null,"picklistApiNameAndValues":null,"operation":"equals","listPicklistValues":null,"id":1,"fieldName":"Name","fieldLabel":null,"fieldDataType":"STRING"}},"criterionPriorityFormula":"","condition":"AND"}');
        
            String entryCriterionJson = E1+entranceCriteria+E2 ;
            String exitCriterionJson = String.valueOf('{"postFixExpression":null,"executionCriterion":"Conditions are met","criterions":{"1":{"value":"Exit","secondValue":null,"picklistApiNameAndValues":null,"operation":"equals","listPicklistValues":null,"id":1,"fieldName":"Name","fieldLabel":null,"fieldDataType":"STRING"}},"criterionPriorityFormula":"","condition":"AND"}') ; 
          
            cad.Name = entranceCriteria ;
            cad.RDNACadence__Record_Type__c = 'Opportunity';
            cad.RDNACadence__Participent_Activation__c = 'Manual'; 
            cad.RDNACadence__Entrance_Criteria__c = entryCriterionJson;
            cad.RDNACadence__Exit_Criteria__c = exitCriterionJson;
            cad.RDNACadence__matching_priority__c = 'P1';
			listOfSequence.add(cad);
            
        }
        if(j==7){
            
            entranceCriteria = 'Sequence Campaign Manual '+additionalString;
            String E1  =String.valueOf('{"postFixExpression":null,"executionCriterion":"Conditions are met","criterions":{"1":{"value":"');
			String E2  =String.valueOf('","secondValue":null,"picklistApiNameAndValues":null,"operation":"equals","listPicklistValues":null,"id":1,"fieldName":"Name","fieldLabel":null,"fieldDataType":"STRING"}},"criterionPriorityFormula":"","condition":"AND"}');
        
            String entryCriterionJson = E1+entranceCriteria+E2 ;
            String exitCriterionJson = String.valueOf('{"postFixExpression":null,"executionCriterion":"Conditions are met","criterions":{"1":{"value":"Exit","secondValue":null,"picklistApiNameAndValues":null,"operation":"equals","listPicklistValues":null,"id":1,"fieldName":"Name","fieldLabel":null,"fieldDataType":"STRING"}},"criterionPriorityFormula":"","condition":"AND"}') ; 

            cad.Name = entranceCriteria ;
            cad.RDNACadence__Record_Type__c = 'Campaign';
            cad.RDNACadence__Participent_Activation__c = 'Manual'; 
            cad.RDNACadence__Entrance_Criteria__c = entryCriterionJson;
            cad.RDNACadence__Exit_Criteria__c = exitCriterionJson;
            cad.RDNACadence__matching_priority__c = 'P1';
			listOfSequence.add(cad);
            
        }
        
        
    }
}
insert listOfSequence ;