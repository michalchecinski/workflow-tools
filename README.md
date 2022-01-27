# Workflow Tools and Configs

This is a collection of tools and configs to ease my devlopment workflow and/or
my tech workflow.

## 0. bin - A collection of useful scripts

### `dotfiles`
#### Installation
```
download_url=$(curl -s https://api.github.com/repos/joseph-flinn/workflow-tools/releases/latest | jq -r '.assets[] | select( .name == "dotfiles").browser_download_url')
curl -s -L $download_url > /usr/local/bin/dotfiles
chmod +x /usr/local/bin/dotfiles
```

## 1. .tmuxp - I have always been interested in aliases for different tasks that
I do a lot. However, early on in my career, aliases were one of factors in me
deleting a website from production. Since then, they have left a bad taste in my
mouth. Recently I have wanted to have directory specific aliases so that there 
would be protection against running commands on a global scale. The 
[funky](https://github.com/bbugyi200/funky) project could be a good way to do so,
however, I am not sold on the idea as of yet (maybe if I look into is more in the 
future). Really, with my little knowledge of build systems, I may just be after a
language agnostic build system framework. I really don't know.

In light of this need, because I use tmuxp, I disovered a way to add in local 
aliases to the tmuxp sessions that I am using. This folder is the file structure
that I use to do so. 

Dependencies:
- tmux
- [tmuxp](https://github.com/tmux-python/tmuxp)

To deploy, copy this .tmuxp folder into the project and add
the following to your `.bash_profile` or `.bashrc` (change accordingly for other
shells):
```
function mtmx () {
  if [ $1 ]; then
    echo "params: $#"
    echo "file: $1"
  else
    tmuxp load .tmuxp/
  fi
}
```

Any shell script that is added to `.tmuxp/bin` will now be an executable in your
tmuxp session as long as it is an executable. Honestly, this is still a work in 
progress. I would like to make this more generic since it is currently very project 
specific. I will contiune to update it as a have more ideas.

**Update:** any script that is added to the `~/workflow-tools/bin` directory, while 
using the included dotfiles, is available via the PATH


--- 

#### Future Work

I am still looking for that perfect computer-agnostic development environment 
that is hopefully decoupled from the internet (or at least can be). As much as
I would like to use containers, I still have not settled on the best design and
will probably get a cloud-based VM up and running. The thought here is that
development is normally tightly coupled with the internet (I constantly search 
for answers to questions).

Update [2021-08-15]: Codespaces looks interesting.
