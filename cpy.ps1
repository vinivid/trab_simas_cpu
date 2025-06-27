Set-Location .\jogo_asm
py .\include.py .\SimasBomber.asm ..\Build\tudo.asm
Set-Location ..
.\Simulador\Versao_05_2013\32_bits\Montador.exe .\Build\tudo.asm .\Build\cpuram.mif
Copy-Item -Force .\Build\tudo.asm .\Simulador\Hello4.asm
Copy-Item -Force .\jogo_asm\charmap.mif .\Build\charmap.mif
Copy-Item -Force .\Build\cpuram.mif .\cpu\cpuram.mif
Copy-Item -Force .\Build\charmap.mif .\cpu\charmap.mif