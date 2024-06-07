@echo off
set /p ver="Version?: "
echo Uploading %ver%...
set user=yellowafterlife
set ext=gamemaker-sprite-add-gif
cmd /C itchio-butler push "GifHx.gml" %user%/%ext%:gml --userversion=%ver%
cmd /C itchio-butler push "sprite_add_gif.html" %user%/%ext%:docs --userversion=%ver%
cmd /C itchio-butler push "sprite_add_gif_demo.zip" %user%/%ext%:demo --userversion=%ver%
cmd /C itchio-butler push "sprite_add_gif_demo.yyz" %user%/%ext%:demo_src --userversion=%ver%
cmd /C itchio-butler push "sprite_add_gif_gms1.gmz" %user%/%ext%:gms1 --userversion=%ver%

pause