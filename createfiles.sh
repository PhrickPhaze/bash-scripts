#!/bin/bash

#This script is simply to create new files, add the appropirate permissions and add the shebang in the beginning of the file.
cd $HOME/bash-scripts
echo -n "What do you want to name the file? "
read file
touch $file
chmod +x $file
echo "#!/bin/bash" > $file
echo "File '$file' has been created, and is ready to be used!"
