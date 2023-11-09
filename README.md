# Verilog Project: Development of an 8-Bit RISC-V Processor

## Instruções R:
- **add:** `rd = rs1 + rs2` (Exemplo: Se rs1 = 5 e rs2 = 7, então rd = 12).
- **sub:** `rd = rs1 - rs2` (Exemplo: Se rs1 = 10 e rs2 = 3, então rd = 7).
- **and:** `rd = rs1 AND rs2` (Exemplo: Se rs1 = 1101 e rs2 = 1010, então rd = 1000).
- **or:** `rd = rs1 OR rs2` (Exemplo: Se rs1 = 1101 e rs2 = 1010, então rd = 1111).
- **xor:** `rd = rs1 XOR rs2` (Exemplo: Se rs1 = 1101 e rs2 = 1010, então rd = 0111).

## Instruções I:
- **ori:** `rd = rs1 OR imm` (Exemplo: Se rs1 = 1010 e imm = 0011, então rd = 1011).
- **slti:** `rd = (rs1 < imm) ? 1 : 0` (Exemplo: Se rs1 = 5 e imm = 8, então rd = 1).
- **addi:** `rd = rs1 + imm` (Exemplo: Se rs1 = 7 e imm = 3, então rd = 10).

## Instruções Load/Store:
- **lw:** `rd = Mem[rs1 + imm]` (Exemplo: Se rs1 = 1000 e imm = 0011, então rd recebe o valor armazenado na posição de memória 1000 + 3).
- **sw:** `Mem[rs1 + imm] = rs2` (Exemplo: Se rs1 = 1010, imm = 0100 e rs2 = 1101, então o valor 1101 é armazenado na posição de memória 1010 + 4).

## Instruções Branch:
- **beq:** `if (rs1 == rs2) pc = pc + imm` (Exemplo: Se rs1 = 6, rs2 = 6 e imm = 2, então haverá um salto condicional).
- **bne:** `if (rs1 != rs2) pc = pc + imm` (Exemplo: Se rs1 = 5, rs2 = 3 e imm = 3, então haverá um salto condicional).
- **blt:** `if (rs1 < rs2) pc = pc + imm` (Exemplo: Se rs1 = 3, rs2 = 5 e imm = 2, então haverá um salto condicional).
- **bge:** `if (rs1 >= rs2) pc = pc + imm` (Exemplo: Se rs1 = 8, rs2 = 6 e imm = 3, então haverá um salto condicional).

## Instruções Jump:
- **jal:** `rd = pc + 4; pc = pc + imm` (Exemplo: Se imm = 8, então rd receberá o valor do próximo endereço de instrução e haverá um salto incondicional).
- **jalr:** `rd = pc + 4; pc = rs1 + imm` (Exemplo: Se rs1 = 12 e imm = 2, então rd receberá o valor do próximo endereço de instrução e haverá um salto incondicional para o endereço 12 + 2).

## Instruções Shift:
- **sll:** `rd = rs1 << rs2` (Exemplo: Se rs1 = 6 e rs2 = 2, então rd = 24).
- **srl:** `rd = rs1 >> rs2` (Exemplo: Se rs1 = 16 e rs2 = 3, então rd = 2).
- **slli:** `rd = rs1 << imm` (Exemplo: Se rs1 = 5 e imm = 2, então rd = 20).
- **srli:** `rd = rs1 >> imm` (Exemplo: Se rs1 = 32 e imm = 3, então rd = 4).
