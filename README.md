# 🗄️ Taller MySQL

Cinco bases de datos relacionales en **MySQL 8**, cada una con su modelo, consultas DQL y diagrama entidad-relación.

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
.
├── assetcontrol/
├── comprafacil/
├── helpdesk_pro/
├── spacebook/
└── talenttrack/
~~~

Cada carpeta incluye sus consultas `.sql` y la captura del diagrama (`.png`).

## 🚀 Cómo ejecutarlo

~~~bash
# 1. Crear la base y cargar los datos (ejemplo: spacebook)
sudo mysql < spacebook/spacebook_base_datos.sql

# 2. Correr las consultas
sudo mysql < spacebook/SpaceBook_consultas.sql
~~~

## 🧰 Stack

MySQL 8 · DBeaver · WSL (Ubuntu) · Git

## 👤 Autor

**Nicolas Fandiño** — [@MrFDV02](https://github.com/MrFDV02)
