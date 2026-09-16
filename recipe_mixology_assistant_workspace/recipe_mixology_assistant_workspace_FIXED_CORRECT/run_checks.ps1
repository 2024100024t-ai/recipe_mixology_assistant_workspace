$ErrorActionPreference = 'Stop'

Write-Host 'Running dependency resolution...' -ForegroundColor Cyan
dart pub get

Write-Host 'Formatting...' -ForegroundColor Cyan
dart format .

Write-Host 'Analyzing...' -ForegroundColor Cyan
dart analyze

Write-Host 'Testing...' -ForegroundColor Cyan
dart test

Write-Host 'ALL CHECKS PASSED.' -ForegroundColor Green
