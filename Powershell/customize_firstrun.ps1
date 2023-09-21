# Define the variable text
$variableText = "This is the variable text you want to add"

# Read the contents of the file into a variable
$fileContents = Get-Content -Path "firstrun.sh"

# Find the position of "rm" in the file contents
$rmPosition = $fileContents.GetString("rm")

# Insert the variable text before "rm"
$fileContents = $fileContents.Insert($rmPosition, $variableText)

# Write the updated contents back to the file
Set-Content -Path "firstrun.sh" -Value $fileContents
