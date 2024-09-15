pacman -Syu
clear
pacman -Su
pacman -Ss gcc
pacman -S mingw-w64-x86_64-gcc
clear
gcc --version
g++ --version
clear
pacman -Ss gdb
pacman -S mingw-w64-x86_64-gdb
gdb --version
clear
neofetch
python --version
pacman -Qs python
pacman -S mingw-w64-x86_64-python
python --version
pacman -R mingw-w64-x86_64-python
clear
