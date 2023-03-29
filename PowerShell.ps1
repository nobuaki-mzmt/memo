# rename files in a current directory

Get-ChildItem -Filter *.analysis.h5 | Rename-Item -NewName { $_.Name -replace '\.mp4\.predictions\.000_', '.' -replace '\.analysis', '' }

# According to ChatGPT
# 'Get-ChildItem' cmdlet to get all the files in the current directory that match the *.analysis.h5 filter. 
# 'Rename-Item' cmdlet to rename each file
# The new name is created using a script block ({}) that applies two regular expressions to the original file name.

# The first regular expression (-replace '\.mp4\.predictions\.000_', '.') replaces the .mp4.predictions.000_ substring with a single dot. The second regular expression (-replace '\.analysis', '') removes the .analysis substring from the file name.

# This should result in the files being renamed to the desired format.
# "Gly-sat-327-2.mp4.predictions.000_Gly-sat-327-2.analysis.h5" -> "Gly-sat-327-2.h5"

Get-ChildItem -Filter *.h5 | Rename-Item -NewName { $_.Name -replace '.*\.G', 'G' }