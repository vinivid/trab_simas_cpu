Set-Location .\jogo_asm
py .\include.py .\SimasBomber.asm ..\Build\tudo.asm
Set-Location ..
.\Simulador\Versao_05_2013\32_bits\Montador.exe .\Build\tudo.asm .\Build\CPURAM.MIF
Copy-Item -Force .\jogo_asm\charmap.mif .\Build\charmap.mif
Copy-Item -Force .\Build\charmap.mif .\cpu\CPURAM.mif
Copy-Item -Force .\Build\charmap.mif .\cpu\charmap.mif