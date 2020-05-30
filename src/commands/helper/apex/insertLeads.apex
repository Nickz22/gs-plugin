Integer count = 100;
List<Lead> lstLead = new List<Lead>();
Map<String, Object> mapValueByFieldName = new Map<String, Object>{
    'LastName'=>'Test',
    'Company'=>'Test Company',
    'Email'=>'nickzsb.nz@gmail.com'
};
for(Integer i = 0; i<count; i++){
    Lead l = new Lead();
    for(String field : mapValueByFieldName.keyset())
        l.put(field, mapValueByFieldName.get(field));
    lstLead.add(l);
}
insert lstLead;