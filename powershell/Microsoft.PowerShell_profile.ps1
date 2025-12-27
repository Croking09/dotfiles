function global:prompt {
    $cwd = (Get-Location).ProviderPath

    # Secuencia ANSI para cambiar el título de la ventana (compatible con Windows Terminal)
    $esc = [char]27
    Write-Host "$esc]9;9;$cwd$esc\" -NoNewline  # Cambia también la información en pestañas

    # Obtener rama Git si existe
    $branch = ''
    if (Test-Path .git) {
        $branchName = & git rev-parse --abbrev-ref HEAD 2>$null
        if ($branchName) {
            # Color verde en ANSI (para Windows Terminal)
            $branch = " $esc[32m($branchName)$esc[0m"
        }
    }

    # Retornar el prompt final
    "PS $cwd$branch> "
}

# Limpia la terminal y "oculta" el mensaje del nuevo powershell
Clear-Host

# Ejecutar fastfetch si está instalado
if (Get-Command fastfetch -ErrorAction SilentlyContinue) {
  fastfetch
}
