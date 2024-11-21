## Скрипт для создания тестовых пользователей в Active Directory

### Атрибуты создаваемых пользователей:

- ФИО на кириллице (атрибут `displayName`);

- Заполненный уникальный атрибут `email`;

- Уникальный постфикс, позволяющий генерировать большое количество пользователей. 

### Пример сгеренированной учетной записи:

![Generated_AD_user](https://github.com/user-attachments/assets/fb9b458e-834e-44e0-ad18-9a7b7ee01064)

### Переменные в скрипте:
`$NumberOfUsers` - число генерируемых пользователей;

`$OUPath` - OU/CN в котором будут созданы пользователи в формате distinguished name (например, `OU=Test1,DC=localnet,DC=example,DC=ru`);

`$MailDomain` - почтовый домен (часть email после `@`);

`$UserPassword` - пароль, задаваемый создаваемым пользователям.

---

За основу взят данный скрипт:
https://www.archy.net/automated-random-user-creation-script-for-active-directory/.

Функция, выполняющая транслитерацию:
https://kio.by/zametki/powershell-transliteraciya-teksta/.
