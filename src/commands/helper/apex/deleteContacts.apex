String fieldName = 'Email';
String filterValue = 'nickzsb.nz@gmail.com';
Integer count = 200;

String query = 'SELECT Id FROM Contact WHERE '+fieldName+' != :filterValue LIMIT :count';

delete Database.query(query);