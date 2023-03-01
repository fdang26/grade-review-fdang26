CPATH=".;../lib/hamcrest-core-1.3.jar;../lib/junit-4.13.2.jar"

score="Fail"
# removes the previous repo
rm -rf student-submission
# clones the new submission provided in the first argument
git clone -q $1 student-submission
echo 'Finished cloning'

# Check if file exists in new cloned repo
if [[ ! -f student-submission/ListExamples.java ]]
then
    echo "ListExamples.java not found"
    echo $score
    exit
else
    echo "ListExamples.java found"
    # get the student code and your test .java file 
    # into the same directory
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
    echo $score
    exit
fi
# Run the tester on the implementation
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > result.txt

grep -i "Failure" result.txt > failure_ct.txt
cmd=$(wc -l failure_ct.txt | awk '{print $1}')

if [[ ! $cmd -gt 0 ]]
then
    score="Pass"
fi

echo $score

