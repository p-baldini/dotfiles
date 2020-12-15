# Automatic setup
`sudo dnf install -y make`<br>
In home directory:<br>
`git init`<br>
`git remote add origin https://github.com/Mandrab/dotfiles`<br>
`git fetch --all`<br>
`git checkout -t origin/BRANCH_NAME`<br>
`make install` do not use 'sudo' bacause it will prevent access to user vars (e.g. HOME)
