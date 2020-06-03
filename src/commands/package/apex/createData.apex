String NAMESPACE = 'RDNACadence__' ;
List<RDNACadence__Cadence__c> sequenceList = Database.query('Select id,Name from '+NAMESPACE+'Cadence__c ');

Integer random= Math.mod(Math.round(Math.random()*1000), 999);
List<Lead> leadListForLeadSequence = new List<Lead>();
List<Contact> contactListForContactSequence = new List<Contact>();
List<Opportunity> opportunitytListForOpportunitySequence = new List<Opportunity>();
List<Campaign> campaignListForCampaignSequence = new List<Campaign>();
List<OpportunityContactRole> oppContactRole = new List<OpportunityContactRole>();
List<CampaignMember> campaignsMembersList = new List<CampaignMember>();

for(RDNACadence__Cadence__c sequence :sequenceList){
    if(String.valueOf(sequence.name).contains('Sequence Lead')){
        Lead testLead = null ;
        for(Integer i=0;i<200;i++){
            testLead=new Lead(FirstName='Lead'+String.valueOf(i) ,LastName=sequence.name,RDNACadence__isActivated__C=true,Company ='test1'+Math.mod(Math.round(Math.random()*1000), 999)+i+Math.mod(Math.round(Math.random()*1000), 999)+'3Company',Phone=String.valueOf(Math.mod(Math.round(Math.random()*1000), 999)+'3644561'),Email ='test'+i+Math.mod(Math.round(Math.random()*1000), 999)*Math.mod(Math.round(Math.random()*1000), 999)+'3@test.com');
            leadListForLeadSequence.add(testLead);
        } 
    }
    if(String.valueOf(sequence.name).contains('Sequence Contact')){
        Contact testContact ;
        for(Integer i=0;i<200;i++){
            testContact=new Contact(FirstName='Contact'+String.valueOf(i),LastName=sequence.name,RDNACadence__isActivated__C=true,Email ='test1'+Integer.valueOf(Math.random()*10)+Math.mod(Math.round(Math.random()*1000), 999)*2*Math.mod(Math.round(Math.random()*1000), 999)+'3@test.com',Phone=String.valueOf(Math.mod(Math.round(Math.random()*1000), 999)+'8757861'),Department = 'IT');
            contactListForContactSequence.add(testContact);
        } 
    }
    if(String.valueOf(sequence.name).contains('Sequence Opportunity')){
        Opportunity opp = new Opportunity(Name=sequence.name, CloseDate = System.now().date(), StageName='Prospecting');
        opportunitytListForOpportunitySequence.add(opp);
        
    }
    if(String.valueOf(sequence.name).contains('Sequence Campaign')){
        Campaign testCampaign=new Campaign(Name=sequence.name,ActualCost=4000000234.0,IsActive=True);
        campaignListForCampaignSequence.add(testCampaign);
        
    }
}

insert leadListForLeadSequence;
insert contactListForContactSequence;

insert opportunitytListForOpportunitySequence ;  
for(Opportunity opp : opportunitytListForOpportunitySequence){
    
    List<Contact> contactListForOpportunitySequence = new List<Contact>();
    Contact testContact = null;
    for(Integer i=0;i<2;i++){
        testContact=new Contact(FirstName='Contact'+String.valueOf(i),LastName=opp.name,RDNACadence__isActivated__C=true,Email ='test56_'+Math.mod(Math.round(Math.random()*1000), 999)+'57'+Math.mod(Math.round(Math.random()*1000), 999)*2*Math.mod(Math.round(Math.random()*1000), 999)+'31@test.com',Phone=String.valueOf(Math.mod(Math.round(Math.random()*1000), 999)+'8521'+Math.mod(Math.round(Math.random()*1000), 999)),Department = 'IT');
        contactListForOpportunitySequence.add(testContact);
    }
    insert contactListForOpportunitySequence ;
    
    for(Integer i=0;i<2;i++){
        OpportunityContactRole ocr = new OpportunityContactRole();
        ocr.ContactId = contactListForOpportunitySequence[i].Id;
        ocr.OpportunityId = opp.Id;
        ocr.IsPrimary = TRUE;
        ocr.Role = 'Decision Maker';
        oppContactRole.add(ocr);
    }
}

insert oppContactRole ;

insert campaignListForCampaignSequence ;

for(Campaign campaign :campaignListForCampaignSequence){
    
    List<Contact> contactListForCampaignSequence = new List<Contact>();
    List<Lead> leadListForCampaignSequence = new List<Lead>();
    Contact testContact = null;
    Lead testlead = null ;
    for(Integer i=0;i<1;i++){
        testContact=new Contact(FirstName='Contact'+String.valueOf(i),LastName=campaign.name,RDNACadence__isActivated__C=true,Email ='test51'+Math.mod(Math.round(Math.random()*1000), 999)*5*Math.mod(Math.round(Math.random()*1000), 999)+'0011@test.com',Phone=String.valueOf(Math.mod(Math.round(Math.random()*1000), 999)+'8110'+Math.mod(Math.round(Math.random()*1000), 999)),Department = 'IT');
        testLead=new Lead(FirstName='Lead'+String.valueOf(i) ,LastName=campaign.name,RDNACadence__isActivated__C=true,Company ='test1'+Math.mod(Math.round(Math.random()*1000), 999)+i+Math.mod(Math.round(Math.random()*1000), 999)+'123Company',Phone=String.valueOf(Math.mod(Math.round(Math.random()*1000), 999)+'3623'+Math.mod(Math.round(Math.random()*1000), 999)),Email ='test'+i*Math.mod(Math.round(Math.random()*1000), 999)+'_'+Math.mod(Math.round(Math.random()*1000), 999)+'3@test.com');
        leadListForCampaignSequence.add(testLead);
        contactListForCampaignSequence.add(testContact);
    }
    insert contactListForCampaignSequence;
    insert leadListForCampaignSequence;
    
    if(contactListForCampaignSequence.size()>0){
        for(Contact con : contactListForCampaignSequence ){
            CampaignMember campaignMember = new CampaignMember();
            campaignMember.campaignid = campaign.id ;
            campaignMember.contactid = con.id ;
            campaignsMembersList.add(campaignMember);
        }
    }
    if(leadListForCampaignSequence.size()>0){
        for(Lead lead : leadListForCampaignSequence ){
            CampaignMember campaignMember = new CampaignMember();
            campaignMember.campaignid = campaign.id ;
            campaignMember.leadid = lead.id ;
            campaignsMembersList.add(campaignMember);
        }
    }
}
insert campaignsMembersList ;
