# ICS3203-CAT2-Assembly-Chiman-Garang-Diing-149912
## Repository Overview
This repository contains solutions to the CAT 2 tasks for ICS3203 Assembly Programming. Each task demonstrates a specific concept in assembly language programming, such as control flow, looping, subroutines, and port-based simulations.

## Tasks Overview
1. **Control Flow and Conditional Logic:** Classify user-input numbers as POSITIVE, NEGATIVE, or ZERO.
2. **Array Manipulation:** Reverse an array in place without additional memory.
3. **Factorial Calculation:** Use a modular program with subroutines and stack-based register preservation.
4. **Data Monitoring:** Simulate control using port-based input/output.

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


