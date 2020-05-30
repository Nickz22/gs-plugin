Integer count = 100;
Id accountId;
List<Contact> lstContact = new List<Contact>();
Map<String, Object> mapValueByFieldName = new Map<String, Object>{
    'LastName'=>'Test',
    'AccountId'=>accountId,
    'Email'=>'nickzsb.nz@gmail.com'
};
for(Integer i = 0; i<count; i++){
    Contact c = new Contact();
    for(String field : mapValueByFieldName.keyset())
        c.put(field, mapValueByFieldName.get(field));
    lstContact.add(c);
}
insert lstContact;