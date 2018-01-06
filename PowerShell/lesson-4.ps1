param ([string]$Path = ".",[long]$MinSize = 0)

"You gave me a path of $Path"
"You want a minimum size of $MinSize"

Get-ChildItem -Path $Path

