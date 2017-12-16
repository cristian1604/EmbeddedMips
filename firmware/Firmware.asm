# Set destination registers with 0
addi $s0, $0, 0
addi $s1, $0, 0

inicio:

# READ FIRST CHAR
esperar0:
lw $t0, 0xffffff16
beq $t0, $0, leer0
j esperar0
leer0:
lw $s0, 0xffffff15
sw $s0, 0xffffff15

# Substract 48 to convert ASCII to decimal value
addi $t0, $t0, 48
sub $s0, $s0, $t0

# READ SECOND CHAR
esperar1:
lw $t0, 0xffffff16
beq $t0, $0, leer1
j esperar1
leer1:
lw $s1, 0xffffff15
sw $s1, 0xffffff15

# Substract 48 to convert ASCII to decimal value
addi $t0, $t0, 48
sub $s1, $s1, $t0

# Multiply by 10 the first char and add the second  (A*10+B)

addi $t0, $0, 0
addi $t1, $0, 9
add $t2, $0, $s0
multiplicar1:
beq $t0, $t1, continuar1
addi $t0, $t0, 1
add $s0, $s0, $t2
j multiplicar1
continuar1:
add $s0, $s0, $s1
# Now in $s0 we have the number with two digits

# Now I need read the operator

# ---------- READ OPERATOR -----------
esperar_operador:
lw $t0, 0xffffff16
beq $t0, $0, leer_operador
j esperar_operador
leer_operador:
lw $t7, 0xffffff15

# VALIDATE OPERATOR
addi $t0, $0, 42           # char *
beq $t7, $t0, validado     # multiply
addi $t0, $0, 43           # char +
beq $t7, $t0, validado     # sum
addi $t0, $0, 45           # char -
beq $t7, $t0, validado     # substract
j esperar_operador

validado:
sw $t7, 0xffffff15
# --------- END READ & VALIDATE OPERATOR ------------

# READ THIRD CHAR
esperar2:
lw $t0, 0xffffff16
beq $t0, $0, leer2
j esperar2
leer2:
lw $s1, 0xffffff15
sw $s1, 0xffffff15

# Substract 48 to convert ASCII to decimal value
addi $t0, $t0, 48
sub $s1, $s1, $t0


# READ FOURTH CHAR
esperar3:
lw $t0, 0xffffff16
beq $t0, $0, leer3
j esperar3
leer3:
lw $s2, 0xffffff15
sw $s2, 0xffffff15

# Substract 48 to convert ASCII to decimal value
addi $t0, $t0, 48
sub $s2, $s2, $t0

# Multiply by 10 the third char and sum the fourth  (A*10+B)
addi $t0, $0, 0
addi $t1, $0, 9
add $t2, $0, $s1
multiplicar2:
beq $t0, $t1, continuar2
addi $t0, $t0, 1
add $s1, $t2, $s1
j multiplicar2
continuar2:
add $s1, $s1, $s2
# So we have in $s1 the second number (with two digits)

#------------  CALL THE SELECTED ROUTINE ------------
addi $t0, $0, 42                 # char *
beq $t7, $t0, op_multiplica      # multiply
addi $t0, $0, 43                 # char +
beq $t7, $t0, op_suma            # sum
addi $t0, $0, 45                 # char -
beq $t7, $t0, op_resta           # substract


# ----------- MULTIPLY ROUTINE --------------
# If I want to do A*B, i can add B times A
op_multiplica:
addi $t0, $0, 0
addi $s2, $0, 0
multiplicar3:
beq $t0, $s1, fin_multiplica
addi $t0, $t0, 1
add $s2, $s2, $s0
j multiplicar3
fin_multiplica:
j op_bcd
# ----------- END MULTIPLY ROUTINE -----------

# ----------- ADDER ROUTINE --------------
op_suma:
add $s2, $s0, $s1
j op_bcd
# ----------- END ADDER ROUTINE -----------

# ----------- SUBSTRACT ROUTINE --------------
op_resta:
sub $s2, $s0, $s1
j op_bcd
# ----------- END SUBSTRACT ROUTINE -----------

op_bcd:
# READ ENTER KEY (really I wait for any keystroke)
esperar4:
lw $t0, 0xffffff16
beq $t0, $0, leer4
j esperar4
leer4:
lw $t0, 0xffffff15

# Now I will separate the result on their digits.
# I will left this block in spanish. The algorithm is very simple
#---------------- INICIO BCD ----------------
addi $s0, $0, 1 
addi $t0, $0, 1000
addi $t1, $0, 100
addi $t2, $0, 10
addi $t4, $0, 0 # Contador unidad de mil
addi $t5, $0, 0 # Contador centena
addi $t6, $0, 0 # Contador decena
addi $t7, $0, 0 # Contador unidad

unidad_de_mil:
slt $s4, $s2, $t0  # Mi numero es menor a 1000?
beq $s0, $s4, centena
addi $t4, $t4, 1
sub $s2, $s2, $t0
j unidad_de_mil

centena:

slt $s4, $s2, $t1
beq $s4, $s0, decena
addi $t5, $t5, 1
sub $s2, $s2, $t1
j centena

decena:

slt $s4, $s2, $t2
beq $s4, $s0, unidad
addi $t6, $t6, 1
sub $s2, $s2, $t2
j decena

unidad:
add $t7, $0, $s2

#---------------- END BCD -------------------

addi $t3, $0, 0xffffff3d  # ASCII del caracter de igual =
sw $t3, 0xffffff15  # Escribe =

addi $t4, $t4, 48
addi $t5, $t5, 48
addi $t6, $t6, 48
addi $t7, $t7, 48

sw $t4, 0xffffff15  # Escribe ud de mil
sw $t5, 0xffffff15  # Escribe centena
sw $t6, 0xffffff15  # Escribe decena
sw $t7, 0xffffff15  # Escribe unidad

addi $t1, $0, 0xffffff0d  # ASCII del Carriage Return
sw $t1, 0xffffff15  # Escribe CR
addi $t2, $0, 0xffffff0a  # ASCII de New Line Feed
sw $t2, 0xffffff15  # Escribe NLF


j inicio

