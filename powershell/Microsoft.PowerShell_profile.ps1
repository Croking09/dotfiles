Import-Module posh-git

# ─────────────────────────────────────────────
# Posh-git
# ─────────────────────────────────────────────

# Working directory
$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
$GitPromptSettings.DefaultPromptPath.ForegroundColor = 'DeepSkyBlue'

# Git
$GitPromptSettings.BeforeStatus = '('
$GitPromptSettings.AfterStatus = ')'
$GitPromptSettings.BeforeStatus.ForegroundColor = 'LightGreen'
$GitPromptSettings.AfterStatus.ForegroundColor = 'LightGreen'

$GitPromptSettings.BranchColor.ForegroundColor = 'LightGreen'

$GitPromptSettings.EnableFileStatus = $false

# Prompt end
$GitPromptSettings.DefaultPromptSuffix = ' $ '

# ─────────────────────────────────────────────
# Windows Terminal title prompt
# ─────────────────────────────────────────────

function global:prompt {
    $cwd = (Get-Location).ProviderPath

    # Updates tab title in Windows Terminal
    $esc = [char]27
    Write-Host "$esc]9;9;$cwd$esc\" -NoNewline

    # Posh-git prompt
    & $GitPromptScriptBlock
}

# Fastfetch if instaled
if (Get-Command fastfetch -ErrorAction SilentlyContinue) {
  fastfetch
}
