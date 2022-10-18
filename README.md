# Project-ETHDenver-bootcamp
Notes, homework, development for the Solidity bootcamp of ETHDenver, run by Encode.club

# Preparation
## Check version of tools
* I'm on a Macbook Pro M1 chip, running macOS Monterey 12.6.
* Update Hardhat, Solidity, VSCode (')1.71.2), NodeJS.
## Prepare Github
Open Github. Login to my account. Go to tab "Repositories". Click on button "New".

I create a Github repo "Project-ETHDenver-bootcamp". It is Public by default. The default `.gitignore` is for VisualStudio and will be changed depending on each folder. The license it MIT. 

I clone the repo locally in my hard disk to ease development.
* Open my Github repo in github's web site: https://github.com/kvutien/Project-ETHDenver-bootcamp
* In this repository, click the button "Code", copy the link
* •	In my PC console ("Terminal" for MacOS) go to the desired folder on my disk, for example:
  ```
  kvutien@MBP21VTK ~ % cd /Users/kvutien/develop/hackhathons/ETHDenver_2022\ bootcamp/Bootcamp_repo
  ```
* Clone the repo, for example
  ```
  kvutien@MBP21VTK Bootcamp_repo % git clone https://github.com/kvutien/Project-ETHDenver-bootcamp.git
  Cloning into 'Project-ETHDenver-bootcamp'...
  remote: Enumerating objects: 5, done.
  remote: Counting objects: 100% (5/5), done.
  remote: Compressing objects: 100% (5/5), done.
  remote: Total 5 (delta 0), reused 0 (delta 0), pack-reused 0
  Unpacking objects: 100% (5/5), done.
  ```
* `cd` to the new cloned folder
* Eventually, make a working branch if you are cooperating in a team on the repo. For this, type
  ```
  kvutien@MBP21VTK Bootcamp_repo % cd Project-ETHDenver-bootcamp
  kvutien@MBP21VTK Project-ETHDenver-bootcamp % git checkout -b VTK
  Switched to a new branch 'VTK'

  ```
* Launch VSCode on this repo, for example
  ```
  kvutien@MBP21VTK Project-ETHDenver-bootcamp % code .
  ```
* Make the changes save, test, commit and push to your own Github repository
  ```
  git status
  git add -A
  git commit -m "what changes you did"
  git push origin main

  ```
# Session 1, 17 Oct 2022
See corresponding folder