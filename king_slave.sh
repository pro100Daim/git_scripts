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

	cd $BR_LOC
		git init --bare $BARE_REPO_KING
		git init --bare $BARE_REPO_SLAVE_1
		git init --bare $BARE_REPO_SLAVE_2
	cd $WD_LOC
		git clone $BR_LOC/$BARE_REPO_KING

	cd $WD_LOC/$CLONE_KING
		echo "Initial commit" >> readme.txt
		git add readme.txt
		git commit -m "Initial commit"
		git push origin master
		git remote add slave1 $BR_LOC/$BARE_REPO_SLAVE_1
		git remote add slave2 $BR_LOC/$BARE_REPO_SLAVE_2
		git checkout slave1/master
		echo "commit Slave1" >> slave1.txt
		git add slave1.txt
                git commit -m "commit slave1"
                git push slave1 master
                git checkout slave2/master
                echo "commit Slave2" >> slave2.txt
                git add slave2.txt
                git commit -m "commit slave2"
                git push slave2 master
		git checkout origin/master

	cd $WD_LOC
                git clone $BR_LOC/$BARE_REPO_SLAVE_1
		git clone $BR_LOC/$BARE_REPO_SLAVE_2
        cd $WD_LOC/$CLONE_SLAVE1
		echo "SLAVE1"
		cat slave1.txt
		ls -a
	cd $WD_LOC/$CLONE_SLAVE2
                echo "SLAVE2"
                cat slave2.txt
		ls -a
