WD_LOC=~/repo/wd
BR_LOC=~/repo/bare

BARE_REPO_KING=king.git
BARE_REPO_SLAVE_1=slave1.git
BARE_REPO_SLAVE_2=slave2.git
CLONE_KING=king
CLONE_SLAVE1=slave1
CLONE_SLAVE2=slave2

rm -rf $WD_LOC/$CLONE_KING
rm -rf $WD_LOC/$CLONE_SLAVE1
rm -rf $WD_LOC/$CLONE_SLAVE2
rm -rf $BR_LOC/$BARE_REPO_KING
rm -rf $BR_LOC/$BARE_REPO_SLAVE_1
rm -rf $BR_LOC/$BARE_REPO_SLAVE_2

	### BARE INITIALIZATION ###
	cd $BR_LOC
		git init --bare $BARE_REPO_KING
		git init --bare $BARE_REPO_SLAVE_1
		git init --bare $BARE_REPO_SLAVE_2
	### CLONE INITIALIZATION ###
	cd $WD_LOC
		git clone $BR_LOC/$BARE_REPO_KING
                git clone $BR_LOC/$BARE_REPO_SLAVE_1
                cd $WD_LOC/$CLONE_SLAVE1
                	echo "Initial commit slave1" >> readme.txt
                	git add readme.txt
                	git commit -m "Initial commit slave1"
                	git push origin master
		git clone $BR_LOC/$BARE_REPO_SLAVE_2
                cd $WD_LOC/$CLONE_SLAVE2
                        echo "Initial commit slave2" >> readme.txt
                        git add readme.txt
                        git commit -m "Initial commit slave2"
                        git push origin master
	### KING SETUP ###
	cd $WD_LOC/$CLONE_KING
		echo "Initial commit" >> readme.txt
		git add readme.txt
		git commit -m "Initial commit"
		git push origin master
		git remote add slave1 $BR_LOC/$BARE_REPO_SLAVE_1
		git remote add slave2 $BR_LOC/$BARE_REPO_SLAVE_2
			### Creating local copy of branch slave1 ###

		echo "                     "
		git checkout -b slave1_master slave1/master
		git branch -a -vv
			### creating new commit on slave1_master branch ###
		echo "commit Slave1" >> slave1.txt
		git add slave1.txt
                git commit -m "commit slave1"
                git push slave1 master
			### Creating local copy of branch slave2 ###
                echo "      "
		git checkout -b slave2_master slave2/master
                git branch -a -vv
			### creating new commit on slave2_master branch ###
		echo "commit Slave2" >> slave2.txt
                git add slave2.txt
                git commit -m "commit slave2"
                git push slave2 master
		git checkout master

	### CHECKING RESULT ###
        cd $WD_LOC/$CLONE_SLAVE1
		echo "SLAVE1"
		cat slave1.txt
		ls -a
	cd $WD_LOC/$CLONE_SLAVE2
                echo "SLAVE2"
                cat slave2.txt
		ls -a
