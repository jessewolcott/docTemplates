$ProjectName = "Store 001"
$LeadTime    = "No"
$OutFile = "$PSScriptroot\$ProjectName-Budget.md"
$SourceFile = Import-Csv ".\PowershellGenerators\Examples\Project_Budget_Template\Project_Budget_Template.csv"

$Introduction = @"
$ProjetName Budget Summary

Lead Times will be calculated when available.

"@

if ($Outfile){
    Write-Output "Found Existing File. Removing."
    Remove-Item $OutFile -Force
}

$Header = "| Item | Projected Budget | Actual Expenditure |"
$Columns = "|---|---|---|"

$Body = Foreach ($LineItem in $SourceFile){
    $LineToAdd = ('| '+$LineItem.'Item'+' | '+$LineItem.'Projected Budget'+' | '+$LineItem.'Actual Expenditure'+' | ')
    Write-Output $LineToAdd
}

$Footer = ('| Total | '+(($Sourcefile.'Projected Budget') | Measure-Object -Sum).Sum+' | '+(($Sourcefile.'Actual Expenditure') | Measure-Object -Sum).Sum+' | ')

$OutFile = "$PSScriptroot\$ProjectName-Budget.md"
New-Item $OutFile -Force
$Introduction  | Add-Content $OutFile
$Header        | Add-Content $OutFile
$Columns       | Add-Content $OutFile
$Body          | Add-Content $OutFile
$Footer        | Add-Content $OutFile
