Copy-Item -Force .\Build\cpuram.mif .\Simulador\Versao_05_2013\32_bits\cpuram.mif
Copy-Item -Force .\Build\charmap.mif .\Simulador\Versao_05_2013\32_bits\charmap.mif
Push-Location
Set-Location .\Simulador\Versao_05_2013\32_bits\
.\simulador_Atual.exe cpuram.mif charmap.mif
Pop-Location