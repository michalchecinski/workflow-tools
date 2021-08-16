# Workflow Tools and Configs

This is a collection of tools and configs to ease my devlopment workflow and/or
my tech workflow.

## 0. bin - A collection of useful scripts

### `dotfiles`
#### Installation
```
curl -L https://github.com/joseph-flinn/workflow-tools/releases/download/latest/dotfiles > /usr/local/bin/dotfiles
chmod +x /usr/local/bin
```

## 1. docker - I have a dream of being computer agnostic when it comes to my
development environment. I switch between multiple computers on a weekly basis; 
a powerful workstation with multiple monitors at home or work and a thin sleek
long-battery-life laptop on the move. I would like to seemlessly switch between
these and any other computers that I would like. I currently have two ideas on 
how to make this a reality. The first is using a cloud based VM (which I am 
essentially doing the same thing now with a local server) which could have a 
suite of tools surrounding it to minimize cost (I don't develop while I sleep. 
Why should I pay for that compute time?). However, with the adoption of 
containerization, anything that can be run in a VM can be run in a container. 
I'm not sure if docker is the right tool with the decision to design their 
containers around a single process, but this is the current attempt using 
docker. I have not adopted it fully as it still has some work that needs to be 
done (Do I use dind to control the local docker instance from inside the DevEnv 
container? If not set up correctly, does this lead to a security risk? Am I ok 
with the security risk? Will I be using this in an environment that cannot have 
security risks?). Maybe LXD is the way to go? This should be compatible with all
Linux computers/servers (maybe even chromebooks some day?).

Cloud based VM:
- Could provide a powerful computer environment for a thin not-powerful laptop
- Always needs to be connected to the internet
- Could experience connection lag depending on local network (coffee shop)
- Security concerns connecting from public networks (solution: VPN, but lag)

Container:
- Theoretically, performance grows with the machine it is on if resources are
not limited by the orchestrator.
- Theoretically does everything a VM does with less overhead
- Decouples DevEnv from the internet if desired

Thoughts: Create a LXD container with vim and tmuxp as the dev environment that
connects to a remote docker cluster (swarm or machine?) to run any other 
development containers (ex. run a python container on the docker cluster if
developing in python and run the scripts in the container. Could use aliases if
absolutely necessary for faster program execution `dpython3 hello.py` instead of 
`docker run --rm -it python:3.7.5-slim-buster python hello.py`)

## 2. .tmuxp - I have always been interested in aliases for different tasks that
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
