import subprocess

# Start the first program
program1 = subprocess.Popen(['python', 'broker.py'])

# Start the second program
program2 = subprocess.Popen(['python', 'sub.py'])

# Wait for both programs to finish
program1.wait()
program2.wait()

print('Both programs have finished.')