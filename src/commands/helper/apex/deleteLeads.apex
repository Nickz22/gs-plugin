Integer count = 200;

String query = 'SELECT Id FROM Lead LIMIT :count';

delete Database.query(query);
