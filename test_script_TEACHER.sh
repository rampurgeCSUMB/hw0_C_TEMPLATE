#!/bin/bash

# Clean up before compiling
make clean

# Compile the program using the Makefile
make

# Check if compilation was successful
if [ ! -f "./main.exe" ]; then
    echo "Compilation failed, main.exe not found."
    exit 1
fi

# Initialize counters
passed_tests=0
failed_tests=0
total_tests=0

# Loop through all input files in the input directory
for input_file in input/*.txt; do
    # Increment total tests counter
    ((total_tests++))

    # Extract the base name of the file and replace 'input' with 'output' in the name
    base_name=$(basename "$input_file" .txt | sed 's/^input/output/')

    # Construct the output file path with the corrected base name
    output_file="output/${base_name}.txt"

    # Run the program with the current input file and save the output to a temporary file
    ./main.exe < "$input_file" > temp_output.txt

    # Compare the output with the corresponding output file
    if diff -qwB temp_output.txt "$output_file" >/dev/null; then
        echo "Test Case $total_tests PASSED"
        ((passed_tests++))
    else
        echo "Test Case $total_tests FAILED"
        ((failed_tests++))
    fi
done

# Display the number of passed and failed tests
echo "-------------------------------------"
echo "$passed_tests / $total_tests PASSED"
echo "$failed_tests / $total_tests FAILED"
echo "-------------------------------------"

# Clean up compiled program and temporary output file
make clean
rm temp_output.txt
