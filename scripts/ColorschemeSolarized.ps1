cd $ENV:TMP
git clone https://github.com/neilpa/cmd-colors-solarized.git
cd .\cmd-colors-solarized\
regedit /s .\solarized-light.reg
cd ..
rm -Recurse -Force .\cmd-colors-solarized