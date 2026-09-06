# scaffold-repo.ps1 — materializa a estrutura canônica do template Cursor
# Vive na RAIZ do template (pasta destino ainda vazia não tem scripts/).
# Fonte = diretório deste script. Destino = -Target (default: cwd).
[CmdletBinding()]
param(
    [switch]$Help,
    [switch]$Uninstall,
    [Alias('q')][switch]$Quiet,
    [Alias('f')][switch]$Force,
    [switch]$Ssh,
    [string]$Log,
    [Alias('Target')][string]$Destination = ''
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$Script:Version = '1.0.0'
$Script:ManifestName = '.scaffold-manifest'
$Script:SourceRoot = $PSScriptRoot
if ([string]::IsNullOrWhiteSpace($Destination)) {
    $Script:TargetRoot = (Get-Location).Path
}
else {
    $Script:TargetRoot = [System.IO.Path]::GetFullPath($Destination)
}

$Script:FileList = @(
    '.gitignore',
    '.cursorignore',
    'readme.md',
    'spec-project-bootstrap.md',
    'spec-root.md',
    'flow.md',
    'rules.md',
    'status.md',
    'timeline.md',
    'setup.md',
    'tools-linux.md',
    'tools-windows.md',
    '.cursorrules',
    '.prompt-status',
    'spec-template.md',
    'rules-scripts.md',
    'scaffold-repo.ps1',
    'scaffold-repo.sh',
    'docs/readme.md',
    'ideas/readme.md',
    'specs/readme.md',
    'specs/to-do/readme.md',
    'specs/done/readme.md',
    'specs/optional/readme.md',
    'specs/optional/bootstrap-personalizar-projeto.md',
    'specs/optional/software-multi-produto.md',
    'references/readme.md',
    'scripts/readme.md',
    'scripts/bootstrap/readme.md',
    'scripts/validation/readme.md',
    'scripts/validation/validate-structure.sh',
    'scripts/validation/validate-structure.ps1',
    'scripts/automation/readme.md',
    'scripts/maintenance/readme.md',
    'reports/readme.md',
    'prompts/readme.md',
    'prompts/so-investigar.md',
    'prompts/revisar-diff.md',
    'prompts/fechar-sessao-handoff.md',
    'prompts/validar-estrutura.md',
    'resources/readme.md',
    'resources/downloads/.gitkeep',
    'core/readme.md'
)

function Write-Cyan([string]$Text) {
    Write-Host $Text -ForegroundColor Cyan
}

function Write-Header {
    param([string]$Mode)
    if (-not $Quiet -and -not $Ssh -and $Host.UI.SupportsVirtualTerminal) {
        Clear-Host
    }
    $src = $Script:SourceRoot
    $dst = $Script:TargetRoot
    if ($src.Length -gt 48) { $src = '...' + $src.Substring($src.Length - 45) }
    if ($dst.Length -gt 48) { $dst = '...' + $dst.Substring($dst.Length - 45) }
    Write-Cyan '╔══════════════════════════════════════════════════════════╗'
    Write-Cyan '║ Projeto : cursor-template                                ║'
    Write-Cyan ("║ Versão  : {0,-48} ║" -f $Script:Version)
    Write-Cyan ("║ Data    : {0,-48} ║" -f (Get-Date -Format 'yyyy-MM-dd HH:mm'))
    Write-Cyan ("║ Função  : scaffold-repo ({0,-37}) ║" -f $Mode)
    Write-Cyan '╠══════════════════════════════════════════════════════════╣'
    Write-Cyan ("║ Source  : {0,-48} ║" -f $src)
    Write-Cyan ("║ Target  : {0,-48} ║" -f $dst)
    Write-Cyan '╚══════════════════════════════════════════════════════════╝'
    Write-Host ''
}

function Show-Usage {
    @"
Uso: scaffold-repo.ps1 [-Destination <pasta>] [-Uninstall] [-Quiet] [-Force] [-Ssh] [-Log <arquivo>] [-Help]

Materializa (ou remove) a árvore canônica do template Cursor.
Scripts na RAIZ do template — pasta vazia ainda não tem scripts/.

  -Destination / -Target   Pasta destino (default: diretório atual)
  -Uninstall               Remove apenas o que o manifest registra
  -Quiet / -q              Sem prompts; assume defaults
  -Force / -f              Autoriza sobrescrever / uninstall destrutivo com -Quiet/-Ssh
  -Ssh                     Modo agente; exige -Destination e -Log
  -Log                     Espelha saída no arquivo
  -Help                    Ajuda

Fonte = pasta deste script (deve conter spec-project-bootstrap.md).
"@
}

function Write-LogLine([string]$Line) {
    if ($Log) {
        Add-Content -LiteralPath $Log -Value $Line -Encoding utf8
    }
}

function Out-Info([string]$Msg) {
    Write-Host $Msg
    Write-LogLine $Msg
}

function Ask-YesNo([string]$Prompt, [int]$Default = 0) {
    if ($Quiet -or $Ssh) { return $Default -eq 1 }
    while ($true) {
        Write-Host $Prompt
        Write-Host '  0 = não (default)'
        Write-Host '  1 = sim'
        $raw = Read-Host 'Escolha'
        if ([string]::IsNullOrWhiteSpace($raw)) { return $Default -eq 1 }
        if ($raw -eq '0') { return $false }
        if ($raw -eq '1') { return $true }
        Write-Host 'WARN: entrada inválida; digite 0 ou 1.'
    }
}

function Assert-Source {
    $marker = Join-Path $Script:SourceRoot 'spec-project-bootstrap.md'
    if (-not (Test-Path -LiteralPath $marker -PathType Leaf)) {
        throw "FAIL: fonte inválida (falta spec-project-bootstrap.md em $($Script:SourceRoot))"
    }
}

function Get-ManifestPath {
    Join-Path $Script:TargetRoot $Script:ManifestName
}

function Write-FreshPromptStatus([string]$Path) {
    @(
        '# .prompt-status'
        '# Rastreamento mínimo de prompts do Cursor AI.'
        '# Formato: chave = valor'
        '#'
        'current_prompt_number = 0'
        'current_prompt_start_time = 1970-01-01T00:00:00Z'
    ) | Set-Content -LiteralPath $Path -Encoding utf8
}

function Install-Scaffold {
    Assert-Source
    if ($Ssh) {
        if ([string]::IsNullOrWhiteSpace($Destination)) { throw 'FAIL: -Ssh exige -Destination' }
        if ([string]::IsNullOrWhiteSpace($Log)) { throw 'FAIL: -Ssh exige -Log' }
    }

    $srcFull = [System.IO.Path]::GetFullPath($Script:SourceRoot)
    $dstFull = [System.IO.Path]::GetFullPath($Script:TargetRoot)
    if ($srcFull -eq $dstFull) {
        throw 'FAIL: destino não pode ser a própria pasta fonte do template. Use -Destination <nova-pasta>.'
    }

    if (-not (Test-Path -LiteralPath $Script:TargetRoot)) {
        New-Item -ItemType Directory -Path $Script:TargetRoot | Out-Null
        Out-Info "OK   dir   (criado) $Script:TargetRoot"
    }

    $existing = @(Get-ChildItem -LiteralPath $Script:TargetRoot -Force | Where-Object { $_.Name -ne $Script:ManifestName })
    if ($existing.Count -gt 0) {
        $ok = Ask-YesNo 'Destino não está vazio. Sobrescrever arquivos da lista canônica?' 0
        if (-not $ok) {
            if ($Quiet -or $Ssh) {
                if (-not $Force) { throw 'FAIL: destino não vazio; use -Force com -Quiet/-Ssh para sobrescrever' }
            }
            else {
                Out-Info 'SKIP: abortado pelo operador.'
                return
            }
        }
        elseif (($Quiet -or $Ssh) -and -not $Force) {
            throw 'FAIL: sobrescrita em modo Quiet/Ssh exige -Force'
        }
    }

    $created = New-Object System.Collections.Generic.List[string]
    foreach ($rel in $Script:FileList) {
        $from = Join-Path $Script:SourceRoot ($rel -replace '/', [IO.Path]::DirectorySeparatorChar)
        $to = Join-Path $Script:TargetRoot ($rel -replace '/', [IO.Path]::DirectorySeparatorChar)
        if (-not (Test-Path -LiteralPath $from -PathType Leaf)) {
            throw "FAIL: arquivo fonte ausente: $rel"
        }
        $parent = Split-Path -Parent $to
        if (-not (Test-Path -LiteralPath $parent)) {
            New-Item -ItemType Directory -Path $parent -Force | Out-Null
        }
        if ($rel -eq '.prompt-status') {
            Write-FreshPromptStatus -Path $to
        }
        else {
            Copy-Item -LiteralPath $from -Destination $to -Force
        }
        $created.Add($rel)
        Out-Info "OK   file  $rel"
    }

    $manifestPath = Get-ManifestPath
    (@('# scaffold-manifest', '# paths relative to repo root') + $created) |
        Set-Content -LiteralPath $manifestPath -Encoding utf8
    Out-Info "OK   file  $($Script:ManifestName)"
    Out-Info ''
    Out-Info 'OK: scaffold concluído. Próximo: personalizar via specs/optional/bootstrap-personalizar-projeto.md'
    Out-Info '     Validar: .\scripts\validation\validate-structure.ps1'
}

function Uninstall-Scaffold {
    $manifestPath = Get-ManifestPath
    if (-not (Test-Path -LiteralPath $manifestPath -PathType Leaf)) {
        throw "FAIL: manifest não encontrado ($($Script:ManifestName)); nada a desinstalar com segurança"
    }
    if (($Quiet -or $Ssh) -and -not $Force) {
        throw 'FAIL: -Uninstall com -Quiet/-Ssh exige -Force'
    }
    $ok = Ask-YesNo 'Remover arquivos listados no manifest (somente o que o scaffold criou)?' 0
    if (-not $ok -and -not (($Quiet -or $Ssh) -and $Force)) {
        Out-Info 'SKIP: uninstall abortado.'
        return
    }

    $lines = Get-Content -LiteralPath $manifestPath | Where-Object { $_ -and ($_ -notmatch '^\s*#') }
    foreach ($rel in ($lines | Sort-Object -Descending)) {
        $path = Join-Path $Script:TargetRoot ($rel -replace '/', [IO.Path]::DirectorySeparatorChar)
        if (Test-Path -LiteralPath $path -PathType Leaf) {
            Remove-Item -LiteralPath $path -Force
            Out-Info "OK   del   $rel"
        }
        else {
            Out-Info "SKIP missing $rel"
        }
    }

    # remove empty dirs bottom-up (best effort)
    $dirs = $lines | ForEach-Object {
        $d = Split-Path -Parent ($_ -replace '/', '\')
        while (-not [string]::IsNullOrWhiteSpace($d)) {
            $d
            $d = Split-Path -Parent $d
        }
    } | Select-Object -Unique | Sort-Object -Descending
    foreach ($d in $dirs) {
        $full = Join-Path $Script:TargetRoot $d
        if ((Test-Path -LiteralPath $full -PathType Container) -and -not (Get-ChildItem -LiteralPath $full -Force | Select-Object -First 1)) {
            Remove-Item -LiteralPath $full -Force
            Out-Info "OK   rmdir $d"
        }
    }

    Remove-Item -LiteralPath $manifestPath -Force
    Out-Info "OK   del   $($Script:ManifestName)"

    # limpar pastas vazias restantes na raiz do destino
    Get-ChildItem -LiteralPath $Script:TargetRoot -Directory -Force -ErrorAction SilentlyContinue |
        ForEach-Object {
            if (-not (Get-ChildItem -LiteralPath $_.FullName -Force -Recurse -File -ErrorAction SilentlyContinue | Select-Object -First 1)) {
                Remove-Item -LiteralPath $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
                Out-Info ("OK   rmdir {0}" -f $_.Name)
            }
        }

    Out-Info 'OK: uninstall concluído.'
}

try {
    if ($Help) { Show-Usage; exit 0 }
    if ($Log) {
        $logDir = Split-Path -Parent $Log
        if ($logDir -and -not (Test-Path -LiteralPath $logDir)) {
            New-Item -ItemType Directory -Path $logDir -Force | Out-Null
        }
    }
    $mode = if ($Uninstall) { 'uninstall' } else { 'install' }
    Write-Header -Mode $mode
    if ($Uninstall) { Uninstall-Scaffold } else { Install-Scaffold }
    exit 0
}
catch {
    Write-Error $_.Exception.Message
    Write-LogLine ("ERROR: " + $_.Exception.Message)
    exit 1
}
