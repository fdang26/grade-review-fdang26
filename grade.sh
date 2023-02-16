CPATH=".;../lib/hamcrest-core-1.3.jar;../lib/junit-4.13.2.jar"

score=0
# removes the previous repo
rm -rf student-submission
# clones the new submission provided in the first argument
git clone $1 student-submission
echo 'Finished cloning'

# Check if file exists in new cloned repo
if [[ ! -f student-submission/ListExamples.java ]]
then
    echo "ListExamples.java not found."
    echo "Score is" $score
    exit
else
    echo "ListExamples.java found"
    cp TestListExamples.java student-submission/
fi
# Move into the cloned repo
cd student-submission/
# Check for compile error
javac -cp $CPATH *.java
if [[ $? -eq 0 ]]
then
    echo "Compiled successfully"
else
    echo "Compile failed"
    score=0
    echo "Score is" $score
    exit
fi
# Run the tester on the implementation
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples

