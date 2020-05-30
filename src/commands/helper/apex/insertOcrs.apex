/**
  INSERT 50 OPPORTUNITYCONTACTROLES
**/
Id oppId;
List<OpportunityContactRole> lstOppRoles = new List<OpportunityContactRole>();
for(Contact c : [SELECT Id FROM Contact WHERE Id NOT IN (SELECT ContactId FROM OpportunityContactRole) LIMIT 50]){
	lstOppRoles.add(new OpportunityContactRole(ContactId=c.Id, OpportunityId=oppId));
}
insert lstOppRoles;