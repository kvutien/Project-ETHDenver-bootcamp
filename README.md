# Project-ETHDenver-bootcamp
Notes, homework, development for the Solidity bootcamp of ETHDenver, run by Encode.club

# Preparation
## Check version of tools
* I'm on a Macbook Pro M1 chip, running macOS Monterey 12.6.
* Update Hardhat, Solidity, VSCode (1.71.2), NodeJS, git (2.15.1). I might need to update my git with my Homebrew.
## Use the Notion pages of Encode.club
This section of Notion hosts all courseware: https://encodeclub.notion.site/ETHDenver-Bootcamp-e895531f5e4540278ab4bde62e1aac0a
## Prepare Github
Open Github. Login to my account. Go to tab "Repositories". Click on button "New".

I create a Github repo "Project-ETHDenver-bootcamp". It is Public by default. I use a default `.gitignore` for VisualStudio but will change depending on each folder. I use the MIT license. 

I clone the repo locally in my hard disk to ease development.
* Open my Github repo in github's web site: https://github.com/kvutien/Project-ETHDenver-bootcamp
* In this repository, click the button "Code", copy the link
* In my PC console ("Terminal" for MacOS) go to the desired folder on my disk, for example:
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
# Locally change, save, merge and push back to the remote git
Make the changes save, test, commit and push to your own Github repository. List of commands:
  ```
  git status
  git add -A
  git commit -m "what changes you did"
  git checkout main
  git merge <your branch>
  git push
  ```
  Practical example (long)
  
*  Check git status
  ```
  kvutien@MBP21VTK Project-ETHDenver-bootcamp % git status
  On branch VTK
  Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git checkout -- <file>..." to discard changes in working directory)
    
	modified:   README.md

  Untracked files:
    (use "git add <file>..." to include in what will be committed)
    
    session_1/
    
    no changes added to commit (use "git add" and/or "git commit -a")
  ```
*  Add the changes and commit locally

  ```
  kvutien@MBP21VTK Project-ETHDenver-bootcamp % git add -A
  kvutien@MBP21VTK Project-ETHDenver-bootcamp % git commit -m  "session 1"
  [VTK 1fede1e] session 1
   4 files changed, 73 insertions(+)
    create mode 100644 session_1/20221018 ETH Denver S1 homework.png
    create mode 100644 session_1/20221018 ETH Denver S1 homework.pptx
    create mode 100644 session_1/README_1.md
  ```
*  Switch the the branch `main`

  ```
    kvutien@MBP21VTK Project-ETHDenver-bootcamp % git checkout main
    Switched to branch 'main'
    Your branch is up to date with 'origin/main'.
  ```
*  Merge locally the branch VTK with the branch `main`

  ```
  kvutien@MBP21VTK Project-ETHDenver-bootcamp % git merge VTK
  Updating 2423751..1fede1e
  Fast-forward
    README.md                                      |  49 ++++++++++++++++++++++++++++++++++++++++++++++++
    session_1/20221018 ETH Denver S1 homework.png  | Bin 0 -> 307878 bytes
    session_1/20221018 ETH Denver S1 homework.pptx | Bin 0 -> 510727 bytes
    session_1/README_1.md                          |  24 ++++++++++++++++++++++++
    4 files changed, 73 insertions(+)
    create mode 100644 session_1/20221018 ETH Denver S1 homework.png
    create mode 100644 session_1/20221018 ETH Denver S1 homework.pptx
    create mode 100644 session_1/README_1.md
  ```
*  Push the local git to the Github repo
  ```
  kvutien@MBP21VTK Project-ETHDenver-bootcamp % git push 
  Counting objects: 7, done.
  Delta compression using up to 10 threads.
  Compressing objects: 100% (7/7), done.
  Writing objects: 100% (7/7), 780.64 KiB | 28.91 MiB/s, done.
  Total 7 (delta 0), reused 0 (delta 0)
  To https://github.com/kvutien/Project-ETHDenver-bootcamp.git
     2423751..1fede1e  main -> main
  ```

# Session 1, 17 Oct 2022
See [corresponding folder](https://github.com/kvutien/Project-ETHDenver-bootcamp/tree/main/session_1/README_1.md)
# Session 2, 18 Oct 2022
See [corresponding folder](https://github.com/kvutien/Project-ETHDenver-bootcamp/tree/main/session_2/README_2.md)
# Session 3, 19 Oct 2022
See [corresponding folder](https://github.com/kvutien/Project-ETHDenver-bootcamp/tree/main/session_3/README_3.md)
# Session 4, 20 Oct 2022
See [corresponding folder](https://github.com/kvutien/Project-ETHDenver-bootcamp/tree/main/session_4/README_4.md)
# Session 5, 24 Oct 2022
See [corresponding folder](https://github.com/kvutien/Project-ETHDenver-bootcamp/tree/main/session_5/README_5.md)
