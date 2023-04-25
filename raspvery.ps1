# copy file from raspbery pi to windows
# run the following in cmd
scp pi@10.9.193.108:/var/www/html/media/*.jpg G:/rpi/01
scp pi@10.9.193.225:/var/www/html/media/*.jpg G:/rpi/02
scp pi@10.9.193.37:/var/www/html/media/*.jpg G:/rpi/03
scp pi@10.9.193.190:/var/www/html/media/*.jpg G:/rpi/04
scp pi@10.9.193.163:/var/www/html/media/*.jpg G:/rpi/05
scp pi@10.9.193.48:/var/www/html/media/*.jpg G:/rpi/06
scp pi@10.9.193.232:/var/www/html/media/*.jpg G:/rpi/07
scp pi@10.9.193.39:/var/www/html/media/*.jpg G:/rpi/08
scp pi@10.9.193.81:/var/www/html/media/*.jpg G:/rpi/09
scp pi@10.9.193.171:/var/www/html/media/*.jpg G:/rpi/10

# Naming

Get-ChildItem -Path . -Filter *th.jpg -Recurse | ForEach-Object {
    Move-Item $_.FullName "G:\rpi\th\$_."
}




Get-ChildItem -Path "G:\rpi\04" -Filter tl_0000* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0000', 'Ret_oki_NM2311_4'
    Move-Item $_.FullName "G:\rpi\Ret_oki_NM2311_4\$newName"
}

Get-ChildItem -Path "G:\rpi\04" -Filter tl_0001* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0001', 'Ret_oki_NM2311_4_add'
    Move-Item $_.FullName "G:\rpi\Ret_oki_NM2311_4\$newName"
}

Get-ChildItem -Path "G:\rpi\04" -Filter tl_0002* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0002', 'Ret_ama_NM2345_4'
    Move-Item $_.FullName "G:\rpi\Ret_ama_NM2345_4\$newName"
}
Get-ChildItem -Path "G:\rpi\04" -Filter tl_0003* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0003', 'Ret_ama_NM2345_4_add'
    Move-Item $_.FullName "G:\rpi\Ret_ama_NM2345_4\$newName"
}




Get-ChildItem -Path "G:\rpi\04" -Filter tl_0000* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0000', 'Ret_oki_NM2311_4'
    Move-Item $_.FullName "G:\rpi\Ret_oki_NM2311_4\$newName"
}

Get-ChildItem -Path "G:\rpi\04" -Filter tl_0001* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0001', 'Ret_oki_NM2311_4_add'
    Move-Item $_.FullName "G:\rpi\Ret_oki_NM2311_4\$newName"
}

Get-ChildItem -Path "G:\rpi\04" -Filter tl_0002* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0002', 'Ret_ama_NM2345_4'
    Move-Item $_.FullName "G:\rpi\Ret_ama_NM2345_4\$newName"
}
Get-ChildItem -Path "G:\rpi\04" -Filter tl_0003* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0003', 'Ret_ama_NM2345_4_add'
    Move-Item $_.FullName "G:\rpi\Ret_ama_NM2345_4\$newName"
}



Get-ChildItem -Path "G:\rpi\04" -Filter tl_0000* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0000', 'Ret_oki_NM2311_4'
    Move-Item $_.FullName "G:\rpi\Ret_oki_NM2311_4\$newName"
}

Get-ChildItem -Path "G:\rpi\04" -Filter tl_0001* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0001', 'Ret_oki_NM2311_4_add'
    Move-Item $_.FullName "G:\rpi\Ret_oki_NM2311_4\$newName"
}

Get-ChildItem -Path "G:\rpi\04" -Filter tl_0002* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0002', 'Ret_ama_NM2345_4'
    Move-Item $_.FullName "G:\rpi\Ret_ama_NM2345_4\$newName"
}
Get-ChildItem -Path "G:\rpi\04" -Filter tl_0003* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0003', 'Ret_ama_NM2345_4_add'
    Move-Item $_.FullName "G:\rpi\Ret_ama_NM2345_4\$newName"
}



Get-ChildItem -Path "G:\rpi\05" -Filter tl_0000* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0000', 'Ret_oki_NM2311_5'
    Move-Item $_.FullName "G:\rpi\Ret_oki_NM2311_5\$newName"
}

Get-ChildItem -Path "G:\rpi\05" -Filter tl_0001* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0001', 'Ret_oki_NM2311_5_add'
    Move-Item $_.FullName "G:\rpi\Ret_oki_NM2311_5\$newName"
}

Get-ChildItem -Path "G:\rpi\05" -Filter tl_0002* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0002', 'Ret_ama_NM2345_5'
    Move-Item $_.FullName "G:\rpi\Ret_ama_NM2345_5\$newName"
}
Get-ChildItem -Path "G:\rpi\05" -Filter tl_0003* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0003', 'Ret_ama_NM2345_5_add'
    Move-Item $_.FullName "G:\rpi\Ret_ama_NM2345_5\$newName"
}



Get-ChildItem -Path "G:\rpi\06" -Filter tl_0000* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0000', 'Ret_fla_487_1'
    Move-Item $_.FullName "G:\rpi\Ret_fla_487_1\$newName"
}
Get-ChildItem -Path "G:\rpi\06" -Filter tl_0001* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0001', 'Ret_fla_487_1_add'
    Move-Item $_.FullName "G:\rpi\Ret_fla_487_1\$newName"
}
Get-ChildItem -Path "G:\rpi\06" -Filter tl_0002* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0002', 'Ret_fla_487_1_add2'
    Move-Item $_.FullName "G:\rpi\Ret_fla_487_1\$newName"
}
Get-ChildItem -Path "G:\rpi\06" -Filter tl_0003* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0003', 'Ret_fla_487_1_add3'
    Move-Item $_.FullName "G:\rpi\Ret_fla_487_1\$newName"
}
Get-ChildItem -Path "G:\rpi\06" -Filter tl_0004* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0004', 'Ret_ama_NM2336_1'
    Move-Item $_.FullName "G:\rpi\Ret_ama_NM2336_1\$newName"
}
Get-ChildItem -Path "G:\rpi\06" -Filter tl_0005* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0005', 'Ret_ama_NM2336_1_add'
    Move-Item $_.FullName "G:\rpi\Ret_ama_NM2336_1\$newName"
}


Get-ChildItem -Path "G:\rpi\07" -Filter tl_0000* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0000', 'Ret_fla_487_2'
    Move-Item $_.FullName "G:\rpi\Ret_fla_487_2\$newName"
}
Get-ChildItem -Path "G:\rpi\07" -Filter tl_0001* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0001', 'Ret_fla_487_2_add'
    Move-Item $_.FullName "G:\rpi\Ret_fla_487_2\$newName"
}
Get-ChildItem -Path "G:\rpi\07" -Filter tl_0002* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0002', 'Ret_fla_487_2_add2'
    Move-Item $_.FullName "G:\rpi\Ret_fla_487_2\$newName"
}
Get-ChildItem -Path "G:\rpi\07" -Filter tl_0003* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0003', 'Ret_ama_NM2336_2'
    Move-Item $_.FullName "G:\rpi\Ret_fla_487_2\$newName"
}
Get-ChildItem -Path "G:\rpi\07" -Filter tl_0004* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0004', 'Ret_ama_NM2336_2_add'
    Move-Item $_.FullName "G:\rpi\Ret_ama_NM2336_2\$newName"
}


Get-ChildItem -Path "G:\rpi\08" -Filter tl_0000* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0000', 'Ret_fla_487_3'
    Move-Item $_.FullName "G:\rpi\Ret_fla_487_3\$newName"
}
Get-ChildItem -Path "G:\rpi\08" -Filter tl_0001* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0001', 'Ret_fla_487_3_add'
    Move-Item $_.FullName "G:\rpi\Ret_fla_487_3\$newName"
}
Get-ChildItem -Path "G:\rpi\08" -Filter tl_0002* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0002', 'Ret_ama_NM2336_3'
    Move-Item $_.FullName "G:\rpi\Ret_ama_NM2336_3\$newName"
}
Get-ChildItem -Path "G:\rpi\08" -Filter tl_0003* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0003', 'Ret_ama_NM2336_3_add'
    Move-Item $_.FullName "G:\rpi\Ret_ama_NM2336_3\$newName"
}


Get-ChildItem -Path "G:\rpi\09" -Filter tl_0000* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0000', 'Ret_fla_487_4'
    Move-Item $_.FullName "G:\rpi\Ret_fla_487_4\$newName"
}
Get-ChildItem -Path "G:\rpi\09" -Filter tl_0001* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0001', 'Ret_fla_487_4_add'
    Move-Item $_.FullName "G:\rpi\Ret_fla_487_4\$newName"
}
Get-ChildItem -Path "G:\rpi\09" -Filter tl_0002* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0002', 'Ret_ama_NM2336_4'
    Move-Item $_.FullName "G:\rpi\Ret_ama_NM2336_4\$newName"
}
Get-ChildItem -Path "G:\rpi\09" -Filter tl_0003* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0003', 'Ret_ama_NM2336_4_add'
    Move-Item $_.FullName "G:\rpi\Ret_ama_NM2336_4\$newName"
}


Get-ChildItem -Path "G:\rpi\10" -Filter tl_0000* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0000', 'Ret_fla_487_5'
    Move-Item $_.FullName "G:\rpi\Ret_fla_487_5\$newName"
}
Get-ChildItem -Path "G:\rpi\10" -Filter tl_0001* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0001', 'Ret_fla_487_5_add'
    Move-Item $_.FullName "G:\rpi\Ret_fla_487_5\$newName"
}
Get-ChildItem -Path "G:\rpi\10" -Filter tl_0002* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0002', 'Ret_ama_NM2336_5'
    Move-Item $_.FullName "G:\rpi\Ret_ama_NM2336_5\$newName"
}
Get-ChildItem -Path "G:\rpi\10" -Filter tl_0003* | ForEach-Object {
    $newName = $_.Name -replace 'tl_0003', 'Ret_ama_NM2336_5_add'
    Move-Item $_.FullName "G:\rpi\Ret_ama_NM2336_5\$newName"
}
