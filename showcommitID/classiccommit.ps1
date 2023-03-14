$GIT_TOKEN = "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"
$githeader =@{
    Authorization = "token $GIT_TOKEN"
    Accept = "application/vnd.github.v3+json"
}

$commitUrl = "https://api.github.com/repos/prabudeveloper/Developer/commits"
$commitResponse = Invoke-RestMethod -Uri $commitUrl -Headers $githeader -Method GET #| ConvertTo-Json > commis.json

$commitCount = $commitResponse.count
Write-Host "Total Commit ID : $commitCount"
Write-Host "Latest Commit ID : $($commitResponse[0].sha)"



# Define the PowerShell variable
$myVar =  $($commitResponse[0].sha)

# # Create a new JSON object that includes the PowerShell variable
# return  $myVar 

$jsonString = Get-Content -Path "D:\send Mail Plugin\SendEmail\task.json" | ConvertFrom-Json
$jsonString.inputs | % {if($_.name -eq 'CommitID'){$_.defaultValue=$myVar}}
Write-Host $jsonString.inputs.defaultValue[0]
$jsonString | ConvertTo-Json -depth 32| set-content 'D:\send Mail Plugin\SendEmail\task.json'