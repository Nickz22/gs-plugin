EmailTemplate validEmailTemplate = new EmailTemplate();
validEmailTemplate.isActive = true;
validEmailTemplate.Name = 'TestTemplate__00110011';
validEmailTemplate.DeveloperName = 'a_Template';
validEmailTemplate.TemplateType = 'text';
validEmailTemplate.Body='Test Body for Test';
validEmailTemplate.Subject='Test email Template';
validEmailTemplate.FolderId = UserInfo.getUserId();

insert validEmailTemplate;