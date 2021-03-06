#!/bin/bash

merge() {
    git checkout develop
    git merge --no-ff $1
    git push origin develop
    git checkout master
    git merge --no-ff develop
    git push origin master
    echo "And we are done! Yey!"
}

check_branch() {
    if [ `git branch --list $1` ]; then
        echo "Merging $1 with master and develop..."

        merge $1
    else
        echo "Branch ($1) doesn't exist. Exiting now..."
        exit 1
    fi
}

# Locate the help argument before continuing
for arg in "$@"
do
    if [ $arg = "-h" ] || [ $arg = "--help" ]; then
        echo "Usage: git-merge-master <branch name>..."
        exit 0
    fi
done

# Now process the input
if [ "$#" -eq 0 ]; then
    read -p "What branch to merge with master and develop? " branch
    check_branch $branch
else
    git checkout master
    for branch in "$@"
    do
        check_branch $branch
    done
fi

exit 0
