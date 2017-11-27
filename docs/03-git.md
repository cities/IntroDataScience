# Version Control with Git

## Readings

- [Happy Git and GitHub for the useR](http://happygitwithr.com/)

## Install Git {#install-git}

### For windows
1. Download the Git for Windows installer.
1. Run the installer and follow the steps bellow:
    1. Click on "Next".
    1. Click on "Next".
    1. Keep "**Use Git from the Windows Command Prompt**" selected and click on "Next". If you forgot to do this, rerun the installer and select the appropriate option.
    1. Click on "Next".
    1. Keep "**Checkout Windows-style, commit Unix-style line endings**" selected and click on "Next".
    1. Keep "**Use Windows' default console window**" selected and click on "Next".
    1. Click on "Install".
    1. Click on "Finish".
1. If your "HOME" environment variable is not set (or you don't know what this is):
    1. Open command prompt (Open Start Menu then type cmd and press [Enter])
    1. Type the following line into the command prompt window exactly as shown:
         `setx HOME "%USERPROFILE%"`
    1. Press [Enter], you should see `SUCCESS: Specified value was saved`.
    1. Quit command prompt by typing exit then pressing [Enter]

### For Mac 
Install [git-osx-installer](https://sourceforge.net/projects/git-osx-installer/files/).

### For Linux 
install `git' from your distro's package manager.

## Lesson
Adapted from [Version Control with Git by Software Carpentry](http://swcarpentry.github.io/git-novice/).

- [A quick overview of Version Control](http://swcarpentry.github.io/git-novice/01-basics/)
- Start off by registering a github account at https://github.com
- Use your github user name and email to config git. Open a Shell/Command line window from RStudio menu **Tools/Shell...**, and modify and run the following commands:

```r
git config --global user.name "Liming Wang"
git config --global user.email "lmwang@gmail.com"
git config --global color.ui "auto"
```

- [Cache credentials](http://happygitwithr.com/credential-caching.html)
- [Collaborating](http://swcarpentry.github.io/git-novice/08-collab/)
- [Conflicts](http://swcarpentry.github.io/git-novice/09-conflict/)
- [Review of common git commands](http://happygitwithr.com/usage-git-cmds.html)

## Exercise
1. Set up your git installation for use with GitHub; 
2. Turn the RStudio project you have been working on into a git repository; 
3. Commit it to github by following these steps: http://happygitwithr.com/existing-github-last.html.

## Learning more
1. [Try Git](https://try.github.io)
1. [Pro Git](https://git-scm.com/book/en/v2), a book by Scott Chacon and Ben Straub
