$table = $args[0]
$type = $args[1]
$procedureName = $args[2]
$createext = ".create.sql"
$dropext = ".drop.sql"

if ($type -eq "SP" || $type -eq "StoredProcedures") {
    $type = "StoredProcedures"
}
if ($type -eq "VW" || $type -eq "Views") {
    $type = "Views"
}
if ($type -eq "FN" || $type -eq "Functions") {
    $type = "Functions"
}

$tablesp = Join-Path -Path $table -ChildPath $type
$folder = Join-Path -Path $tablesp -ChildPath $procedureName

$createFile = Join-Path -Path $folder -ChildPath $procedureName$createext
$dropFile = Join-Path -Path $folder -ChildPath $procedureName$dropext

mkdir $folder && New-Item $createFile && New-Item $dropFile