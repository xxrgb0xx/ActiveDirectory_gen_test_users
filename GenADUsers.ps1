############################################################
#
# Создание тестовых пользователей Active Directory
# За основу взят данный скрипт:
# https://www.archy.net/automated-random-user-creation-script-for-active-directory/
#
############################################################
# Переменные:

$NumberOfUsers = 1000
$OUPath = "OU=Test1,DC=localnet,DC=example,DC=ru"
$MailDomain = "localnet.example.ru"
$UserPassword = "CHANGEME!"

# Функция генерации рандомных имен
function Get-RandomName {
    $FirstName = Get-Random -InputObject @("Сергей", "Валентин", "Артём", "Роман", "Владимир", "Никита", "Олег", "Семен", "Вадим", "Егор", "Алексей", "Владислав", "Денис", "Дмитрий", "Илья", "Александр", "Фёдор", "Максим", "Антон", "Ярослав")
    $LastName = Get-Random -InputObject @("Зотов", "Васильев", "Богданов", "Захаров", "Попов", "Краснов", "Скворцов", "Гаврилов", "Иванов", "Долгов", "Михайлов", "Селезнев", "Чеботарев", "Калинин", "Колесников", "Зуев", "Корнеев", "Гаврилов", "Зубов", "Маслов")
    $SurName = Get-Random -InputObject @("Иванович", "Семёнович", "Александрович", "Миронович", "Романович", "Никитич", "Максимович", "Артёмович", "Константинович", "Глебович", "Маркович", "Юрьевич", "Фёдорович", "Григорьевич", "Андреевич", "Леонидович", "Артурович", "Антонович", "Павлович", "Русланович")
    $RandomPostfix = Get-Random
    $FullName = "$LastName $FirstName $SurName"
    return $FirstName, $LastName, $FullName, $RandomPostfix
}

# Цикл создания пользователей
for ($i = 1; $i -le $NumberOfUsers; $i++) {
    $FirstName, $LastName, $FullName, $RandomPostfix = Get-RandomName
    $UserName = "$LastName$FirstName"
    $NamePattern = "$LastName$RandomPostfix"
    $EmailPattern = $UserName+"_"+$RandomPostfix+"@"+$MailDomain
    $Email = Translit($EmailPattern)
    New-ADUser -Name $NamePattern -GivenName $FirstName -Surname $LastName -DisplayName $FullName -UserPrincipalName $Email -Email $Email -Path $OUPath -AccountPassword (ConvertTo-SecureString $UserPassword -AsPlainText -Force) -Enabled $true
    Write-Host "Создан пользователь: "$LastName"_"$RandomPostfix ($Email)
    $CurPercentage = [math]::Round(100/$NumberOfUsers*$i)
    Write-Host "$i/$NumberOfUsers ($CurPercentage%)"
    Write-Host "*********************************"
}

############################################################
#
# Транслитерация текста с помощью PowerShell
# Источник:
# https://kio.by/zametki/powershell-transliteraciya-teksta/
#
############################################################

function Translit ([string]$inString)
{
    #Создаём хеш-таблицу соответствия символов
    $Translit = @{
    [char]'а' = "a"
    [char]'А' = "A"
    [char]'б' = "b"
    [char]'Б' = "B"
    [char]'в' = "v"
    [char]'В' = "V"
    [char]'г' = "g"
    [char]'Г' = "G"
    [char]'д' = "d"
    [char]'Д' = "D"
    [char]'е' = "e"
    [char]'Е' = "E"
    [char]'ё' = "yo"
    [char]'Ё' = "Yo"
    [char]'ж' = "zh"
    [char]'Ж' = "Zh"
    [char]'з' = "z"
    [char]'З' = "Z"
    [char]'и' = "i"
    [char]'И' = "I"
    [char]'й' = "y"
    [char]'Й' = "Y"
    [char]'к' = "k"
    [char]'К' = "K"
    [char]'л' = "l"
    [char]'Л' = "L"
    [char]'м' = "m"
    [char]'М' = "M"
    [char]'н' = "n"
    [char]'Н' = "N"
    [char]'о' = "o"
    [char]'О' = "O"
    [char]'п' = "p"
    [char]'П' = "P"
    [char]'р' = "r"
    [char]'Р' = "R"
    [char]'с' = "s"
    [char]'С' = "S"
    [char]'т' = "t"
    [char]'Т' = "T"
    [char]'у' = "u"
    [char]'У' = "U"
    [char]'ф' = "f"
    [char]'Ф' = "F"
    [char]'х' = "kh"
    [char]'Х' = "Kh"
    [char]'ц' = "ts"
    [char]'Ц' = "Ts"
    [char]'ч' = "ch"
    [char]'Ч' = "Ch"
    [char]'ш' = "sh"
    [char]'Ш' = "Sh"
    [char]'щ' = "sch"
    [char]'Щ' = "Sch"
    [char]'ъ' = ""
    [char]'Ъ' = ""
    [char]'ы' = "y"
    [char]'Ы' = "Y"
    [char]'ь' = ""
    [char]'Ь' = ""
    [char]'э' = "e"
    [char]'Э' = "E"
    [char]'ю' = "yu"
    [char]'Ю' = "Yu"
    [char]'я' = "ya"
    [char]'Я' = "Ya"
    }
###    [string]$inString = Read-Host "Введите текст"
    $TranslitText =""
    foreach ($CHR in $inCHR = $inString.ToCharArray())
        {
        if ($Translit[$CHR] -cne $Null) 
            { $TranslitText += $Translit[$CHR] }
        else
            { $TranslitText += $CHR }
        }
    return $TranslitText
}
