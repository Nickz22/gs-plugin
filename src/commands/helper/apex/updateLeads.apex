List<Lead> lstLeads = new List<Lead>();
String fieldName = 'Email';
String filterValue = 'nickzsb.nz@gmail.com';

String query = 'SELECT Id FROM Lead WHERE '+fieldName+' != :filterValue LIMIT 50';
for(Lead l : (List<Lead>) Database.query(query)){
    l.Email ='nickzsb.nz@gmail.com';
    lstLeads.add(l);
}
update lstLeads;