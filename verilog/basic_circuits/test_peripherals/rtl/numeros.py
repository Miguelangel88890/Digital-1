import os

print(os.getcwd())
W = 16
H = 16

ON  = "FFFF00"
OFF = "000000"

# Matriz apagada
img = [[OFF for _ in range(W)] for _ in range(H)]

# ---------- Dibujar "2" a la izquierda ----------

# Barra superior
for x in range(2, 8):
    img[2][x] = ON

# Lado derecho superior
for y in range(3, 8):
    img[y][7] = ON

# Barra central
for x in range(2, 8):
    img[7][x] = ON

# Lado izquierdo inferior
for y in range(8, 13):
    img[y][2] = ON

# Barra inferior
for x in range(2, 8):
    img[13][x] = ON


# ---------- Dibujar "2" a la derecha ----------

# Barra superior
for x in range(10, 15):
    img[2][x] = ON

# Lado derecho superior
for y in range(3, 8):
    img[y][14] = ON

# Barra central
for x in range(10, 15):
    img[7][x] = ON

# Lado izquierdo inferior
for y in range(8, 13):
    img[y][10] = ON

# Barra inferior
for x in range(10, 15):
    img[13][x] = ON
# ---------- Rotar 90° horario ----------
img = [list(fila) for fila in zip(*img[::-1])]
img = [list(fila) for fila in zip(*img[::-1])]
img = [list(fila) for fila in zip(*img[::-1])]
# Reflejar horizontalmente
img = [fila[::-1] for fila in img]
img = [list(fila) for fila in zip(*img[::-1])]
img = [list(fila) for fila in zip(*img[::-1])]

# ---------- Guardar en zig-zag ----------
with open("display_test.hex", "w") as f:
    for y in range(H):
        fila = img[y]
        if y % 2 == 1:          # filas impares al revés
            fila = fila[::-1]
        for color in fila:
            f.write(color + "\n")