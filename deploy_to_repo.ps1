param(
  [string]$TargetPath = "C:\Users\mahad\Documents\GitHub\miles-and-smiles-site",
  [string]$RemoteUrl = ""
)

Write-Host "Deploying site from workspace:" (Get-Location)
Write-Host "Target path:" $TargetPath

# Create target folder if missing
if (-not (Test-Path -Path $TargetPath)) {
  New-Item -ItemType Directory -Path $TargetPath -Force | Out-Null
}

# Copy files (exclude common folders)
$exDirs = @(".git", ".vscode", "node_modules")

# Use robocopy to copy files recursively
$src = $PSScriptRoot
$dst = $TargetPath
Write-Host "Copying files from $src to $dst (this may take a moment)..."
robocopy $src $dst /E /PURGE /XD .git ".vscode" "node_modules" | Out-Null

# Initialize git if available and commit
Set-Location $dst
$gitCmd = Get-Command git -ErrorAction SilentlyContinue
if (-not $gitCmd) {
    Write-Warning "Git executable not found in PATH. Skipping git init/commit/push steps."
    Write-Host "To enable automatic commits and pushes, install Git and ensure it's on your PATH: https://git-scm.com/downloads"
} else {
    Write-Host "Git found: $($gitCmd.Source)"
    if (-not (Test-Path .git)) {
      Write-Host "Initializing git repository..."
      & $gitCmd.Source init
    }

    Write-Host "Staging files..."
    & $gitCmd.Source add .

    try {
      & $gitCmd.Source commit -m "Deploy site from workspace" -q
      Write-Host "Committed changes."
    } catch {
      Write-Host "No changes to commit or commit failed: $_"
    }

    if ($RemoteUrl -ne "") {
      $remotes = & $gitCmd.Source remote
      if (-not $remotes) {
        Write-Host "Adding remote origin: $RemoteUrl"
        & $gitCmd.Source remote add origin $RemoteUrl
      }
      Write-Host "Pushing to origin/main (you may be prompted for credentials)..."
      & $gitCmd.Source branch -M main
      & $gitCmd.Source push -u origin main
    } else {
      Write-Host "No remote provided. To push to GitHub, re-run with -RemoteUrl 'https://github.com/username/repo.git'"
    }
}

Write-Host "Done."
