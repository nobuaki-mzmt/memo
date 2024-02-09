#------- rename files in a current directory -------#

# 1. simple replacing
Get-ChildItem -Filter *.analysis.h5 | Rename-Item -NewName { $_.Name -replace '\.mp4\.predictions\.000_', '.' -replace '\.analysis', '' }
Get-ChildItem -Filter *.new.mp4 | Rename-Item -NewName { $_.Name -replace '.new.mp4', '.mp4'}
Get-ChildItem -Filter CG*_FF1* | Rename-Item -NewName { $_.Name -replace '_FF1', '_FF_01'}
# by using -Recurse parameter, I can do the same for all items in the subdirectories
Get-ChildItem -Filter *.MP4 -Recurse | Rename-Item -NewName { $_.Name -replace '.MP4', '.mp4' }

# According to ChatGPT
# 'Get-ChildItem' cmdlet to get all the files in the current directory that match the *.analysis.h5 filter. 
# 'Rename-Item' cmdlet to rename each file
# The new name is created using a script block ({}) that applies two regular expressions to the original file name.

# The first regular expression (-replace '\.mp4\.predictions\.000_', '.') replaces the .mp4.predictions.000_ substring with a single dot. The second regular expression (-replace '\.analysis', '') removes the .analysis substring from the file name.

# This should result in the files being renamed to the desired format.
# "Gly-sat-327-2.mp4.predictions.000_Gly-sat-327-2.analysis.h5" -> "Gly-sat-327-2.h5"

Get-ChildItem -Filter *.h5 | Rename-Item -NewName { $_.Name -replace '.*\.G', 'G' }

#### Renaming other techniques
# Get the current directory
$directory = $PWD.Path
$files = Get-ChildItem -Path $directory -Filter "*.mp4"
# Loop through each file
foreach ($file in $files) {
    # Extracting the desired part of the filename using regex
    if ($file.Name -match '(p\d+-\d+).*\(1903.*\.wmv\)') {
        $oldFileName = $file.Name
        $newFileName = $matches[1] + ".mp4"
        
        # Construct the full path for the new filename
        $newFullPath = Join-Path -Path $directory -ChildPath $newFileName

        # Print the old and new filenames
        Write-Host "Old filename: $oldFileName"
        Write-Host "New filename: $newFileName"
        
        # Rename the file
        Rename-Item -Path $file.FullName -NewName $newFileName -Force
    }
}


# 2. complicated

$oldNames = Get-Content "H:\Ret_Comp_Tandem\R-ama\old.txt"
$newNames = Get-Content "H:\Ret_Comp_Tandem\R-ama\new.txt"

for ($i = 0; $i -lt $oldNames.Length; $i++) {
    Rename-Item -Path $oldNames[$i] -NewName $newNames[$i]
}



# To fill 0 in the 2-digit part of the file names, you can use PowerShell and a regular expression. Here's an example script that renames the files accordingly:
# Set the directory path where the files are located
$directory = "G:\Cf-Cg-homo-tandem"

# Get all the files in the directory
$files = Get-ChildItem -Path $directory

# Iterate through each file
foreach ($file in $files) {
    # Get the current file name
    $fileName = $file.Name

    # Check if the file name matches the pattern CF_FF_X.XX-*
    if ($fileName -match "^CF_FF_(\d+)\.(.+)$") {
        # Extract the number and extension from the file name
        $number = $matches[1]
        $extension = $matches[2]

        # Pad the number with leading zeros to make it 2 digits
        $paddedNumber = $number.PadLeft(2, '0')

        # Create the new file name with the padded number
        $newFileName = "CF_FF_$paddedNumber.$extension"

        # Rename the file
        $newFilePath = Join-Path -Path $directory -ChildPath $newFileName
        Rename-Item -Path $file.FullName -NewName $newFilePath

        # Output the renamed file name
        Write-Host "Renamed file: $newFileName"
    }
    else {
        # File name doesn't match the pattern, skip it
        Write-Host "Skipped file: $fileName"
    }
}

# Access network drive
New-PSDrive -Name Z -PSProvider FileSystem -Root '\\Mabo-NAS\MIzumotoPhoto\temporary\Nobu_temporal\Internal storage\DCIM\Camera' -Persist -Credential RemoteUser
Remove-Item -Path *copy* -Force

#------- fill with 0, e.g., CF_1.csv -> CF_01.csv -------#
$files = Get-ChildItem
# Loop through each file
foreach ($file in $files) {
    # Extract the filename and extension
    $filename = $file.BaseName
    $extension = $file.extension
    # Check if the filename contains a number
    if ($filename -match "(\d+)") {
        # Extract the numeric part
        $number = [int]$matches[1]

        # If the number is less than 10, pad it with a leading zero
        if ($number -lt 10) {
            $paddedNumber = "0$number"
            # Create the new filename with the padded number
            $newFilename = $filename -replace $number, $paddedNumber

            # Construct the new full filename
            $newFullFilename = $file.DirectoryName + '\\' + $newFilename + $extension

            # Rename the file
            Rename-Item $file.FullName  $newFullFilename 
        }
    }
}
