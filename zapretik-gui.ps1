Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$root = Split-Path -Parent $MyInvocation.MyCommand.Path

$form = New-Object System.Windows.Forms.Form
$form.Text = "zapretik 1.9.9.1"
$form.Size = New-Object System.Drawing.Size(420, 260)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

$labelStatus = New-Object System.Windows.Forms.Label
$labelStatus.Location = New-Object System.Drawing.Point(10, 10)
$labelStatus.Size = New-Object System.Drawing.Size(380, 40)
$labelStatus.Text = "Minimal GUI wrapper for service.bat and strategies."

$btnService = New-Object System.Windows.Forms.Button
$btnService.Location = New-Object System.Drawing.Point(10, 60)
$btnService.Size = New-Object System.Drawing.Size(180, 30)
$btnService.Text = "Open service.bat"
$btnService.Add_Click({
    Start-Process -FilePath "cmd.exe" -WorkingDirectory $root -ArgumentList '/c service.bat' -WindowStyle Normal
})

$btnShizapret = New-Object System.Windows.Forms.Button
$btnShizapret.Location = New-Object System.Drawing.Point(210, 60)
$btnShizapret.Size = New-Object System.Drawing.Size(180, 30)
$btnShizapret.Text = "Run shizapret.bat"
$btnShizapret.Add_Click({
    Start-Process -FilePath "cmd.exe" -WorkingDirectory $root -ArgumentList '/c shizapret.bat' -WindowStyle Normal
})

$btnUpdateLists = New-Object System.Windows.Forms.Button
$btnUpdateLists.Location = New-Object System.Drawing.Point(10, 110)
$btnUpdateLists.Size = New-Object System.Drawing.Size(180, 30)
$btnUpdateLists.Text = "Update lists (rulist)"
$btnUpdateLists.Add_Click({
    Start-Process -FilePath "cmd.exe" -WorkingDirectory $root -ArgumentList '/c service.bat  && exit' -WindowStyle Normal
    $labelStatus.Text = "Use menu: Update list-general / Update ipset-all."
})

$btnUpdateBin = New-Object System.Windows.Forms.Button
$btnUpdateBin.Location = New-Object System.Drawing.Point(210, 110)
$btnUpdateBin.Size = New-Object System.Drawing.Size(180, 30)
$btnUpdateBin.Text = "Update bin files"
$btnUpdateBin.Add_Click({
    Start-Process -FilePath "cmd.exe" -WorkingDirectory $root -ArgumentList '/c utils\update-bin.bat' -WindowStyle Normal
    $labelStatus.Text = "Running update-bin.bat in separate console."
})

$btnDiagnostics = New-Object System.Windows.Forms.Button
$btnDiagnostics.Location = New-Object System.Drawing.Point(10, 160)
$btnDiagnostics.Size = New-Object System.Drawing.Size(180, 30)
$btnDiagnostics.Text = "Run diagnostics"
$btnDiagnostics.Add_Click({
    Start-Process -FilePath "cmd.exe" -WorkingDirectory $root -ArgumentList '/c service.bat admin' -WindowStyle Normal
    $labelStatus.Text = "In service.bat use: Run Diagnostics."
})

$btnTests = New-Object System.Windows.Forms.Button
$btnTests.Location = New-Object System.Drawing.Point(210, 160)
$btnTests.Size = New-Object System.Drawing.Size(180, 30)
$btnTests.Text = "Run tests"
$btnTests.Add_Click({
    $scriptPath = Join-Path $root 'utils\test zapret.ps1'
    Start-Process -FilePath "powershell.exe" -WorkingDirectory $root -ArgumentList @(
        '-NoProfile'
        '-ExecutionPolicy'
        'Bypass'
        '-File'
        $scriptPath
    ) -WindowStyle Normal
    $labelStatus.Text = "Opening PowerShell tests window..."
})

$form.Controls.Add($labelStatus)
$form.Controls.Add($btnService)
$form.Controls.Add($btnShizapret)
$form.Controls.Add($btnUpdateLists)
$form.Controls.Add($btnUpdateBin)
$form.Controls.Add($btnDiagnostics)
$form.Controls.Add($btnTests)

[void]$form.ShowDialog()

