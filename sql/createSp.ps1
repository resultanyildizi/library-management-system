$table = $args[0]
$type = $args[1]
$procedureName = $args[2]
$createext = ".create.sql"
$dropext = ".drop.sql"

$tablesp = Join-Path -Path $table -ChildPath $type
$folder = Join-Path -Path $tablesp -ChildPath $procedureName

$createFile = Join-Path -Path $folder -ChildPath $procedureName$createext
$dropFile = Join-Path -Path $folder -ChildPath $procedureName$dropext

mkdir $folder && New-Item $createFile && New-Item $dropFile