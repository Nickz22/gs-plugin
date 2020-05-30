/** 
  UPDATE 50 TEST CONTACT 
**/
String updateField = 'Email';
Object updateValue = 'nickzsb.nz@gmail.com';
List<Contact> lstContact = new List<Contact>();
for(Contact c : [SELECT Id FROM Contact LIMIT 50]){
    c.put(updateField, (String) updateValue);
    lstContact.add(c);
}
update lstContact;
