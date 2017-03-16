---
title: Version Control with Gits
teaching: 5
exercises: 0
questions:
- "What is version control and why should I use it?"
objectives:
- "Understand the benefits of an automated version control system."
- "Understand the basics of how Git works."
keypoints:
- "Version control is like an unlimited 'undo'."
- "Version control also allows many people to work in parallel."
---

# Version Control with Git

This section has been adapted from Software Carpentry lesson [Version Control with Git](http://swcarpentry.github.io/git-novice/).

## Readings

1. Software Carpentry [Version Control with Git](http://swcarpentry.github.io/git-novice/).
1. Hadley Wickham [Git and Github](http://r-pkgs.had.co.nz/git.html)

## Introduction

We'll start by exploring how version control can be used
to keep track of what one person did and when.
Even if you aren't collaborating with other people,
automated version control is much better than this situation:

[![Piled Higher and Deeper by Jorge Cham, http://www.phdcomics.com/comics/archive_print.php?comicid=1531](fig/phd101212s.png)](http://www.phdcomics.com)

"Piled Higher and Deeper" by Jorge Cham, http://www.phdcomics.com

We've all been in this situation before: it seems ridiculous to have
multiple nearly-identical versions of the same document. Some word
processors let us deal with this a little better, such as Microsoft
Word's [Track Changes](https://support.office.com/en-us/article/Track-changes-in-Word-197ba630-0f5f-4a8e-9a77-3712475e806a) or Google Docs' [version
history](https://support.google.com/docs/answer/190843?hl=en).

Version control systems start with a base version of the document and
then save just the changes you made at each step of the way. You can
think of it as a tape: if you rewind the tape and start at the base
document, then you can play back each change and end up with your
latest version.

![Changes Are Saved Sequentially](fig/play-changes.svg)

Once you think of changes as separate from the document itself, you
can then think about "playing back" different sets of changes onto the
base document and getting different versions of the document. For
example, two users can make independent sets of changes based on the
same document.

![Different Versions Can be Saved](fig/versions.svg)

If there aren't conflicts, you can even play two sets of changes onto the same base document.

![Multiple Versions Can be Merged](fig/merge.svg)

A version control system is a tool that keeps track of these changes for us and
helps us version and merge our files. It allows you to
decide which changes make up the next version, called a
[commit]({{ page.root }}/reference/#commit), and keeps useful metadata about them. The
complete history of commits for a particular project and their metadata make up
a [repository]({{ page.root }}/reference/#repository). Repositories can be kept in sync
across different computers facilitating collaboration among different people.

> **The Long History of Version Control Systems**
>
> Automated version control systems are nothing new.
> Tools like RCS, CVS, or Subversion have been around since the early 1980s and are used by many large companies.
> However, many of these are now becoming considered as legacy systems due to various limitations in their capabilities.
> In particular, the more modern systems, such as Git and [Mercurial](http://swcarpentry.github.io/hg-novice/)
> are *distributed*, meaning that they do not need a centralized server to host the repository.
> These modern systems also include powerful merging tools that make it possible for multiple authors to work within
> the same files concurrently.


> **Paper Writing**
>
> *   Imagine you drafted an excellent paragraph for a paper you are writing, but later ruin it. How would you retrieve
>     the *excellent* version of your conclusion? Is it even possible?
>
> *   Imagine you have 5 co-authors. How would you manage the changes and comments they make to your paper?
>     If you use LibreOffice Writer or Microsoft Word, what happens if you accept changes made using the
>     `Track Changes` option? Do you have a history of those changes?



## Setting up Git

When we use Git on a new computer for the first time,
we need to configure a few things. Below are a few examples
of configurations we will set as we get started with Git:

*   our name and email address,
*   to colorize our output,
*   what our preferred text editor is,
*   and that we want to use these settings globally (i.e. for every project)

On a command line, Git commands are written as `git verb`,
where `verb` is what we actually want to do. So here is how
Dracula sets up his new laptop:

```
$ git config --global user.name "Vlad Dracula"
$ git config --global user.email "vlad@tran.sylvan.ia"
$ git config --global color.ui "auto"
```


Please use your own name and email address instead of Dracula's.
This user name and email will be associated with your subsequent Git activity,
which means that any changes pushed to
[GitHub](http://github.com/),
[BitBucket](http://bitbucket.org/),
[GitLab](http://gitlab.com/) or
another Git host server
in a later lesson will include this information.
If you are concerned about privacy, please review [GitHub's instructions for keeping your email address private][git-privacy].

He also has to set his favorite text editor, following this table:

| Editor             | Configuration command                            |
|:-------------------|:-------------------------------------------------|
|Atom | `$ git config --global core.editor "atom --wait"`|
| nano               | `$ git config --global core.editor "nano -w"`    |
| Text Wrangler (Mac)      | `$ git config --global core.editor "edit -w"`    |
| Sublime Text (Mac) | `$ git config --global core.editor "subl -n -w"` |
| Sublime Text (Win, 32-bit install) | `$ git config --global core.editor "'c:/program files (x86)/sublime text 3/sublime_text.exe' -w"` |
| Sublime Text (Win, 64-bit install) | `$ git config --global core.editor "'c:/program files/sublime text 3/sublime_text.exe' -w"` |
| Notepad++ (Win, 32-bit install)    | `$ git config --global core.editor "'c:/program files (x86)/Notepad++/notepad++.exe' -multiInst -notabbar -nosession -noPlugin"`|
| Notepad++ (Win, 64-bit install)    | `$ git config --global core.editor "'c:/program files/Notepad++/notepad++.exe' -multiInst -notabbar -nosession -noPlugin"`|
| Kate (Linux)       | `$ git config --global core.editor "kate"`       |
| Gedit (Linux)      | `$ git config --global core.editor "gedit --wait --new-window"`   |
| Scratch (Linux)       | `$ git config --global core.editor "scratch-text-editor"`  |
| emacs              | `$ git config --global core.editor "emacs"`   |
| vim                | `$ git config --global core.editor "vim"`   |

It is possible to reconfigure the text editor for Git whenever you want to change it.

> **Exiting Vim**
>
> Note that `vim` is the default editor for for many programs, if you haven't used `vim` before and wish to exit a session, type `Esc` then `:q!` and `Enter`.


The four commands we just ran above only need to be run once: the flag `--global` tells Git
to use the settings for every project, in your user account, on this computer.

You can check your settings at any time:

```
$ git config --list
```


You can change your configuration as many times as you want: just use the
same commands to choose another editor or update your email address.

> **Proxy**
>
> In some networks you need to use a
> [proxy](https://en.wikipedia.org/wiki/Proxy_server). If this is the case, you
> may also need to tell Git about the proxy:
>
> ```
> $ git config --global http.proxy proxy-url
> $ git config --global https.proxy proxy-url
> ```
> 
>
> To disable the proxy, use
>
> ```
> $ git config --global --unset http.proxy
> $ git config --global --unset https.proxy
> ```
> 


> **Git Help and Manual**
>
> Always remember that if you forget a git command, you can access the list of command by using -h and access the git manual by using --help :
>
> ```
> $ git config -h
> $ git config --help
> ```
> 


[git-privacy]: https://help.github.com/articles/keeping-your-email-address-private/

## Creating a Repository

Once Git is configured,
we can start using it.
Let's create a directory for our work and then move into that directory:

```
$ mkdir planets
$ cd planets
```


Then we tell Git to make `planets` a [repository]({{ page.root }}/reference/#repository)—a place where
Git can store versions of our files:

```
$ git init
```


If we use `ls` to show the directory's contents,
it appears that nothing has changed:

```
$ ls
```


But if we add the `-a` flag to show everything,
we can see that Git has created a hidden directory within `planets` called `.git`:

```
$ ls -a
```


```
.	..	.git
```


Git stores information about the project in this special sub-directory.
If we ever delete it,
we will lose the project's history.

We can check that everything is set up correctly
by asking Git to tell us the status of our project:

```
$ git status
```


```
# On branch master
#
# Initial commit
#
nothing to commit (create/copy files and use "git add" to track)
```


> **Places to Create Git Repositories**
>
> Dracula starts a new project, `moons`, related to his `planets` project.
> Despite Wolfman's concerns, he enters the following sequence of commands to
> create one Git repository inside another:
>
> ```
> $ cd             # return to home directory
> $ mkdir planets  # make a new directory planets
> $ cd planets     # go into planets
> $ git init       # make the planets directory a Git repository
> $ mkdir moons    # make a sub-directory planets/moons
> $ cd moons       # go into planets/moons
> $ git init       # make the moons sub-directory a Git repository
> ```
> 
>
> Why is it a bad idea to do this? (Notice here that the `planets` project is now also tracking the entire `moons` repository.)
> How can Dracula undo his last `git init`?
>
<!-- > > ## Solution -->
<!-- > > -->
<!-- > > Git repositories can interfere with each other if they are "nested" in the -->
<!-- > > directory of another: the outer repository will try to version-control  -->
<!-- > > the inner repository. Therefore, it's best to create each new Git -->
<!-- > > repository in a separate directory. To be sure that there is no conflicting -->
<!-- > > repository in the directory, check the output of `git status`. If it looks -->
<!-- > > like the following, you are good to go to create a new repository. -->
<!-- > > -->
<!-- > > repository as shown: -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > $ git status -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > ``` -->
<!-- > > fatal: Not a git repository (or any of the parent directories): .git -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > -->
<!-- > > Note that we can track files in directories within a Git: -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > $ touch moon phobos deimos titan    # create moon files -->
<!-- > > $ cd ..                             # return to planets directory -->
<!-- > > $ ls moons                          # list contents of the moons directory -->
<!-- > > $ git add moons/*                   # add all contents of planets/moons -->
<!-- > > $ git status                        # show moons files in staging area -->
<!-- > > $ git commit -m "add moon files"    # commit planets/moons to planets Git repository -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > -->
<!-- > > Similarly, we can ignore (as discussed later) entire directories, such as the `moons` directory: -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > $ nano .gitignore # open the .gitignore file in the texteditor to add the moons directory -->
<!-- > > $ cat .gitignore # if you run cat afterwards, it should look like this: -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > moons -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > -->
<!-- > > To recover from this little mistake, Dracula can just remove the `.git` -->
<!-- > > folder in the moons subdirectory. To do so he can run the following command from inside the 'moons' directory: -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > $ rm -rf moons/.git -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > -->
<!-- > > But be careful! Running this command in the wrong directory, will remove -->
<!-- > > the entire git-history of a project you might wanted to keep. Therefore, always check your current directory using the -->
<!-- > > command `pwd`. -->
> 


## Tracking Changes

Let's create a file called `mars.txt` that contains some notes
about the Red Planet's suitability as a base.
(We'll use `nano` to edit the file;
you can use whatever editor you like.
In particular, this does not have to be the `core.editor` you set globally earlier.)

```
$ nano mars.txt
```


Type the text below into the `mars.txt` file:

```
Cold and dry, but everything is my favorite color
```


`mars.txt` now contains a single line, which we can see by running:

```
$ ls
```


```
mars.txt
```


```
$ cat mars.txt
```


```
Cold and dry, but everything is my favorite color
```


If we check the status of our project again,
Git tells us that it's noticed the new file:

```
$ git status
```


```
On branch master

Initial commit

Untracked files:
   (use "git add <file>..." to include in what will be committed)

	mars.txt
nothing added to commit but untracked files present (use "git add" to track)
```


The "untracked files" message means that there's a file in the directory
that Git isn't keeping track of.
We can tell Git to track a file using `git add`:

```
$ git add mars.txt
```


and then check that the right thing happened:

```
$ git status
```


```
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

	new file:   mars.txt

```


Git now knows that it's supposed to keep track of `mars.txt`,
but it hasn't recorded these changes as a commit yet.
To get it to do that,
we need to run one more command:

```
$ git commit -m "Start notes on Mars as a base"
```


```
[master (root-commit) f22b25e] Start notes on Mars as a base
 1 file changed, 1 insertion(+)
 create mode 100644 mars.txt
```


When we run `git commit`,
Git takes everything we have told it to save by using `git add`
and stores a copy permanently inside the special `.git` directory.
This permanent copy is called a [commit]({{ page.root }}/reference/#commit)
(or [revision]({{ page.root }}/reference/#revision)) and its short identifier is `f22b25e`
(Your commit may have another identifier.)

We use the `-m` flag (for "message")
to record a short, descriptive, and specific comment that will help us remember later on what we did and why.
If we just run `git commit` without the `-m` option,
Git will launch `nano` (or whatever other editor we configured as `core.editor`)
so that we can write a longer message.

[Good commit messages][commit-messages] start with a brief (<50 characters) summary of
changes made in the commit.  If you want to go into more detail, add
a blank line between the summary line and your additional notes.

If we run `git status` now:

```
$ git status
```


```
On branch master
nothing to commit, working directory clean
```


it tells us everything is up to date.
If we want to know what we've done recently,
we can ask Git to show us the project's history using `git log`:

```
$ git log
```


```
commit f22b25e3233b4645dabd0d81e651fe074bd8e73b
Author: Vlad Dracula <vlad@tran.sylvan.ia>
Date:   Thu Aug 22 09:51:46 2013 -0400

    Start notes on Mars as a base
```


`git log` lists all commits  made to a repository in reverse chronological order.
The listing for each commit includes
the commit's full identifier
(which starts with the same characters as
the short identifier printed by the `git commit` command earlier),
the commit's author,
when it was created,
and the log message Git was given when the commit was created.

> **Where Are My Changes?**
>
> If we run `ls` at this point, we will still see just one file called `mars.txt`.
> That's because Git saves information about files' history
> in the special `.git` directory mentioned earlier
> so that our filesystem doesn't become cluttered
> (and so that we can't accidentally edit or delete an old version).


Now suppose Dracula adds more information to the file.
(Again, we'll edit with `nano` and then `cat` the file to show its contents;
you may use a different editor, and don't need to `cat`.)

```
$ nano mars.txt
$ cat mars.txt
```


```
Cold and dry, but everything is my favorite color
The two moons may be a problem for Wolfman
```


When we run `git status` now,
it tells us that a file it already knows about has been modified:

```
$ git status
```


```
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   mars.txt

no changes added to commit (use "git add" and/or "git commit -a")
```


The last line is the key phrase:
"no changes added to commit".
We have changed this file,
but we haven't told Git we will want to save those changes
(which we do with `git add`)
nor have we saved them (which we do with `git commit`).
So let's do that now. It is good practice to always review
our changes before saving them. We do this using `git diff`.
This shows us the differences between the current state
of the file and the most recently saved version:

```
$ git diff
```


```
diff --git a/mars.txt b/mars.txt
index df0654a..315bf3a 100644
--- a/mars.txt
+++ b/mars.txt
@@ -1 +1,2 @@
 Cold and dry, but everything is my favorite color
+The two moons may be a problem for Wolfman
```


The output is cryptic because
it is actually a series of commands for tools like editors and `patch`
telling them how to reconstruct one file given the other.
If we break it down into pieces:

1.  The first line tells us that Git is producing output similar to the Unix `diff` command
    comparing the old and new versions of the file.
2.  The second line tells exactly which versions of the file
    Git is comparing;
    `df0654a` and `315bf3a` are unique computer-generated labels for those versions.
3.  The third and fourth lines once again show the name of the file being changed.
4.  The remaining lines are the most interesting, they show us the actual differences
    and the lines on which they occur.
    In particular,
    the `+` marker in the first column shows where we added a line.

After reviewing our change, it's time to commit it:

```
$ git commit -m "Add concerns about effects of Mars' moons on Wolfman"
$ git status
```


```
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   mars.txt

no changes added to commit (use "git add" and/or "git commit -a")
```


Whoops:
Git won't commit because we didn't use `git add` first.
Let's fix that:

```
$ git add mars.txt
$ git commit -m "Add concerns about effects of Mars' moons on Wolfman"
```


```
[master 34961b1] Add concerns about effects of Mars' moons on Wolfman
 1 file changed, 1 insertion(+)
```


Git insists that we add files to the set we want to commit
before actually committing anything. This allows us to commit our
changes in stages and capture changes in logical portions rather than
only large batches.
For example,
suppose we're adding a few citations to our supervisor's work
to our thesis.
We might want to commit those additions,
and the corresponding addition to the bibliography,
but *not* commit the work we're doing on the conclusion
(which we haven't finished yet).

To allow for this,
Git has a special *staging area*
where it keeps track of things that have been added to
the current [change set]({{ page.root }}/reference/#change-set)
but not yet committed.

> **Staging Area**
>
> If you think of Git as taking snapshots of changes over the life of a project,
> `git add` specifies *what* will go in a snapshot
> (putting things in the staging area),
> and `git commit` then *actually takes* the snapshot, and
> makes a permanent record of it (as a commit).
> If you don't have anything staged when you type `git commit`,
> Git will prompt you to use `git commit -a` or `git commit --all`,
> which is kind of like gathering *everyone* for the picture!
> However, it's almost always better to
> explicitly add things to the staging area, because you might
> commit changes you forgot you made. (Going back to snapshots,
> you might get the extra with incomplete makeup walking on
> the stage for the snapshot because you used `-a`!)
> Try to stage things manually,
> or you might find yourself searching for "git undo commit" more
> than you would like!


![The Git Staging Area](fig/git-staging-area.svg)

Let's watch as our changes to a file move from our editor
to the staging area
and into long-term storage.
First,
we'll add another line to the file:

```
$ nano mars.txt
$ cat mars.txt
```


```
Cold and dry, but everything is my favorite color
The two moons may be a problem for Wolfman
But the Mummy will appreciate the lack of humidity
```


```
$ git diff
```


```
diff --git a/mars.txt b/mars.txt
index 315bf3a..b36abfd 100644
--- a/mars.txt
+++ b/mars.txt
@@ -1,2 +1,3 @@
 Cold and dry, but everything is my favorite color
 The two moons may be a problem for Wolfman
+But the Mummy will appreciate the lack of humidity
```


So far, so good:
we've added one line to the end of the file
(shown with a `+` in the first column).
Now let's put that change in the staging area
and see what `git diff` reports:

```
$ git add mars.txt
$ git diff
```


There is no output:
as far as Git can tell,
there's no difference between what it's been asked to save permanently
and what's currently in the directory.
However,
if we do this:

```
$ git diff --staged
```


```
diff --git a/mars.txt b/mars.txt
index 315bf3a..b36abfd 100644
--- a/mars.txt
+++ b/mars.txt
@@ -1,2 +1,3 @@
 Cold and dry, but everything is my favorite color
 The two moons may be a problem for Wolfman
+But the Mummy will appreciate the lack of humidity
```


it shows us the difference between
the last committed change
and what's in the staging area.
Let's save our changes:

```
$ git commit -m "Discuss concerns about Mars' climate for Mummy"
```


```
[master 005937f] Discuss concerns about Mars' climate for Mummy
 1 file changed, 1 insertion(+)
```


check our status:

```
$ git status
```


```
On branch master
nothing to commit, working directory clean
```


and look at the history of what we've done so far:

```
$ git log
```


```
commit 005937fbe2a98fb83f0ade869025dc2636b4dad5
Author: Vlad Dracula <vlad@tran.sylvan.ia>
Date:   Thu Aug 22 10:14:07 2013 -0400

    Discuss concerns about Mars' climate for Mummy

commit 34961b159c27df3b475cfe4415d94a6d1fcd064d
Author: Vlad Dracula <vlad@tran.sylvan.ia>
Date:   Thu Aug 22 10:07:21 2013 -0400

    Add concerns about effects of Mars' moons on Wolfman

commit f22b25e3233b4645dabd0d81e651fe074bd8e73b
Author: Vlad Dracula <vlad@tran.sylvan.ia>
Date:   Thu Aug 22 09:51:46 2013 -0400

    Start notes on Mars as a base
```


> **Word-based diffing**
>
> Sometimes, e.g. in the case of the text documments a line-wise
> diff is too coarse. That is where the `--color-words` option of
> `git diff` comes in very useful as it highlights the changed 
> words using colors.


> **Paging the Log**
>
> When the output of `git log` is too long to fit in your screen,
> `git` uses a program to split it into pages of the size of your screen.
> When this "pager" is called, you will notice that the last line in your
> screen is a `:`, instead of your usual prompt.
>
> *   To get out of the pager, press `q`.
> *   To move to the next page, press the space bar.
> *   To search for `some_word` in all pages, type `/some_word`
>     and navigate throught matches pressing `n`.


> **Limit Log Size**
>
> To avoid having `git log` cover your entire terminal screen, you can limit the
> number of commits that Git lists by using `-N`, where `N` is the number of
> commits that you want to view. For example, if you only want information from
> the last commit you can use:
>
> ```
> $ git log -1
> ```
> 
> 
> ```
> commit 005937fbe2a98fb83f0ade869025dc2636b4dad5
> Author: Vlad Dracula <vlad@tran.sylvan.ia>
> Date:   Thu Aug 22 10:14:07 2013 -0400
>
>    Discuss concerns about Mars' climate for Mummy
> ```
> 
>
> You can also reduce the quantity of information using the
> `--oneline` option:
>
> ```
> $ git log --oneline
> ```
> 
> ```
> * 005937f Discuss concerns about Mars' climate for Mummy
> * 34961b1 Add concerns about effects of Mars' moons on Wolfman
> * f22b25e Start notes on Mars as a base
> ```
> 
>
> You can also combine the `--oneline` options with others. One useful
> combination is:
>
> ```
> $ git log --oneline --graph --all --decorate
> ```
> 
> ```
> * 005937f Discuss concerns about Mars' climate for Mummy (HEAD, master)
> * 34961b1 Add concerns about effects of Mars' moons on Wolfman
> * f22b25e Start notes on Mars as a base
> ```
> 


> **Directories**
>
> Two important facts you should know about directories in Git.
>
> 1. Git does not track directories on their own, only files within them.
> Try it for yourself:
>
> ```
> $ mkdir directory
> $ git status
> $ git add directory
> $ git status
> ```
> 
> 
> Note, our newly created empty directory `directory` does not appear in
> the list of untracked files even if we explicitly add it (_via_ `git add`) to our
> repository. This is the reason why you will sometimes see `.gitkeep` files
> in otherwise empty directories. Unlike `.gitignore`, these files are not special
> and their sole purpose is to populate a directory so that Git adds it to
> the repository. In fact, you can name such files anything you like.
>
> 
> 2. If you create a directory in your Git repository and populate it with files,
> you can add all files in the directory at once by:
>
> ```
> git add <directory-with-files>
> ```
> 
>


To recap, when we want to add changes to our repository,
we first need to add the changed files to the staging area
(`git add`) and then commit the staged changes to the
repository (`git commit`):

![The Git Commit Workflow](fig/git-committing.svg)

> **Choosing a Commit Message**
>
> Which of the following commit messages would be most appropriate for the
> last commit made to `mars.txt`?
>
> 1. "Changes"
> 2. "Added line 'But the Mummy will appreciate the lack of humidity' to mars.txt"
> 3. "Discuss effects of Mars' climate on the Mummy"
>
<!-- > > ## Solution -->
<!-- > > Answer 1 is not descriptive enough, -->
<!-- > > and answer 2 is too descriptive and redundant, -->
<!-- > > but answer 3 is good: short but descriptive. -->
> 


> **Committing Changes to Git**
>
> Which command(s) below would save the changes of `myfile.txt`
> to my local Git repository?
>
> 1. `$ git commit -m "my recent changes"`
>
> 2. `$ git init myfile.txt`  
>    `$ git commit -m "my recent changes"`
>
> 3. `$ git add myfile.txt`  
>    `$ git commit -m "my recent changes"`
>
> 4. `$ git commit -m myfile.txt "my recent changes"`
>
<!-- > > ## Solution -->
<!-- > > -->
<!-- > > 1. Would only create a commit if files have already been staged. -->
<!-- > > 2. Would try to create a new repository. -->
<!-- > > 3. Is correct: first add the file to the staging area, then commit. -->
<!-- > > 4. Would try to commit a file "my recent changes" with the message myfile.txt. -->
> 


> **Committing Multiple Files**
>
> The staging area can hold changes from any number of files
> that you want to commit as a single snapshot.
>
> 1. Add some text to `mars.txt` noting your decision
> to consider Venus as a base
> 2. Create a new file `venus.txt` with your initial thoughts
> about Venus as a base for you and your friends
> 3. Add changes from both files to the staging area,
> and commit those changes.
>
<!-- > > ## Solution -->
<!-- > > -->
<!-- > > First we make our changes to the `mars.txt` and `venus.txt` files: -->
<!-- > > ``` -->
<!-- > > $ nano mars.txt -->
<!-- > > $ cat mars.txt -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > ``` -->
<!-- > > Maybe I should start with a base on Venus. -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > ``` -->
<!-- > > $ nano venus.txt -->
<!-- > > $ cat venus.txt -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > ``` -->
<!-- > > Venus is a nice planet and I definitely should consider it as a base. -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > Now you can add both files to the staging area. We can do that in one line: -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > $ git add mars.txt venus.txt -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > Or with multiple commands: -->
<!-- > > ``` -->
<!-- > > $ git add mars.txt -->
<!-- > > $ git add venus.txt -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > Now the files are ready to commit. You can check that using `git status`. If you are ready to commit use: -->
<!-- > > ``` -->
<!-- > > $ git commit -m "Wrote down my plans to start a base on Venus" -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > ``` -->
<!-- > > [master cc127c2] -->
<!-- > >  Wrote down my plans to start a base on venus -->
<!-- > >  2 files changed, 2 insertions(+) -->
<!-- > >  create mode 100644 venus.txt -->
<!-- > > ``` -->
<!-- > >  -->
> 


> **Author and Committer**
>
> For each of the commits you have done, Git stored your name twice.
> You are named as the author and as the committer. You can observe
> that by telling Git to show you more information about your last
> commits:
>
> ```
> $ git log --format=full
> ```
> 
>
> When commiting you can name someone else as the author:
>
> ```
> $ git commit --author="Vlad Dracula <vlad@tran.sylvan.ia>"
> ```
> 
>
> Create a new repository and create two commits: one without the
> `--author` option and one by naming a colleague of yours as the
> author. Run `git log` and `git log --format=full`. Think about ways
> how that can allow you to collaborate with your colleagues.
>
<!-- > > ## Solution -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > $ git add me.txt -->
<!-- > > $ git commit -m "Updated Vlad's bio." --author="Frank N. Stein <franky@monster.com>" -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > ``` -->
<!-- > > [master 4162a51] Updated Vlad's bio. -->
<!-- > > Author: Frank N. Stein <franky@monster.com> -->
<!-- > > 1 file changed, 2 insertions(+), 2 deletions(-) -->
<!-- > > -->
<!-- > > $ git log --format=full -->
<!-- > > commit 4162a51b273ba799a9d395dd70c45d96dba4e2ff -->
<!-- > > Author: Frank N. Stein <franky@monster.com> -->
<!-- > > Commit: Vlad Dracula <vlad@tran.sylvan.ia> -->
<!-- > > -->
<!-- > > Updated Vlad's bio. -->
<!-- > > -->
<!-- > > commit aaa3271e5e26f75f11892718e83a3e2743fab8ea -->
<!-- > > Author: Vlad Dracula <vlad@tran.sylvan.ia> -->
<!-- > > Commit: Vlad Dracula <vlad@tran.sylvan.ia> -->
<!-- > > -->
<!-- > > Vlad's initial bio. -->
<!-- > > ``` -->
<!-- > >  -->

[commit-messages]: http://chris.beams.io/posts/git-commit/

## Exploring History

As we saw in the previous lesson, we can refer to commits by their
identifiers.  You can refer to the _most recent commit_ of the working
directory by using the identifier `HEAD`.

We've been adding one line at a time to `mars.txt`, so it's easy to track our
progress by looking, so let's do that using our `HEAD`s.  Before we start,
let's make a change to `mars.txt`.

```
$ nano mars.txt
$ cat mars.txt
```


```
Cold and dry, but everything is my favorite color
The two moons may be a problem for Wolfman
But the Mummy will appreciate the lack of humidity
An ill-considered change
```


Now, let's see what we get.

```
$ git diff HEAD mars.txt
```


```
diff --git a/mars.txt b/mars.txt
index b36abfd..0848c8d 100644
--- a/mars.txt
+++ b/mars.txt
@@ -1,3 +1,4 @@
 Cold and dry, but everything is my favorite color
 The two moons may be a problem for Wolfman
 But the Mummy will appreciate the lack of humidity
+An ill-considered change.
```


which is the same as what you would get if you leave out `HEAD` (try it).  The
real goodness in all this is when you can refer to previous commits.  We do
that by adding `~1` to refer to the commit one before `HEAD`.

```
$ git diff HEAD~1 mars.txt
```


If we want to see the differences between older commits we can use `git diff`
again, but with the notation `HEAD~1`, `HEAD~2`, and so on, to refer to them:


```
$ git diff HEAD~2 mars.txt
```


```
diff --git a/mars.txt b/mars.txt
index df0654a..b36abfd 100644
--- a/mars.txt
+++ b/mars.txt
@@ -1 +1,3 @@
 Cold and dry, but everything is my favorite color
+The two moons may be a problem for Wolfman
+But the Mummy will appreciate the lack of humidity
```


We could also use `git show` which shows us what changes we made at an older commit as well as the commit message, rather than the _differences_ between a commit and our working directory that we see by using `git diff`.

```
$ git show HEAD~2 mars.txt
```


```
commit 34961b159c27df3b475cfe4415d94a6d1fcd064d
Author: Vlad Dracula <vlad@tran.sylvan.ia>
Date:   Thu Aug 22 10:07:21 2013 -0400

    Add concerns about effects of Mars' moons on Wolfman

diff --git a/mars.txt b/mars.txt
index df0654a..315bf3a 100644
--- a/mars.txt
+++ b/mars.txt
@@ -1 +1,2 @@
 Cold and dry, but everything is my favorite color
+The two moons may be a problem for Wolfman
```


In this way,
we can build up a chain of commits.
The most recent end of the chain is referred to as `HEAD`;
we can refer to previous commits using the `~` notation,
so `HEAD~1` (pronounced "head minus one")
means "the previous commit",
while `HEAD~123` goes back 123 commits from where we are now.

We can also refer to commits using
those long strings of digits and letters
that `git log` displays.
These are unique IDs for the changes,
and "unique" really does mean unique:
every change to any set of files on any computer
has a unique 40-character identifier.
Our first commit was given the ID
f22b25e3233b4645dabd0d81e651fe074bd8e73b,
so let's try this:

```
$ git diff f22b25e3233b4645dabd0d81e651fe074bd8e73b mars.txt
```


```
diff --git a/mars.txt b/mars.txt
index df0654a..b36abfd 100644
--- a/mars.txt
+++ b/mars.txt
@@ -1 +1,3 @@
 Cold and dry, but everything is my favorite color
+The two moons may be a problem for Wolfman
+But the Mummy will appreciate the lack of humidity
```


That's the right answer,
but typing out random 40-character strings is annoying,
so Git lets us use just the first few characters:

```
$ git diff f22b25e mars.txt
```


```
diff --git a/mars.txt b/mars.txt
index df0654a..b36abfd 100644
--- a/mars.txt
+++ b/mars.txt
@@ -1 +1,3 @@
 Cold and dry, but everything is my favorite color
+The two moons may be a problem for Wolfman
+But the Mummy will appreciate the lack of humidity
```


All right! So
we can save changes to files and see what we've changed—now how
can we restore older versions of things?
Let's suppose we accidentally overwrite our file:

```
$ nano mars.txt
$ cat mars.txt
```


```
We will need to manufacture our own oxygen
```


`git status` now tells us that the file has been changed,
but those changes haven't been staged:

```
$ git status
```


```
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   mars.txt

no changes added to commit (use "git add" and/or "git commit -a")
```


We can put things back the way they were
by using `git checkout`:

```
$ git checkout HEAD mars.txt
$ cat mars.txt
```


```
Cold and dry, but everything is my favorite color
The two moons may be a problem for Wolfman
But the Mummy will appreciate the lack of humidity
```


As you might guess from its name,
`git checkout` checks out (i.e., restores) an old version of a file.
In this case,
we're telling Git that we want to recover the version of the file recorded in `HEAD`,
which is the last saved commit.
If we want to go back even further,
we can use a commit identifier instead:

```
$ git checkout f22b25e mars.txt
```


```
$ cat mars.txt
```


```
Cold and dry, but everything is my favorite color
```


```
$ git status
```


```
# On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	modified:   mars.txt
#
no changes added to commit (use "git add" and/or "git commit -a")
```


Notice that the changes are on the staged area.
Again, we can put things back the way they were with
by using `git checkout`:

```
$ git checkout -f master mars.txt
```


> **Don't Lose Your HEAD**
>
> Above we used
>
> ```
> $ git checkout f22b25e mars.txt
> ```
> 
>
> to revert `mars.txt` to its state after the commit `f22b25e`.
> If you forget `mars.txt` in that command, Git will tell you that "You are in
> 'detached HEAD' state." In this state, you shouldn't make any changes.
> You can fix this by reattaching your head using ``git checkout master``


It's important to remember that
we must use the commit number that identifies the state of the repository
*before* the change we're trying to undo.
A common mistake is to use the number of
the commit in which we made the change we're trying to get rid of.
In the example below, we want to retrieve the state from before the most
recent commit (`HEAD~1`), which is commit `f22b25e`:

![Git Checkout](fig/git-checkout.svg)

So, to put it all together,
here's how Git works in cartoon form:

![http://figshare.com/articles/How_Git_works_a_cartoon/1328266](fig/git_staging.svg)

> **Simplifying the Common Case**
>
> If you read the output of `git status` carefully,
> you'll see that it includes this hint:
>
> ```
> (use "git checkout -- <file>..." to discard changes in working directory)
> ```
> 
>
> As it says,
> `git checkout` without a version identifier restores files to the state saved in `HEAD`.
> The double dash `--` is needed to separate the names of the files being recovered
> from the command itself:
> without it,
> Git would try to use the name of the file as the commit identifier.


The fact that files can be reverted one by one
tends to change the way people organize their work.
If everything is in one large document,
it's hard (but not impossible) to undo changes to the introduction
without also undoing changes made later to the conclusion.
If the introduction and conclusion are stored in separate files,
on the other hand,
moving backward and forward in time becomes much easier.

> **Recovering Older Versions of a File**
>
> Jennifer has made changes to the Python script that she has been working on for weeks, and the
> modifications she made this morning "broke" the script and it no longer runs. She has spent
> ~ 1hr trying to fix it, with no luck...
>
> Luckily, she has been keeping track of her project's versions using Git! Which commands below will
> let her recover the last committed version of her Python script called
> `data_cruncher.py`?
>
> 1. `$ git checkout HEAD`
>
> 2. `$ git checkout HEAD data_cruncher.py`
>
> 3. `$ git checkout HEAD~1 data_cruncher.py`
>
> 4. `$ git checkout <unique ID of last commit> data_cruncher.py`
>
> 5. Both 2 and 4


> **Reverting a Commit**
>
> Jennifer is collaborating on her Python script with her colleagues and
> realises her last commit to the group repository is wrong and wants to
> undo it.  Jennifer needs to undo correctly so everyone in the group
> repository gets the correct change.  `git revert [wrong commit ID]`
> will make a new commit that undoes Jennifer's previous wrong
> commit. Therefore `git revert` is different than `git checkout [commit
> ID]` because `checkout` is for local changes not committed to the
> group repository.  Below are the right steps and explanations for
> Jennifer to use `git revert`, what is the missing command?
>
> 1. ________ # Look at the git history of the project to find the commit ID
>
> 2. Copy the ID (the first few characters of the ID, e.g. 0b1d055).
>
> 3. `git revert [commit ID]`
>
> 4. Type in the new commit message.
>
> 5. Save and close


> **Understanding Workflow and History**
>
> What is the output of cat venus.txt at the end of this set of commands?
>
> ```
> $ cd planets
> $ nano venus.txt #input the following text: Venus is beautiful and full of love
> $ git add venus.txt
> $ nano venus.txt #add the following text: Venus is too hot to be suitable as a base
> $ git commit -m "comments on Venus as an unsuitable base"
> $ git checkout HEAD venus.txt
> $ cat venus.txt #this will print the contents of venus.txt to the screen
> ```
> 
>
> 1.
>
> ```
> Venus is too hot to be suitable as a base
> ```
> 
>
> 2.
>
> ```
> Venus is beautiful and full of love
> ```
> 
>
> 3.
>
> ```
> Venus is beautiful and full of love
> Venus is too hot to be suitable as a base
> ```
> 
>
> 4.
>
> ```
> Error because you have changed venus.txt without committing the changes
> ```
> 
>
<!-- > > ## Solution -->
<!-- > > -->
<!-- > > Line by line: -->
<!-- > > ``` -->
<!-- > > $ cd planets -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > Enters into the 'planets' directory -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > $ nano venus.txt #input the following text: Venus is beautiful and full of love -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > We created a new file and wrote a sentence in it, but the file is not tracked by git.   -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > $ git add venus.txt -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > Now the file is stagged. The changes that have been made to the file until now will be commited in the next commit. -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > $ nano venus.txt #add the following text: Venus is too hot to be suitable as a base -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > The file has been modified. The new changes are not staged because we have not added the file. -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > $ git commit -m "comments on Venus as an unsuitable base" -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > The changes that were stagged (Venus is beautiful and full of love) have been commited. The changes that were not stagged (Venus is too hot to be suitable as a base) have not. Our local working copy is different than the copy in our local repository. -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > $ git checkout HEAD venus.txt -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > With checkout we discard the changes in the working directory so that our local copy is exactly the same as our HEAD, the most recent commit. -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > $ cat venus.txt #this will print the contents of venus.txt to the screen -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > If we print venus.txt we will get answer 2. -->
<!-- > > -->
<!-- >  -->


> **Checking Understanding of `git diff`**
>
> Consider this command: `git diff HEAD~3 mars.txt`. What do you predict this command
> will do if you execute it? What happens when you do execute it? Why?
>
> Try another command, `git diff [ID] mars.txt`, where [ID] is replaced with
> the unique identifier for your most recent commit. What do you think will happen,
> and what does happen?


> **Getting Rid of Staged Changes**
>
> `git checkout` can be used to restore a previous commit when unstaged changes have
> been made, but will it also work for changes that have been staged but not committed?
> Make a change to `mars.txt`, add that change, and use `git checkout` to see if
> you can remove your change.


> **Explore and Summarize Histories**
>
> Exploring history is an important part of git, often it is a challenge to find
> the right commit ID, especially if the commit is from several months ago.
>
> Imaging the `planets` project has more than 50 files.
> You would like to find a commit with specific text in `mars.txt` is modified.
> When you type `git log`, a very long list appeared,
> How can you narrow down the search?
>
> Recorded that the `git diff` command allow us to explore one specific file,
> e.g. `git diff mars.txt`. We can apply the similar idea here.
>
> ```
> $ git log mars.txt
> ```
> 
>
> Unfortunately some of these commit messages are very ambiguous e.g. `update files`.
> How can you search through these files?
>
> Both `git diff` and `git log` are very useful and they summarize different part of the history for you.
> Is that possible to combine both? Let's try the following:
>
> ```
> $ git log --patch mars.txt
> ```
> 
>
> You should get a long list of output, and you should be able to see both commit messages and the difference between each commit.
>
> Question: What does the following command do?
>
> ```
> $ git log --patch HEAD~3 HEAD~1 *.txt
> ```
> 


## Ignoring Things

What if we have files that we do not want Git to track for us,
like backup files created by our editor
or intermediate files created during data analysis.
Let's create a few dummy files:

```
$ mkdir results
$ touch a.dat b.dat c.dat results/a.out results/b.out
```


and see what Git says:

```
$ git status
```


```
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	a.dat
	b.dat
	c.dat
	results/
nothing added to commit but untracked files present (use "git add" to track)
```


Putting these files under version control would be a waste of disk space.
What's worse,
having them all listed could distract us from changes that actually matter,
so let's tell Git to ignore them.

We do this by creating a file in the root directory of our project called `.gitignore`:

```
$ nano .gitignore
$ cat .gitignore
```


```
*.dat
results/
```


These patterns tell Git to ignore any file whose name ends in `.dat`
and everything in the `results` directory.
(If any of these files were already being tracked,
Git would continue to track them.)

Once we have created this file,
the output of `git status` is much cleaner:

```
$ git status
```


```
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	.gitignore
nothing added to commit but untracked files present (use "git add" to track)
```


The only thing Git notices now is the newly-created `.gitignore` file.
You might think we wouldn't want to track it,
but everyone we're sharing our repository with will probably want to ignore
the same things that we're ignoring.
Let's add and commit `.gitignore`:

```
$ git add .gitignore
$ git commit -m "Add the ignore file"
$ git status
```


```
# On branch master
nothing to commit, working directory clean
```


As a bonus, using `.gitignore` helps us avoid accidentally adding to the repository files that we don't want to track:

```
$ git add a.dat
```


```
The following paths are ignored by one of your .gitignore files:
a.dat
Use -f if you really want to add them.
```


If we really want to override our ignore settings,
we can use `git add -f` to force Git to add something. For example,
`git add -f a.dat`.
We can also always see the status of ignored files if we want:

```
$ git status --ignored
```


```
On branch master
Ignored files:
 (use "git add -f <file>..." to include in what will be committed)

        a.dat
        b.dat
        c.dat
        results/

nothing to commit, working directory clean
```


> **Ignoring Nested Files**
>
> Given a directory structure that looks like:
>
> ```
> results/data
> results/plots
> ```
> 
>
> How would you ignore only `results/plots` and not `results/data`?
>
<!-- > > ## Solution -->
<!-- > > -->
<!-- > > As with most programming issues, there are a few ways that you -->
<!-- > > could solve this. If you only want to ignore the contents of -->
<!-- > > `results/plots`, you can change your `.gitignore` to ignore -->
<!-- > > only the `/plots/` subfolder by adding the following line to -->
<!-- > > your .gitignore: -->
<!-- > > -->
<!-- > > `results/plots/` -->
<!-- > > -->
<!-- > > If, instead, you want to ignore everything in `/results/`, but wanted to track -->
<!-- > > `results/data`, then you can add `results/` to your .gitignore -->
<!-- > > and create an exception for the `results/data/` folder. -->
<!-- > > The next challenge will cover this type of solution. -->
<!-- > > -->
<!-- > > Sometimes the `**` pattern comes in handy, too, which matches -->
<!-- > > multiple directory levels. E.g. `**/results/plots/*` would make git ignore -->
<!-- > > the `results/plots` directory in any root directory. -->
<!-- >  -->


<!-- > **Including Specific Files** -->
<!-- > -->
<!-- > How would you ignore all `.data` files in your root directory except for -->
<!-- > `final.data`? -->
<!-- > Hint: Find out what `!` (the exclamation point operator) does -->
<!-- > -->
<!-- > > ## Solution -->
<!-- > > -->
<!-- > > You would add the following two lines to your .gitignore: -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > *.data           # ignore all data files -->
<!-- > > !final.data      # except final.data -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > -->
<!-- > > The exclamation point operator will include a previously excluded entry. -->
<!-- >  -->


> **Ignoring all data Files in a Directory**
>
> Given a directory structure that looks like:
>
> ```
> results/data/position/gps/a.data
> results/data/position/gps/b.data
> results/data/position/gps/c.data
> results/data/position/gps/info.txt
> results/plots
> ```
> 
>
> What's the shortest `.gitignore` rule you could write to ignore all `.data`
> files in `result/data/position/gps`? Do not ignore the `info.txt`.
>
<!-- > > ## Solution -->
<!-- > > -->
<!-- > > Appending `results/data/position/gps/*.data` will match every file in `results/data/position/gps` that ends with `.data`. -->
<!-- > > The file `results/data/position/gps/info.txt` will not be ignored. -->
<!-- >  -->


> **The Order of Rules**
>
> Given a `.gitignore` file with the following contents:
>
> ```
> *.data
> !*.data
> ```
> 
>
> What will be the result?
>
<!-- > > ## Solution -->
<!-- > > -->
<!-- > > The `!` modifier will negate an entry from a previously defined ignore pattern. -->
<!-- > > Because the `!*.data` entry negates all of the previous `.data` files in the `.gitignore`, -->
<!-- > > none of them will be ignored, and all `.data` files will be tracked. -->
<!-- > > -->
<!-- >  -->


> **Log Files**
>
> You wrote a script that creates many intermediate log-files of the form `log_01`, `log_02`, `log_03`, etc.
> You want to keep them but you do not want to track them through `git`.
>
> 1. Write **one** `.gitignore` entry that excludes files of the form `log_01`, `log_02`, etc.
>
> 2. Test your "ignore pattern" by creating some dummy files of the form `log_01`, etc.
>
> 3. You find that the file `log_01` is very important after all, add it to the tracked files without changing the `.gitignore` again.
>
> 4. Discuss with your neighbor what other types of files could reside in your directory that you do not want to track and thus would exclude via `.gitignore`.
>
<!-- > > ## Solution -->
<!-- > > -->
<!-- > > 1. append either `log_*`  or  `log*`  as a new entry in your .gitignore -->
<!-- > > 3. track `log_01` using   `git add -f log_01` -->
<!-- >  -->


## Remotes in GitHub

Version control really comes into its own when we begin to collaborate with
other people.  We already have most of the machinery we need to do this; the
only thing missing is to copy changes from one repository to another.

Systems like Git allow us to move work between any two repositories.  In
practice, though, it's easiest to use one copy as a central hub, and to keep it
on the web rather than on someone's laptop.  Most programmers use hosting
services like [GitHub](http://github.com), [BitBucket](http://bitbucket.org) or
[GitLab](http://gitlab.com/) to hold those master copies; we'll explore the pros
and cons of this in the final section of this lesson.

Let's start by sharing the changes we've made to our current project with the
world.  Log in to GitHub, then click on the icon in the top right corner to
create a new repository called `planets`:

![Creating a Repository on GitHub (Step 1)](fig/github-create-repo-01.png)

Name your repository "planets" and then click "Create Repository":

![Creating a Repository on GitHub (Step 2)](fig/github-create-repo-02.png)

As soon as the repository is created, GitHub displays a page with a URL and some
information on how to configure your local repository:

![Creating a Repository on GitHub (Step 3)](fig/github-create-repo-03.png)

This effectively does the following on GitHub's servers:

```
$ mkdir planets
$ cd planets
$ git init
```


Our local repository still contains our earlier work on `mars.txt`, but the
remote repository on GitHub doesn't contain any files yet:

![Freshly-Made GitHub Repository](fig/git-freshly-made-github-repo.svg)

The next step is to connect the two repositories.  We do this by making the
GitHub repository a [remote]({{ page.root }}/reference/#remote) for the local repository.
The home page of the repository on GitHub includes the string we need to
identify it:

![Where to Find Repository URL on GitHub](fig/github-find-repo-string.png)

Click on the 'HTTPS' link to change the [protocol]({{ page.root }}/reference/#protocol) from
SSH to HTTPS.

> **HTTPS vs. SSH**
>
> We use HTTPS here because it does not require additional configuration.  After
> the workshop you may want to set up SSH access, which is a bit more secure, by
> following one of the great tutorials from
> [GitHub](https://help.github.com/articles/generating-ssh-keys),
> [Atlassian/BitBucket](https://confluence.atlassian.com/display/BITBUCKET/Set+up+SSH+for+Git)
> and [GitLab](https://about.gitlab.com/2014/03/04/add-ssh-key-screencast/)
> (this one has a screencast).


![Changing the Repository URL on GitHub](fig/github-change-repo-string.png)

Copy that URL from the browser, go into the local `planets` repository, and run
this command:

```
$ git remote add origin https://github.com/vlad/planets.git
```


Make sure to use the URL for your repository rather than Vlad's: the only
difference should be your username instead of `vlad`.

We can check that the command has worked by running `git remote -v`:

```
$ git remote -v
```


```
origin   https://github.com/vlad/planets.git (push)
origin   https://github.com/vlad/planets.git (fetch)
```


The name `origin` is a local nickname for your remote repository. We could use
something else if we wanted to, but `origin` is by far the most common choice.

Once the nickname `origin` is set up, this command will push the changes from
our local repository to the repository on GitHub:

```
$ git push origin master
```


```
Counting objects: 9, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (6/6), done.
Writing objects: 100% (9/9), 821 bytes, done.
Total 9 (delta 2), reused 0 (delta 0)
To https://github.com/vlad/planets
 * [new branch]      master -> master
Branch master set up to track remote branch master from origin.
```


> **Proxy**
>
> If the network you are connected to uses a proxy there is an chance that your
> last command failed with "Could not resolve hostname" as the error message. To
> solve this issue you need to tell Git about the proxy:
>
> ```
> $ git config --global http.proxy http://user:password@proxy.url
> $ git config --global https.proxy http://user:password@proxy.url
> ```
> 
>
> When you connect to another network that doesn't use a proxy you will need to
> tell Git to disable the proxy using:
>
> ```
> $ git config --global --unset http.proxy
> $ git config --global --unset https.proxy
> ```
> 


> **Password Managers**
>
> If your operating system has a password manager configured, `git push` will
> try to use it when it needs your username and password.  For example, this
> is the default behavior for Git Bash on Windows. If you want to type your
> username and password at the terminal instead of using a password manager,
> type:
>
> ```
> $ unset SSH_ASKPASS
> ```
> 
>
> in the terminal, before you run `git push`.  Despite the name, [git uses
> `SSH_ASKPASS` for all credential
> entry](http://git-scm.com/docs/gitcredentials#_requesting_credentials), so
> you may want to unset `SSH_ASKPASS` whether you are using git via SSH or
> https.
>
> You may also want to add `unset SSH_ASKPASS` at the end of your `~/.bashrc`
> to make git default to using the terminal for usernames and passwords.


Our local and remote repositories are now in this state:

![GitHub Repository After First Push](fig/github-repo-after-first-push.svg)

> **The '-u' Flag**
>
> You may see a `-u` option used with `git push` in some documentation.  This
> option is synonymous with the `--set-upstream-to` option for the `git branch`
> command, and is used to associate the current branch with a remote branch so
> that the `git pull` command can be used without any arguments. To do this,
> simply use `git push -u origin master` once the remote has been set up.


We can pull changes from the remote repository to the local one as well:

```
$ git pull origin master
```


```
From https://github.com/vlad/planets
 * branch            master     -> FETCH_HEAD
Already up-to-date.
```


Pulling has no effect in this case because the two repositories are already
synchronized.  If someone else had pushed some changes to the repository on
GitHub, though, this command would download them to our local repository.

> **GitHub GUI**
>
> Browse to your `planets` repository on GitHub.
> Under the Code tab, find and click on the text that says "XX commits" (where "XX" is some number).
> Hover over, and click on, the three buttons to the right of each commit.
> What information can you gather/explore from these buttons?
> How would you get that same information in the shell?
>
<!-- > > ## Solution -->
<!-- > > The left-most button (with the picture of a clipboard) copies the full identifier of the commit to the clipboard. In the shell, ```git log``` will show you the full commit identifier for each commit. -->
<!-- > > -->
<!-- > > When you click on the middle button, you'll see all of the changes that were made in that particular commit. Green shaded lines indicate additions and red ones removals. In the shell we can do the same thing with ```git diff```. In particular, ```git diff ID1..ID2``` where ID1 and ID2 are commit identifiers (e.g. ```git diff a3bf1e5..041e637```) will show the differences between those two commits. -->
<!-- > > -->
<!-- > > The right-most button lets you view all of the files in the repository at the time of that commit. To do this in the shell, we'd need to checkout the repository at that particular time. We can do this with ```git checkout ID``` where ID is the identifier of the commit we want to look at. If we do this, we need to remember to put the repository back to the right state afterwards! -->
<!-- >  -->


> **GitHub Timestamp**
>
> Create a remote repository on GitHub.  Push the contents of your local
> repository to the remote.  Make changes to your local repository and push
> these changes.  Go to the repo you just created on GitHub and check the
> [timestamps]({{ page.root }}/reference/#timestamp) of the files.  How does GitHub record
> times, and why?
>
<!-- > > ## Solution -->
<!-- > > Github displays timestamps in a human readable relative format (i.e. "22 hours ago" or "three weeks ago"). However, if you hover over the timestamp, you can see the exact time at which the last change to the file occurred. -->
<!-- >  -->


> **Push vs. Commit**
>
> In this lesson, we introduced the "git push" command.
> How is "git push" different from "git commit"?
>
<!-- > > ## Solution -->
<!-- > > When we push changes, we're interacting with a remote repository to update it with the changes we've made locally (often this corresponds to sharing the changes we've made with others). Commit only updates your local repository. -->
<!-- >  -->


> **Fixing Remote Settings**
>
> It happens quite often in practice that you made a typo in the
> remote URL. This exercice is about how to fix this kind of issues.
> First start by adding a remote with an invalid URL:
>
> ```
> git remote add broken https://github.com/this/url/is/invalid
> ```
> 
>
> Do you get an error when adding the remote? Can you think of a
> command that would make it obvious that your remote URL was not
> valid? Can you figure out how to fix the URL (tip: use `git remote
> -h`)? Don't forget to clean up and remove this remote once you are
> done with this exercise.
>
<!-- > > ## Solution -->
<!-- > > We don't see any error message when we add the remote (adding the remote tells git about it, but doesn't try to use it yet). As soon as we try to use ```git push``` we'll see an error message. The command ```git remote set-url``` allows us to change the remote's URL to fix it. -->
<!-- >  -->


> **GitHub License and README files**
>
> In this section we learned about creating a remote repository on GitHub, but when you initialized your
> GitHub repo, you didn't add a README.md or a license file. If you had, what do you think would have happened when
> you tried to link your local and remote repositories?
>
<!-- > > ## Solution -->
<!-- > > In this case, since we already had a README file in our own (local) repository, we'd see a merge conflict (when git realises that there are two versions of the file and asks us to reconcile the differences). -->
<!-- >  -->


## Collaborating

For the next step, get into pairs.  One person will be the "Owner" and the other
will be the "Collaborator". The goal is that the Collaborator add changes into
the Owner's repository. We will switch roles at the end, so both persons will
play Owner and Collaborator.

> **Practicing By Yourself**
>
> If you're working through this lesson on your own, you can carry on by opening
> a second terminal window.
> This window will represent your partner, working on another computer. You
> won't need to give anyone access on GitHub, because both 'partners' are you.


The Owner needs to give the Collaborator access.
On GitHub, click the settings button on the right,
then select Collaborators, and enter your partner's username.

![Adding Collaborators on GitHub](fig/github-add-collaborators.png)

To accept access to the Owner's repo, the Collaborator
needs to go to [https://github.com/notifications](https://github.com/notifications).
Once there she can accept access to the Owner's repo.

Next, the Collaborator needs to download a copy of the Owner's repository to her
 machine. This is called "cloning a repo". To clone the Owner's repo into
her `Desktop` folder, the Collaborator enters:

```
$ git clone https://github.com/vlad/planets.git ~/Desktop/vlad-planets
```


Replace 'vlad' with the Owner's username.

![After Creating Clone of Repository](fig/github-collaboration.svg)

The Collaborator can now make a change in her clone of the Owner's repository,
exactly the same way as we've been doing before:

```
$ cd ~/Desktop/vlad-planets
$ nano pluto.txt
$ cat pluto.txt
```


```
It is so a planet!
```


```
$ git add pluto.txt
$ git commit -m "Some notes about Pluto"
```


```
 1 file changed, 1 insertion(+)
 create mode 100644 pluto.txt
```


Then push the change to the *Owner's repository* on GitHub:

```
$ git push origin master
```


```
Counting objects: 4, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 306 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
To https://github.com/vlad/planets.git
   9272da5..29aba7c  master -> master
```


Note that we didn't have to create a remote called `origin`: Git uses this
name by default when we clone a repository.  (This is why `origin` was a
sensible choice earlier when we were setting up remotes by hand.)

Take a look to the Owner's repository on its GitHub website now (maybe you need
to refresh your browser.) You should be able to see the new commit made by the
Collaborator.

To download the Collaborator's changes from GitHub, the Owner now enters:

```
$ git pull origin master
```


```
remote: Counting objects: 4, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 3 (delta 0)
Unpacking objects: 100% (3/3), done.
From https://github.com/vlad/planets
 * branch            master     -> FETCH_HEAD
Updating 9272da5..29aba7c
Fast-forward
 pluto.txt | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 pluto.txt
```


Now the three repositories (Owner's local, Collaborator's local, and Owner's on
GitHub) are back in sync.

> **A Basic Collaborative Workflow**
>
> In practice, it is good to be sure that you have an updated version of the
> repository you are collaborating on, so you should `git pull` before making
> our changes. The basic collaborative workflow would be:
>
> * update your local repo with `git pull origin master`,
> * make your changes and stage them with `git add`,
> * commit your changes with `git commit -m`, and
> * upload the changes to GitHub with `git push origin master`
>
> It is better to make many commits with smaller changes rather than
> of one commit with massive changes: small commits are easier to
> read and review.


> **Switch Roles and Repeat**
>
> Switch roles and repeat the whole process.


> **Review Changes**
>
> The Owner push commits to the repository without giving any information
> to the Collaborator. How can the Collaborator find out what has changed with
> command line? And on GitHub?


> **Comment Changes in GitHub**
>
> The Collaborator has some questions about one line change made by the Owner and
> has some suggestions to propose.
>
> With GitHub, it is possible to comment the diff of a commit. Over the line of
> code to comment, a blue comment icon appears to open a comment window.
>
> The Collaborator posts its comments and suggestions using GitHub interface.


> **Version History, Backup, and Version Control**
>
> Some backup software can keep a history of the versions of your files. They also
> allows you to recover specific versions. How is this functionality different from version control?
> What are some of the benifits of using version control, Git and GitHub?


## Conflicts

As soon as people can work in parallel, it's likely someone's going to step on someone
else's toes.  This will even happen with a single person: if we are working on
a piece of software on both our laptop and a server in the lab, we could make
different changes to each copy.  Version control helps us manage these
[conflicts]({{ page.root }}/reference/#conflicts) by giving us tools to
[resolve]({{ page.root }}/reference/#resolve) overlapping changes.

To see how we can resolve conflicts, we must first create one.  The file
`mars.txt` currently looks like this in both partners' copies of our `planets`
repository:

```
$ cat mars.txt
```


```
Cold and dry, but everything is my favorite color
The two moons may be a problem for Wolfman
But the Mummy will appreciate the lack of humidity
```


Let's add a line to one partner's copy only:

```
$ nano mars.txt
$ cat mars.txt
```


```
Cold and dry, but everything is my favorite color
The two moons may be a problem for Wolfman
But the Mummy will appreciate the lack of humidity
This line added to Wolfman's copy
```


and then push the change to GitHub:

```
$ git add mars.txt
$ git commit -m "Adding a line in our home copy"
```


```
[master 5ae9631] Adding a line in our home copy
 1 file changed, 1 insertion(+)
```


```
$ git push origin master
```


```
Counting objects: 5, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 352 bytes, done.
Total 3 (delta 1), reused 0 (delta 0)
To https://github.com/vlad/planets
   29aba7c..dabb4c8  master -> master
```


Now let's have the other partner
make a different change to their copy
*without* updating from GitHub:

```
$ nano mars.txt
$ cat mars.txt
```


```
Cold and dry, but everything is my favorite color
The two moons may be a problem for Wolfman
But the Mummy will appreciate the lack of humidity
We added a different line in the other copy
```


We can commit the change locally:

```
$ git add mars.txt
$ git commit -m "Adding a line in my copy"
```


```
[master 07ebc69] Adding a line in my copy
 1 file changed, 1 insertion(+)
```


but Git won't let us push it to GitHub:

```
$ git push origin master
```


```
To https://github.com/vlad/planets.git
 ! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to 'https://github.com/vlad/planets.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Merge the remote changes (e.g. 'git pull')
hint: before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```


![The Conflicting Changes](fig/conflict.svg)

Git detects that the changes made in one copy overlap with those made in the other
and stops us from trampling on our previous work.
What we have to do is pull the changes from GitHub,
[merge]({{ page.root }}/reference/#merge) them into the copy we're currently working in,
and then push that.
Let's start by pulling:

```
$ git pull origin master
```


```
remote: Counting objects: 5, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 1), reused 3 (delta 1)
Unpacking objects: 100% (3/3), done.
From https://github.com/vlad/planets
 * branch            master     -> FETCH_HEAD
Auto-merging mars.txt
CONFLICT (content): Merge conflict in mars.txt
Automatic merge failed; fix conflicts and then commit the result.
```


`git pull` tells us there's a conflict,
and marks that conflict in the affected file:

```
$ cat mars.txt
```


```
Cold and dry, but everything is my favorite color
The two moons may be a problem for Wolfman
But the Mummy will appreciate the lack of humidity
<<<<<<< HEAD
We added a different line in the other copy
=======
This line added to Wolfman's copy
>>>>>>> dabb4c8c450e8475aee9b14b4383acc99f42af1d
```


Our change—the one in `HEAD`—is preceded by `<<<<<<<`.
Git has then inserted `=======` as a separator between the conflicting changes
and marked the end of the content downloaded from GitHub with `>>>>>>>`.
(The string of letters and digits after that marker
identifies the commit we've just downloaded.)

It is now up to us to edit this file to remove these markers
and reconcile the changes.
We can do anything we want: keep the change made in the local repository, keep
the change made in the remote repository, write something new to replace both,
or get rid of the change entirely.
Let's replace both so that the file looks like this:

```
$ cat mars.txt
```


```
Cold and dry, but everything is my favorite color
The two moons may be a problem for Wolfman
But the Mummy will appreciate the lack of humidity
We removed the conflict on this line
```


To finish merging,
we add `mars.txt` to the changes being made by the merge
and then commit:

```
$ git add mars.txt
$ git status
```


```
On branch master
All conflicts fixed but you are still merging.
  (use "git commit" to conclude merge)

Changes to be committed:

	modified:   mars.txt

```


```
$ git commit -m "Merging changes from GitHub"
```


```
[master 2abf2b1] Merging changes from GitHub
```


Now we can push our changes to GitHub:

```
$ git push origin master
```


```
Counting objects: 10, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (6/6), done.
Writing objects: 100% (6/6), 697 bytes, done.
Total 6 (delta 2), reused 0 (delta 0)
To https://github.com/vlad/planets.git
   dabb4c8..2abf2b1  master -> master
```


Git keeps track of what we've merged with what,
so we don't have to fix things by hand again
when the collaborator who made the first change pulls again:

```
$ git pull origin master
```


```
remote: Counting objects: 10, done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 6 (delta 2), reused 6 (delta 2)
Unpacking objects: 100% (6/6), done.
From https://github.com/vlad/planets
 * branch            master     -> FETCH_HEAD
Updating dabb4c8..2abf2b1
Fast-forward
 mars.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
```


We get the merged file:

```
$ cat mars.txt
```


```
Cold and dry, but everything is my favorite color
The two moons may be a problem for Wolfman
But the Mummy will appreciate the lack of humidity
We removed the conflict on this line
```


We don't need to merge again because Git knows someone has already done that.

Git's ability to resolve conflicts is very useful, but conflict resolution
costs time and effort, and can introduce errors if conflicts are not resolved
correctly. If you find yourself resolving a lot of conflicts in a project,
consider one of these approaches to reducing them:

- Try breaking large files apart into smaller files so that it is less
  likely that two authors will be working in the same file at the same time
- Clarify who is responsible for what areas with your collaborators
- Discuss what order tasks should be carried out in with your collaborators so
  that tasks that will change the same file won't be worked on at the same time

> **Solving Conflicts that You Create**
>
> Clone the repository created by your instructor.
> Add a new file to it,
> and modify an existing file (your instructor will tell you which one).
> When asked by your instructor,
> pull her changes from the repository to create a conflict,
> then resolve it.


> **Conflicts on Non-textual files**
>
> What does Git do
> when there is a conflict in an image or some other non-textual file
> that is stored in version control?
>
<!-- > > ## Solution -->
<!-- > > -->
<!-- > > Let's try it. Suppose Dracula takes a picture of Martian surface and -->
<!-- > > calls it `mars.jpg`. -->
<!-- > > -->
<!-- > > If you do not have an image file of Mars available, you can create -->
<!-- > > a dummy binary file like this: -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > $ head --bytes 1024 /dev/urandom > mars.jpg -->
<!-- > > $ ls -lh mars.jpg -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > -rw-r--r-- 1 vlad 57095 1.0K Mar  8 20:24 mars.jpg -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > -->
<!-- > > `ls` shows us that this created a 1-kilobyte file. It is full of -->
<!-- > > random bytes read from the special file, `/dev/urandom`. -->
<!-- > > -->
<!-- > > Now, suppose Dracula adds `mars.jpg` to his repository: -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > $ git add mars.jpg -->
<!-- > > $ git commit -m "Picture of Martian surface" -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > [master 8e4115c] Picture of Martian surface -->
<!-- > >  1 file changed, 0 insertions(+), 0 deletions(-) -->
<!-- > >  create mode 100644 mars.jpg -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > -->
<!-- > > Suppose that Wolfman has added a similar picture in the meantime. -->
<!-- > > His is a picture of the Martian sky, but it is *also* called `mars.jpg`. -->
<!-- > > When Dracula tries to push, he gets a familiar message: -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > $ git push origin master -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > To https://github.com/vlad/planets.git -->
<!-- > >  ! [rejected]        master -> master (fetch first) -->
<!-- > > error: failed to push some refs to 'https://github.com/vlad/planets.git' -->
<!-- > > hint: Updates were rejected because the remote contains work that you do -->
<!-- > > hint: not have locally. This is usually caused by another repository pushing -->
<!-- > > hint: to the same ref. You may want to first integrate the remote changes -->
<!-- > > hint: (e.g., 'git pull ...') before pushing again. -->
<!-- > > hint: See the 'Note about fast-forwards' in 'git push --help' for details. -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > -->
<!-- > > We've learned that we must pull first and resolve any conflicts: -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > $ git pull origin master -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > -->
<!-- > > When there is a conflict on an image or other binary file, git prints -->
<!-- > > a message like this: -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > $ git pull origin master -->
<!-- > > remote: Counting objects: 3, done. -->
<!-- > > remote: Compressing objects: 100% (3/3), done. -->
<!-- > > remote: Total 3 (delta 0), reused 0 (delta 0) -->
<!-- > > Unpacking objects: 100% (3/3), done. -->
<!-- > > From https://github.com/vlad/planets.git -->
<!-- > >  * branch            master     -> FETCH_HEAD -->
<!-- > >    6a67967..439dc8c  master     -> origin/master -->
<!-- > > warning: Cannot merge binary files: mars.jpg (HEAD vs. 439dc8c08869c342438f6dc4a2b615b05b93c76e) -->
<!-- > > Auto-merging mars.jpg -->
<!-- > > CONFLICT (add/add): Merge conflict in mars.jpg -->
<!-- > > Automatic merge failed; fix conflicts and then commit the result. -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > -->
<!-- > > The conflict message here is mostly the same as it was for `mars.txt`, but -->
<!-- > > there is one key additional line: -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > warning: Cannot merge binary files: mars.jpg (HEAD vs. 439dc8c08869c342438f6dc4a2b615b05b93c76e) -->
<!-- > > ``` -->
<!-- > > -->
<!-- > > Git cannot automatically insert conflict markers into an image as it does -->
<!-- > > for text files. So, instead of editing the image file, we must check out -->
<!-- > > the version we want to keep. Then we can add and commit this version. -->
<!-- > > -->
<!-- > > On the key line above, Git has conveniently given us commit identifiers -->
<!-- > > for the two versions of `mars.jpg`. Our version is `HEAD`, and Wolfman's -->
<!-- > > version is `439dc8c0...`. If we want to use our version, we can use -->
<!-- > > `git checkout`: -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > $ git checkout HEAD mars.jpg -->
<!-- > > $ git add mars.jpg -->
<!-- > > $ git commit -m "Use image of surface instead of sky" -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > [master 21032c3] Use image of surface instead of sky -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > -->
<!-- > > If instead we want to use Wolfman's version, we can use `git checkout` with -->
<!-- > > Wolfman's commit identifier, `439dc8c0`: -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > $ git checkout 439dc8c0 mars.jpg -->
<!-- > > $ git add mars.jpg -->
<!-- > > $ git commit -m "Use image of sky instead of surface" -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > [master da21b34] Use image of sky instead of surface -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > -->
<!-- > > We can also keep *both* images. The catch is that we cannot keep them -->
<!-- > > under the same name. But, we can check out each version in succession -->
<!-- > > and *rename* it, then add the renamed versions. First, check out each -->
<!-- > > image and rename it: -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > $ git checkout HEAD mars.jpg -->
<!-- > > $ git mv mars.jpg mars-surface.jpg -->
<!-- > > $ git checkout 439dc8c0 mars.jpg -->
<!-- > > $ mv mars.jpg mars-sky.jpg -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > -->
<!-- > > Then, remove the old `mars.jpg` and add the two new files: -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > $ git rm mars.jpg -->
<!-- > > $ git add mars-surface.jpg -->
<!-- > > $ git add mars-sky.jpg -->
<!-- > > $ git commit -m "Use two images: surface and sky" -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > -->
<!-- > > ``` -->
<!-- > > [master 94ae08c] Use two images: surface and sky -->
<!-- > >  2 files changed, 0 insertions(+), 0 deletions(-) -->
<!-- > >  create mode 100644 mars-sky.jpg -->
<!-- > >  rename mars.jpg => mars-surface.jpg (100%) -->
<!-- > > ``` -->
<!-- > >  -->
<!-- > > -->
<!-- > > Now both images of Mars are checked into the repository, and `mars.jpg` -->
<!-- > > no longer exists. -->
<!-- >  -->


> **A Typical Work Session**
>
> You sit down at your computer to work on a shared project that is tracked in a
> remote Git repository. During your work session, you take the following
> actions, but not in this order:
>
> - *Make changes* by appending the number `100` to a text file `numbers.txt`
> - *Update remote* repository to match the local repository
> - *Celebrate* your success with beer(s)
> - *Update local* repository to match the remote repository
> - *Stage changes* to be committed
> - *Commit changes* to the local repository
>
> In what order should you perform these actions to minimize the chances of
> conflicts? Put the commands above in order in the *action* column of the table
> below. When you have the order right, see if you can write the corresponding
> commands in the *command* column. A few steps are populated to get you
> started.
>
> |order|action . . . . . . . . . . |command . . . . . . . . . . |
> |-----|---------------------------|----------------------------|
> |1    |                           |                            |
> |2    |                           | `echo 100 >> numbers.txt`  |
> |3    |                           |                            |
> |4    |                           |                            |
> |5    |                           |                            |
> |6    | Celebrate!                | `AFK`                      |
>
<!-- > > ## Solution -->
<!-- > > -->
<!-- > > |order|action . . . . . . |command . . . . . . . . . . . . . . . . . . . | -->
<!-- > > |-----|-------------------|----------------------------------------------| -->
<!-- > > |1    | Update local      | `git pull origin master`                     | -->
<!-- > > |2    | Make changes      | `echo 100 >> numbers.txt`                    | -->
<!-- > > |3    | Stage changes     | `git add numbers.txt`                        | -->
<!-- > > |4    | Commit changes    | `git commit -m "Added 100 to numbers.txt"`   | -->
<!-- > > |5    | Update remote     | `git push origin master`                     | -->
<!-- > > |6    | Celebrate!        | `AFK`                                        | -->
<!-- > > -->
<!-- >  -->


## Open Science

> The opposite of "open" isn't "closed".
> The opposite of "open" is "broken".
>
> --- John Wilbanks


Free sharing of information might be the ideal in science,
but the reality is often more complicated.
Normal practice today looks something like this:

*   A scientist collects some data and stores it on a machine
    that is occasionally backed up by her department.
*   She then writes or modifies a few small programs
    (which also reside on her machine)
    to analyze that data.
*   Once she has some results,
    she writes them up and submits her paper.
    She might include her data—a growing number of journals require this—but
    she probably doesn't include her code.
*   Time passes.
*   The journal sends her reviews written anonymously by a handful of other people in her field.
    She revises her paper to satisfy them,
    during which time she might also modify the scripts she wrote earlier,
    and resubmits.
*   More time passes.
*   The paper is eventually published.
    It might include a link to an online copy of her data,
    but the paper itself will be behind a paywall:
    only people who have personal or institutional access
    will be able to read it.

For a growing number of scientists,
though,
the process looks like this:

*   The data that the scientist collects is stored in an open access repository
    like [figshare](http://figshare.com/) or
    [Zenodo](http://zenodo.org), possibly as soon as it's collected,
    and given its own
    [Digital Object Identifier](https://en.wikipedia.org/wiki/Digital_object_identifier) (DOI).
    Or the data was already published and is stored in
    [Dryad](http://datadryad.org/).
*   The scientist creates a new repository on GitHub to hold her work.
*   As she does her analysis,
    she pushes changes to her scripts
    (and possibly some output files)
    to that repository.
    She also uses the repository for her paper;
    that repository is then the hub for collaboration with her colleagues.
*   When she's happy with the state of her paper,
    she posts a version to [arXiv](http://arxiv.org/)
    or some other preprint server
    to invite feedback from peers.
*   Based on that feedback,
    she may post several revisions
    before finally submitting her paper to a journal.
*   The published paper includes links to her preprint
    and to her code and data repositories,
    which  makes it much easier for other scientists
    to use her work as starting point for their own research.

This open model accelerates discovery:
the more open work is,
[the more widely it is cited and re-used](http://dx.doi.org/10.1371/journal.pone.0000308).
However,
people who want to work this way need to make some decisions
about what exactly "open" means and how to do it. You can find more on the different aspects of Open Science in [this book](http://link.springer.com/book/10.1007/978-3-319-00026-8).

This is one of the (many) reasons we teach version control.
When used diligently,
it answers the "how" question
by acting as a shareable electronic lab notebook for computational work:

*   The conceptual stages of your work are documented, including who did
    what and when. Every step is stamped with an identifier (the commit ID)
    that is for most intents and purposes unique.
*   You can tie documentation of rationale, ideas, and other
    intellectual work directly to the changes that spring from them.
*   You can refer to what you used in your research to obtain your
    computational results in a way that is unique and recoverable.
*   With a distributed version control system such as Git, the version
    control repository is easy to archive for perpetuity, and contains
    the entire history.

> **Making Code Citable**
>
> [This short guide](https://guides.github.com/activities/citable-code/) from GitHub
> explains how to create a Digital Object Identifier (DOI) for your code,
> your papers,
> or anything else hosted in a version control repository.


> **How Reproducible Is My Work?**
>
> Ask one of your labmates to reproduce a result you recently obtained
> using only what they can find in your papers or on the web.
> Try to do the same for one of their results,
> then try to do it for a result from a lab you work with.


> **How to Find an Appropriate Data Repository?**
>
> Surf the internet for a couple of minutes and check out the data repositories
> mentioned above: [Figshare](http://figshare.com/), [Zenodo](http://zenodo.org),
> [Dryad](http://datadryad.org/). Depending on your field of research, you might
> find community-recognized repositories that are well-known in your field.
> You might also find useful [these data repositories recommended by Nature](
> http://www.nature.com/sdata/data-policies/repositories).
> Discuss with your neighbor which data repository you might want to
> approach for your current project and explain why.


> **Can I Also Publish Code?**
>
> There are many new ways to publish code and to make it citable. One
> way is described [on the homepage of GitHub itself](
> https://guides.github.com/activities/citable-code/).
> Basically it's a combination of GitHub (where the code is) and Zenodo (the
> repository creating the DOI). Read through this page while being aware
> that this is only one of many ways to making your code citable.


## Licensing

When a repository with source code, a manuscript or other creative
works becomes public, it should include a file `LICENSE` or
`LICENSE.txt` in the base directory of the repository that clearly
states under which license the content is being made available. This
is because creative works are automatically eligible for intellectual
property (and thus copyright) protection. Reusing creative works
without a license is dangerous, because the copyright holders could
sue you for copyright infringement.

A license solves this problem by granting rights to others (the
licensees) that they would otherwise not have. What rights are being
granted under which conditions differs, often only slightly, from one
license to another. In practice, a few licenses are by far the most
popular, and [choosealicense.com](http://choosealicense.com/) will
help you find a common license that suits your needs.  Important
considerations include:

* Whether you want to address patent rights.
* Whether you require people distributing derivative works to also
  distribute their source code.
* Whether the content you are licensing is source code.
* Whether you want to license the code at all.

Choosing a licence that is in common use makes life easier for
contributors and users, because they are more likely to already be
familiar with the license and don't have to wade through a bunch of
jargon to decide if they're ok with it.  The [Open Source
Inititative](http://opensource.org/licenses) and [Free Software
Foundation](http://www.gnu.org/licenses/license-list.html) both
maintain lists of licenses which are good choices.

[This article][software-licensing] provides an excellent overview of
licensing and licensing options from the perspective of scientists who
also write code.

At the end of the day what matters is that there is a clear statement
as to what the license is. Also, the license is best chosen from the
get-go, even if for a repository that is not public. Pushing off the
decision only makes it more complicated later, because each time a new
collaborator starts contributing, they, too, hold copyright and will
thus need to be asked for approval once a license is chosen.

> **Can I Use Open License?**
>
> Find out whether you are allowed to apply an open license to your software.
> Can you do this unilaterally,
> or do you need permission from someone in your institution?
> If so, who?


> **What licenses have I already accepted?**
>
> Many of the software tools we use on a daily basis (including in this workshop) are
> released as open-source software. Pick a project on GitHub from the list below, or
> one of your own choosing. Find its license (usually in a file called `LICENSE` or
> `COPYING`) and talk about how it restricts your use of the software. Is it one of
> the licenses discussed in this session? How is it different?
> - [Git](https://github.com/git/git), the source-code management tool
> - [CPython](https://github.com/python/cpython), the standard implementation of the Python language
> - [Jupyter](https://github.com/jupyter), the project behind the web-based Python notebooks we'll be using
> - [EtherPad](https://github.com/ether/etherpad-lite), a real-time collaborative editor


[software-licensing]: http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1002598

## Citation
You may want to include a file called `CITATION` or `CITATION.txt`
that describes how to reference your project;
the [one for Software
Carpentry](https://github.com/swcarpentry/website/blob/gh-pages/CITATION)
states:

```
To reference Software Carpentry in publications, please cite both of the following:

Greg Wilson: "Software Carpentry: Getting Scientists to Write Better
Code by Making Them More Productive".  Computing in Science &
Engineering, Nov-Dec 2006.

Greg Wilson: "Software Carpentry: Lessons Learned". arXiv:1307.5448,
July 2013.

@article{wilson-software-carpentry-2006,
    author =  {Greg Wilson},
    title =   {Software Carpentry: Getting Scientists to Write Better Code by Making Them More Productive},
    journal = {Computing in Science \& Engineering},
    month =   {November--December},
    year =    {2006},
}

@online{wilson-software-carpentry-2013,
  author      = {Greg Wilson},
  title       = {Software Carpentry: Lessons Learned},
  version     = {1},
  date        = {2013-07-20},
  eprinttype  = {arxiv},
  eprint      = {1307.5448}
}
```


## Hosting

The second big question for groups that want to open up their work is where to
host their code and data.  One option is for the lab, the department, or the
university to provide a server, manage accounts and backups, and so on.  The
main benefit of this is that it clarifies who owns what, which is particularly
important if any of the material is sensitive (i.e., relates to experiments
involving human subjects or may be used in a patent application).  The main
drawbacks are the cost of providing the service and its longevity: a scientist
who has spent ten years collecting data would like to be sure that data will
still be available ten years from now, but that's well beyond the lifespan of
most of the grants that fund academic infrastructure.

Another option is to purchase a domain and pay an Internet service provider
(ISP) to host it.  This gives the individual or group more control, and
sidesteps problems that can arise when moving from one institution to another,
but requires more time and effort to set up than either the option above or the
option below.

The third option is to use a public hosting service like
[GitHub](http://github.com), [GitLab](http://gitlab.com),
[BitBucket](http://bitbucket.org), or [SourceForge](http://sourceforge.net).
Each of these services provides a web interface that enables people to create,
view, and edit their code repositories.  These services also provide
communication and project management tools including issue tracking, wiki pages,
email notifications, and code reviews.  These services benefit from economies of
scale and network effects: it's easier to run one large service well than to run
many smaller services to the same standard.  It's also easier for people to
collaborate.  Using a popular service can help connect your project with
communities already using the same service.

As an example, Software Carpentry [is on
GitHub]({{ swc_github }}) where you can find the [source for this
page]({{page.root}}/_episodes/13-hosting.md).
Anyone with a GitHub account can suggest changes to this text.

Using large, well-established services can also help you quickly take advantage
of powerful tools.  One such tool, continuous integration (CI), can
automatically run software builds and tests whenever code is committed or pull
requests are submitted.  Direct integration of CI with an online hosting service
means this information is present in any pull request, and helps maintain code
integrity and quality standards.  While CI is still available in self-hosted
situations, there is much less setup and maintenance involved with using an
online service.  Furthermore, such tools are often provided free of charge to
open source projects, and are also available for private repositories for a fee.

> **Institutional Barriers**
>
> Sharing is the ideal for science,
> but many institutions place restrictions on sharing,
> for example to protect potentially patentable intellectual property.
> If you encounter such restrictions,
> it can be productive to inquire about the underlying motivations
> either to request an exception for a specific project or domain,
> or to push more broadly for institutional reform to support more open science.


> **Can My Work Be Public?**
>
> Find out whether you are allowed to host your work openly on a public forge.
> Can you do this unilaterally,
> or do you need permission from someone in your institution?
> If so, who?


> **Where Can I Share My Work?**
>
> Does your institution have a repository or repositories that you can
> use to share your papers, data and software? How do institutional repositories
> differ from services like [arXiV](http://arxiv.org/), [figshare](http://figshare.com/) and [GitHub](http://github.com/)?


## Using Git from RStudio

Since version control is so useful when developing scripts, RStudio has built-in
integration with Git. There are some more obscure Git features that you still
need to use the command-line for, but RStudio has a nice interface for most
common operations.

RStudio let's you create a [project][rstudio-projects] associated with
a given directory. This is a way to keep track of related files. One
of the way to keep track of them is via version control! To get
started using RStudio for version control, let's make a new project:

![](fig/RStudio_screenshot_newproject.png)

This will pop up a window asking us how we want to create the project. We have
some options here. Let's say that we want to use RStudio with the planets
repository that we already made. Since that repository lives in a directory on
our computer, we'll choose "existing directory":

![](fig/RStudio_screenshot_existingdirectory.png)

> **Do You See a "Version Control" Option?**
>
> Although we're not going to use it here, there should be a "version control"
> option on this menu. That is what you would click on if you wanted to
> create a project on your computer by cloning a repository from github.
> If that option is not present, it probably means that RStudio doesn't know
> where your Git executable is. See
> [this page](https://stat545-ubc.github.io/git03_rstudio-meet-git.html)
> for some debugging advice. Even if you have Git installed, you may need
> to accept the XCode license if you are using MacOSX.


Next, RStudio will ask which existing directory we want to use. Click "browse"
to navigate to the correct directory on your computer, then click "create
project":

![](fig/RStudio_screenshot_navigateexisting.png)

Ta-da! Now you have an R project containing your repository. Notice the
vertical "Git" menu that is now on the menu bar. This means RStudio has
recognized that this directory is a git repository, so it's giving you tools
to use Git:

![](fig/RStudio_screenshot_afterclone.png)

To edit the files in your repository, you can click on them from the panel in
the lower right. Let's add some more information about pluto:

![](fig/RStudio_screenshot_editfiles.png)

We can also use RStudio to commit these changes. Go to the git menu and click
"commit":

![](fig/RStudio_screenshot_commit.png)

This will bring up a screen where you can select which files to commit (check
the boxes in the "staged" column) and enter a commit message (in the upper
right). The icons in the "status" column indicate the current status of each
file. You can also see the changes to each file by clicking on its name. Once
everything is the way you want it, click "commit":

![](fig/RStudio_screenshot_review.png)

You can push these changes by selecting "push" from the Git menu. There are
also options there to pull from a remote version of the repository, and view
the history:

![](fig/RStudio_screenshot_history.png)

> **Are the Push/Pull Commands Grayed Out?**
>
> If this is the case, it generally means that RStudio doesn't know the
> location of any other version of your repository (i.e. the one on GitHub).
> To fix this, open a terminal to the repository and enter the command:
> `git push -u origin master`. Then restart RStudio.


If we click on "history", we can see a pretty graphical version of what
`git log` would tell us:

![](fig/RStudio_screenshot_viewhistory.png)

RStudio creates some files that is uses to keep track of your project. You
generally don't want to track these, so adding them to your .gitignore file
is a good idea:

![](fig/RStudio_screenshot_gitignore.png)

There are many more features buried in the RStudio git interface, but these
should be enough to get you started!

[rstudio-projects]: https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects

## Learn more

1. "Happy Git with R": a user friendly introduction to Git and GitHub from R users, by Jenny Bryan. The book is freely available online: http://happygitwithr.com
