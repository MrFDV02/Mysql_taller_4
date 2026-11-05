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
.
├── helpdesk_pro/    (base_datos.sql, consultas.sql, diagrama.png)
├── assetcontrol/
├── comprafacil/
├── talenttrack/
└── spacebook/
~~~

## 🚀 Cómo ejecutarlo

> ⚠️ Cada script `_base_datos.sql` **recrea** su base de datos (hace `DROP DATABASE IF EXISTS`).

**1. Crear las 5 bases y cargar los datos**

~~~bash
sudo mysql < helpdesk_pro/helpdesk_base_datos.sql
sudo mysql < assetcontrol/assetcontrol_base_datos.sql
sudo mysql < comprafacil/comprafacil_base_datos.sql
sudo mysql < talenttrack/talenttrack_base_datos.sql
sudo mysql < spacebook/spacebook_base_datos.sql
~~~

**2. Correr las consultas de cada una**

~~~bash
sudo mysql < helpdesk_pro/helpdesk_consultas.sql
sudo mysql < assetcontrol/assetcontrol_consultas.sql
sudo mysql < comprafacil/comprafacil_consultas.sql
sudo mysql < talenttrack/talenttrack_consultas.sql
sudo mysql < spacebook/SpaceBook_consultas.sql
~~~

## 🧰 Stack

MySQL 8 · DBeaver · WSL (Ubuntu) · Git

## 👤 Autor

**Nicolas Fandiño** — [@MrFDV02](https://github.com/MrFDV02)
