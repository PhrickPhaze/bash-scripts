#!/bin/bash
cd $HOME/bash-scripts
echo -n "What do you want to name the file? "
read file
touch $file
chmod +x $file
echo "#!/bin/bash" > $file
echo "File '$file' has been created, and is ready to be used!"
