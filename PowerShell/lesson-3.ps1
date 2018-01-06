Get-Process > procs.txt
Get-Process | Export-Csv procs.csv
Get-Process | Export-Clixml procs.xml

Get-Date | ConvertTo-Csv
Get-Date | ConvertTo-Json
Get-Date | select * | ConvertTo-Json
Get-Date | ConvertTo-Html
Get-Date | ConvertTo-Csv | ConvertFrom-Csv | Get-Member
Get-Member | ConvertTo-Json | ConvertFrom-Json | Get-Member
Get-Date | select * | ConvertTo-Json | ConvertFrom-Json | Get-Member

# Slide 8

# Slide 10

# Slide 12

# Slide 16

# Slide 20