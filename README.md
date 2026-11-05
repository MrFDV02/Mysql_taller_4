# 🗄️ Taller MySQL

Cinco bases de datos relacionales en **MySQL 8**, cada una con su script de creación, consultas DQL y diagrama entidad-relación.

## 📦 Proyectos

| Proyecto | Dominio | Tablas |
|---|---|---|
| 🎧 **helpdesk_pro** | Mesa de ayuda: tickets, técnicos, asignaciones | 8 |
| 💻 **assetcontrol** | Control de activos, asignaciones y mantenimientos | 7 |
| 🛒 **comprafacil** | Solicitudes, órdenes de compra y recepciones | 9 |
| 🎓 **talenttrack** | Cursos, ediciones, matrículas y certificados | 9 |
| 🏢 **spacebook** | Reserva de salas, recursos y participantes | 8 |

## 🗂️ Estructura

~~~
Mysql_taller_4/
├── README.md
├── helpdesk_pro/
│   ├── helpdesk_base_datos.sql
│   ├── helpdesk_consultas.sql
│   └── helpdesk_pro.png
├── assetcontrol/
│   ├── assetcontrol_base_datos.sql
│   ├── assetcontrol_consultas.sql
│   └── assetcontrol.png
├── comprafacil/
│   ├── comprafacil_base_datos.sql
│   ├── comprafacil_consultas.sql
│   └── comprafacil.png
├── talenttrack/
│   ├── talenttrack_base_datos.sql
│   ├── talenttrack_consultas.sql
│   └── talenttrack.png
└── spacebook/
    ├── spacebook_base_datos.sql
    ├── SpaceBook_consultas.sql
    └── spacebook.png
~~~

- `*_base_datos.sql`: crea la base, las tablas y los datos de prueba.
- `*_consultas.sql`: las 20 consultas DQL de cada proyecto.
- `*.png`: diagrama entidad-relación.

## ✅ Requisitos

- **MySQL 8.0.16 o superior** (necesario para las restricciones `CHECK` y las columnas generadas).
- Un cliente SQL (**DBeaver**, MySQL Workbench) o la terminal `mysql`.
- **Git** (solo si vas a clonar el repositorio).

Instalar MySQL si no lo tienes:

~~~bash
# Ubuntu / Debian / WSL
sudo apt update && sudo apt install -y mysql-server
sudo service mysql start

# macOS (Homebrew)
brew install mysql && brew services start mysql

# Windows: descarga el instalador desde https://dev.mysql.com/downloads/installer/
~~~

## 📥 1. Obtener el proyecto

### 👤 Sin Git (descarga directa)

1. Entra a https://github.com/MrFDV02/Mysql_taller_4
2. Pulsa el botón verde **Code** y luego **Download ZIP**.
3. Descomprime el archivo. Se crea la carpeta `Mysql_taller_4-main`.

### 🧑‍💻 Con Git

Elige **una** de estas formas:

~~~bash
# HTTPS (la más simple, no requiere configuración)
git clone https://github.com/MrFDV02/Mysql_taller_4.git

# SSH (si ya tienes una llave SSH registrada en GitHub)
git clone git@github.com:MrFDV02/Mysql_taller_4.git

# GitHub CLI (si tienes `gh` instalado y sesión iniciada)
gh repo clone MrFDV02/Mysql_taller_4
~~~

Luego entra a la carpeta:

~~~bash
cd Mysql_taller_4
~~~

Para clonar solo la última versión, sin historial (más rápido):

~~~bash
git clone --depth 1 https://github.com/MrFDV02/Mysql_taller_4.git
~~~

Para colaborar con cambios: haz un fork (`gh repo fork MrFDV02/Mysql_taller_4 --clone`), trabaja en una rama (`git checkout -b mi-cambio`) y abre un Pull Request.

## 🗄️ 2. Crear las bases de datos

> ⚠️ Cada `*_base_datos.sql` hace `DROP DATABASE IF EXISTS` y **recrea** su base desde cero. Si ya tienes una base con ese nombre, perderás sus datos.

### 👤 Con DBeaver (interfaz gráfica)

