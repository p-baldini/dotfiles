# Automatic setup
`sudo dnf install -y make`<br>
In home directory:<br>
`git init`<br>
`git remote add origin https://github.com/Mandrab/dotfiles`<br>
`git fetch --all`<br>
`git checkout origin/BRANCH_NAME`<br>
`sudo make install HOME=$HOME` this allow to find user 'homedir' also if the executing user is root
