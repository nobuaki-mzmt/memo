#------- rename files in a current directory -------#

# 1. simple replacing
Get-ChildItem -Filter *.analysis.h5 | Rename-Item -NewName { $_.Name -replace '\.mp4\.predictions\.000_', '.' -replace '\.analysis', '' }
Get-ChildItem -Filter *.new.mp4 | Rename-Item -NewName { $_.Name -replace '.new.mp4', '.mp4'}

# According to ChatGPT
# 'Get-ChildItem' cmdlet to get all the files in the current directory that match the *.analysis.h5 filter. 
# 'Rename-Item' cmdlet to rename each file
# The new name is created using a script block ({}) that applies two regular expressions to the original file name.

# The first regular expression (-replace '\.mp4\.predictions\.000_', '.') replaces the .mp4.predictions.000_ substring with a single dot. The second regular expression (-replace '\.analysis', '') removes the .analysis substring from the file name.

# This should result in the files being renamed to the desired format.
# "Gly-sat-327-2.mp4.predictions.000_Gly-sat-327-2.analysis.h5" -> "Gly-sat-327-2.h5"

Get-ChildItem -Filter *.h5 | Rename-Item -NewName { $_.Name -replace '.*\.G', 'G' }

# 2. complicated

$oldNames = Get-Content "H:\Ret_Comp_Tandem\R-ama\old.txt"
$newNames = Get-Content "H:\Ret_Comp_Tandem\R-ama\new.txt"

for ($i = 0; $i -lt $oldNames.Length; $i++) {
    Rename-Item -Path $oldNames[$i] -NewName $newNames[$i]
}