1. Abre DBeaver y crea la conexión: **Database > New Database Connection > MySQL**, servidor `localhost`, puerto `3306`, con tu usuario y contraseña.
2. Menú **File > Open File...** y elige `helpdesk_pro/helpdesk_base_datos.sql`.
3. Con la conexión activa, ejecuta todo el script con **Alt + X** (*Execute SQL Script*), no con Ctrl + Enter.
4. Haz clic derecho sobre **Databases** y pulsa **Refresh** (F5): aparece `helpdesk_pro`.
5. Repite los pasos 2 a 4 con las otras 4 bases.

### 🧑‍💻 Con terminal

Desde la raíz del repositorio. Elige según cómo entres a MySQL:

~~~bash
# Opción A: Ubuntu / WSL (root entra por socket, sin contraseña)
sudo mysql < helpdesk_pro/helpdesk_base_datos.sql
sudo mysql < assetcontrol/assetcontrol_base_datos.sql
sudo mysql < comprafacil/comprafacil_base_datos.sql
sudo mysql < talenttrack/talenttrack_base_datos.sql
sudo mysql < spacebook/spacebook_base_datos.sql

# Opción B: cualquier sistema, con usuario y contraseña
mysql -u root -p < helpdesk_pro/helpdesk_base_datos.sql
mysql -u root -p < assetcontrol/assetcontrol_base_datos.sql
mysql -u root -p < comprafacil/comprafacil_base_datos.sql
mysql -u root -p < talenttrack/talenttrack_base_datos.sql
mysql -u root -p < spacebook/spacebook_base_datos.sql
~~~

En Windows (PowerShell o CMD) usa `source`, porque `<` no funciona en PowerShell:

~~~bash
mysql -u root -p -e "source C:/ruta/Mysql_taller_4/helpdesk_pro/helpdesk_base_datos.sql"
~~~

## 🔍 3. Ejecutar las consultas

### 👤 Con DBeaver

Abre el archivo `*_consultas.sql` con **File > Open File...** y ejecuta una consulta a la vez: pon el cursor sobre ella y pulsa **Ctrl + Enter**. Para correr todo el archivo, usa **Alt + X**.

### 🧑‍💻 Con terminal

~~~bash
sudo mysql < helpdesk_pro/helpdesk_consultas.sql
sudo mysql < assetcontrol/assetcontrol_consultas.sql
sudo mysql < comprafacil/comprafacil_consultas.sql
sudo mysql < talenttrack/talenttrack_consultas.sql
sudo mysql < spacebook/SpaceBook_consultas.sql
~~~

(Cambia `sudo mysql` por `mysql -u root -p` si no usas Ubuntu/WSL.)

## 🧪 4. Verificar la instalación

Entra a MySQL (`sudo mysql` o `mysql -u root -p`) y ejecuta:

~~~sql
SELECT table_schema AS base, COUNT(*) AS tablas
FROM information_schema.tables
WHERE table_schema IN ('helpdesk_pro','assetcontrol','comprafacil','talenttrack','spacebook')
GROUP BY table_schema;
~~~

Debes ver 5 filas con esta cantidad de tablas: `helpdesk_pro` 8, `assetcontrol` 7, `comprafacil` 9, `talenttrack` 9 y `spacebook` 8.

## 🛠️ Problemas comunes

| Error | Causa y solución |
|---|---|
| `ERROR 1698 (28000): Access denied for user 'root'` | En Ubuntu/WSL, `root` entra por socket: usa `sudo mysql` sin `-u root -p`. |
| `ERROR 1049: Unknown database` | Falta correr el `*_base_datos.sql` de esa base antes de sus consultas. |
| `Public Key Retrieval is not allowed` (DBeaver) | En la conexión, pestaña **Driver properties**, pon `allowPublicKeyRetrieval=true`. |
| `ERROR 3819: Check constraint ... is violated` o error en `CHECK` | Tu MySQL es anterior a 8.0.16. Actualiza. |
| `Can't connect to local MySQL server` | El servicio está apagado: `sudo service mysql start` (Linux/WSL) o `brew services start mysql` (macOS). |

## 🧰 Stack

MySQL 8 · DBeaver · WSL (Ubuntu) · Git

## 👤 Autor

**Nicolas Fandiño** — [@MrFDV02](https://github.com/MrFDV02)
