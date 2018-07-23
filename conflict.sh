WD_LOC=~/repo/wd
BR_LOC=~/repo/bare

BARE_REPO=conflict_bare.git
CLONE_REPO_1=clone_repo1
CLONE_REPO_2=clone_repo2

rm -rf $WD_LOC/$CLONE_REPO_1
rm -rf $WD_LOC/$CLONE_REPO_2
rm -rf $BR_LOC/$BARE_REPO

	cd $BR_LOC
		git init --bare $BARE_REPO

	cd $WD_LOC
		git clone $BR_LOC/$BARE_REPO clone_repo1
		git clone $BR_LOC/$BARE_REPO clone_repo2

	cd $WD_LOC/$CLONE_REPO_1
		echo "Я клон 1" >> readme.txt
		git add readme.txt
		git commit -m "add clone1"
		git push origin master

        cd $WD_LOC/$CLONE_REPO_2
                echo "Я клон 2" >> readme.txt
                git add readme.txt
		git commit -m "add clone2"
		git push origin master
