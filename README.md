# ICS3203-CAT2-Assembly-Chiman-Garang-Diing-149912
## Repository Overview
This repository contains solutions to the CAT 2 tasks for ICS3203 Assembly Programming. Each task demonstrates a specific concept in assembly language programming, such as control flow, looping, subroutines, and port-based simulations.

## Tasks Overview
Task 1: Control Flow and Conditional Logic.

This program prompts the user to input a number and classifies it as POSITIVE, NEGATIVE, or ZERO. It uses conditional jumps (je, jl) to evaluate the input and an unconditional jump (jmp) to manage the program's flow. The implementation demonstrates the importance of proper branching for clarity and ease of debugging, with conditional and unconditional jumps effectively organizing the logic.

Task 2: Array Manipulation with Looping and Reversal.

This program reverses an array of integers in place without using additional memory. By employing a loop and pointers to manage array indices, elements are swapped directly. The key challenge was ensuring the loop exited correctly when the pointers met, highlighting the importance of careful pointer logic for in-place operations.

Task 3: Modular Program with Subroutines for Factorial Calculation.

This program calculates the factorial of a user-input number using a recursive subroutine. The stack is utilized to preserve and restore registers during recursion, ensuring the integrity of computations. The final result is stored in a general-purpose register. This task underscores the importance of stack management and demonstrates modular programming in assembly.

Task 4: Data Monitoring and Control Using Port-Based Simulation.

This program simulates hardware control actions such as motor start/stop and alarm activation based on sensor input. Memory locations are used to simulate sensor values, with logic determining actions based on thresholds. This task required a creative approach to emulate hardware functionality, showcasing the use of memory for simulation and ensuring program flow correctness.

## Compilation and Execution
### Prerequisites:
- NASM Assembler (`nasm`)
- Linker (e.g., `ld`)
- Linux or WSL environment

### Compile and Run Instructions:
1. Assemble the code:  
   ```bash
   nasm -f elf64 Task1_ControlFlow.asm -o Task1_ControlFlow.o

2. Link the object file:
   ```bash
   ld Task1_ControlFlow.o -o Task1_ControlFlow

3. Execute the program:
   ```bash
   ./Task1_ControlFlow


