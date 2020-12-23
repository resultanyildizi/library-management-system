$appFolder = "D:/projects/real_projects/Library-Management-System/app/"
$serverFolder = "D:/projects/real_projects/Library-Management-System/server/"
$databaseFolder = "D:/projects/real_projects/Library-Management-System/sql/"

wt -d $serverFolder cmd /k npm run dev && wt -d $appFolder cmd /k npm run electron:serve && code $appFolder && code $serverFolder && code $databaseFolder 