@echo off

copy ..\sprite_add_gif\scripts\GifHx\GifHx.gml GifHx.gml

del /Q sprite_add_gif_demo.yyz
cd ..\sprite_add_gif
cmd /C 7z a ..\export\sprite_add_gif_demo_yyz.zip
cd ..\export
move sprite_add_gif_demo_yyz.zip sprite_add_gif_demo.yyz

del /Q sprite_add_gif_gms1.gmz
cd ..\sprite_add_gif_gms1.gmx
cmd /C 7z a ..\export\sprite_add_gif_gms1.7z
cmd /C 7z d ..\export\sprite_add_gif_gms1.7z Configs/Default
cd ..\export
move sprite_add_gif_gms1.7z sprite_add_gif_gms1.gmz

pause