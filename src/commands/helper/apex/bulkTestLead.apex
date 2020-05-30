Map<String, Object> config = new Map<String, Object>{
  'filter' => new Map<String, Object>{ // set to match your sequence criteria
    'Email' => 'nickzsb.nz@gmail.com',
    'LastName' => 'Bulk',
    'Company' => 'Test'
  },
  'cadenceId' => 'a0321000004PLxFAAW', // target cadence
  'actionCount' => 4, // total actions created === (actionCount * 4)
  'leadCount' => 1000 // total leads created === (leadCount * 4)
};

String manual = 'manual';
List<Action__c> lstAction = Database.query(
  'Select id,Name,Email_Type__c,Activation_Type__c,Type__c from Action__c WHERE Activation_Type__c = :manual'
);

/**
 * deactivate other cadences for easier lead insertion
 */
List<Cadence__c> lstCadence = new List<Cadence__c>();
Id cadId = (Id) config.get('cadenceId');
for (Cadence__c c : [SELECT Id FROM Cadence__c WHERE Status__c = true]) {
  c.Status__c = false;
  lstCadence.add(c);
}
update lstCadence;
List<Lead> lstLead = new List<Lead>();
List<CadenceAction__c> lstCadAction = new List<CadenceAction__c>();

for (Integer i = 0; i < (Integer) config.get('leadCount'); i++) {
  Lead l = new Lead();
  for (String field : ((Map<String, Object>) config.get('filter')).keyset())
    l.put(field, ((Map<String, Object>) config.get('filter')).get(field));
  lstLead.add(l);
}
for (Integer i = 0; i < (Integer) config.get('actionCount'); i++) {
  Integer randomIndex = Math.round(
    Decimal.valueOf(lstAction.size() * Math.random())
  );
  Integer actionIndex = (randomIndex == lstAction.size()
    ? (lstAction.size() - 1)
    : randomIndex);
  Action__c action = lstAction[actionIndex];
  CadenceAction__c cadAction = new CadenceAction__c(
    Cadence_Id__c = (Id) config.get('cadenceId'),
    Action_Id__c = action.Id,
    Name = 'SequenceAction_' +
      action.Type__c +
      '_' +
      action.Email_Type__c +
      '_' +
      action.Activation_Type__c,
    Trigger_Type__c = 'Immediate',
    Index__c = i
  );
  lstCadAction.add(cadAction);
}
insert lstLead;
insert lstCadAction;
