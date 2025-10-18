# 🏦 Proyecto de Testing API — OpenBank

![alt text](https://github.com/Bryan-Campuzano/Open-Bank-Automation_practice/blob/master/banner.png)

## 📘 Descripción General

Este proyecto tiene como objetivo realizar **pruebas automatizadas de la API pública de OpenBank** utilizando **Karate** para las pruebas funcionales y **Apache JMeter** para las pruebas de rendimiento.  
El propósito principal es **académico y práctico**, con el fin de comprender el ciclo completo de pruebas de una API REST: desde la validación de sus endpoints hasta la evaluación del comportamiento bajo carga.

---

## 🎯 Objetivos del Proyecto

- Comprender y aplicar metodologías de **API Testing** usando Karate.
- Evaluar el rendimiento de la API con **Apache JMeter**.
- Desarrollar un flujo automatizado que combine ambos enfoques en un entorno controlado.
- Integrar herramientas de testing en un pipeline reproducible con **Maven**.

---

## 🧰 Tecnologías y Herramientas Utilizadas

| Herramienta / Tecnología | Propósito |
|---------------------------|------------|
| 🐍 **Karate DSL** | Framework BDD para pruebas de API REST, SOAP, GraphQL y WebSocket. |
| ⚙️ **Apache JMeter** | Herramienta para pruebas de rendimiento y estrés. |
| ☕ **Java 17** | Lenguaje base para ejecutar los scripts y pruebas. |
| 📦 **Maven 3.9+** | Gestor de dependencias y ejecución del ciclo de pruebas. |
| 🧩 **JUnit 5** | Motor de ejecución de pruebas unitarias y de integración. |
| 📊 **JMeter Maven Plugin** | Automatización de las pruebas de carga dentro del ciclo de Maven. |

---

## 📁 Estructura del Proyecto

```bash
openbank-api-testing/
├── pom.xml                              # Configuración de Maven (dependencias Karate, JMeter Maven plugin)
├── README.md                            # Documentación general del proyecto y guía de ejecución
│
├── src/
│   ├── test/
│   │   ├── java/
│   │   │   └── openbank/
│   │   │       └── OpenBankRunner.java  # Ejecutor de las pruebas funcionales Karate (JUnit runner)
│   │   │
│   │   ├── resources/
│   │   │   ├── features/                # Carpeta con los escenarios funcionales (Karate)
│   │   │   │   ├── auth/
│   │   │   │   │   └── login.feature                # Casos relacionados con autenticación
│   │   │   │   ├── banks/
│   │   │   │   │   ├── list-banks.feature           # Pruebas de listado de bancos
│   │   │   │   │   └── bank-details.feature         # Validación de información de bancos
│   │   │   │   ├── atms/
│   │   │   │   │   ├── list-atms.feature            # Listado de ATMs
│   │   │   │   │   └── create-atm.feature           # Creación de ATMs (sandbox)
│   │   │   │   ├── accounts/
│   │   │   │   │   ├── list-accounts.feature        # Pruebas de cuentas del usuario
│   │   │   │   │   ├── transactions.feature         # Pruebas de transferencia simulada
│   │   │   │   │   └── transaction-history.feature  # Historial de transacciones
│   │   │   │   ├── users/
│   │   │   │   │   └── register-user.feature        # Registro y gestión de usuarios
│   │   │   │   ├── products/
│   │   │   │   │   ├── list-products.feature        # Listado de productos financieros
│   │   │   │   │   └── simulate-product.feature     # Simulaciones de productos financieros
│   │   │   │   └── common/
│   │   │   │       └── environment.feature          # Configuración global (base URL, headers, etc.)
│   │   │   │
│   │   │   └── data/
│   │   │       ├── users.json                       # Datos de prueba para login y registro
│   │   │       ├── transactions.json                # Cuerpos de request para pruebas de transferencias
│   │   │       ├── products.json                    # Datos base de productos financieros
│   │   │       └── banks.json                       # IDs de bancos de prueba
│   │   │
│   │   └── jmeter/
│   │       ├── OpenBankPerformance.jmx              # Escenario global de rendimiento (banco de performance)
│   │       ├── scenarios/
│   │       │   ├── auth-test.jmx                    # Prueba de carga en /login
│   │       │   ├── banks-test.jmx                   # Prueba de carga en /banks y /banks/{id}
│   │       │   ├── accounts-test.jmx                # Prueba de rendimiento en /accounts
│   │       │   ├── transactions-test.jmx            # Spike/Throughput test en /transactions
│   │       │   ├── history-test.jmx                 # Soak test en /transactions/history
│   │       │   ├── users-test.jmx                   # Ramp-up test en /users
│   │       │   └── products-test.jmx                # Load test en /products
│   │       └── results/
│   │           ├── csv/                             # Resultados crudos de ejecución (por escenario)
│   │           │   ├── auth-results.csv
│   │           │   ├── banks-results.csv
│   │           │   └── transactions-results.csv
│   │           └── reports/
│   │               ├── auth-report.html
│   │               ├── banks-report.html
│   │               ├── transactions-report.html
│   │               └── summary-dashboard.html        # Dashboard consolidado de rendimiento
│
└── target/
    ├── karate-reports/                              # Reportes HTML de Karate (funcionales)
    └── jmeter/                                      # Carpeta destino de resultados JMeter
        ├── results/
        └── reports/

```
---

## 🧪 Escenarios de Prueba (Functional Testing con Karate)

📌 **Definición general:**  
Los escenarios estarán diseñados para validar los endpoints públicos de OpenBank, verificando que las respuestas cumplan con los formatos esperados, códigos de estado correctos y contenido coherente.

🏷️ **Endpoints seleccionados para cubrir:**

| #  | Funcionalidad principal                       | Endpoint principal                       | Método | Descripción general |
| -- | --------------------------------------------- | ---------------------------------------- | ------- | -------------------- |
| 1  | Registro de usuario                           | `/users`                                 | POST    | Permite registrar un nuevo usuario en el sistema. |
| 2  | Autenticación e inicio de sesión               | `/login`                                 | POST    | Genera token JWT válido tras credenciales correctas. |
| 3  | Recuperación y restablecimiento de contraseña  | `/password/reset`                        | POST    | Inicia el flujo de recuperación de contraseña. |
| 4  | Consulta de bancos disponibles                 | `/banks`                                 | GET     | Retorna la lista general de bancos registrados. |
| 5  | Detalle de un banco específico                 | `/banks/{bank_id}`                       | GET     | Devuelve información detallada de un banco concreto. |
| 6  | Listado de cajeros automáticos (ATMs)          | `/banks/{bank_id}/atms`                  | GET     | Devuelve cajeros asociados al banco indicado. |
| 7  | Consulta de cuentas asociadas                  | `/accounts`                              | GET     | Retorna las cuentas vinculadas al usuario autenticado. |
| 8  | Transferencias bancarias                      | `/transactions`                          | POST    | Realiza o simula una transferencia entre cuentas. |
| 9  | Consulta de movimientos y transacciones        | `/transactions/history`                  | GET     | Lista movimientos recientes o históricos. |
| 10 | Solicitud de productos financieros             | `/products`                              | POST    | Permite solicitar productos (tarjetas, préstamos, etc.). |


### 🧩 **Escenarios definidos:**

1️⃣ Registro de Usuario — /users (POST)

| # | Escenario | Tipo de caso | Descripción / Validación esperada |
|---|------------|---------------|----------------------------------|
| 1.1 | Registro exitoso con datos válidos | Positivo | Retorna `201 Created` y datos del nuevo usuario. |
| 1.2 | Registro con email duplicado | Negativo | Devuelve `409 Conflict` con mensaje "Email already exists". |
| 1.3 | Registro con contraseña débil | Negativo | Devuelve `400 Bad Request` con mensaje de validación. |
| 1.4 | Registro sin campo obligatorio (ej. email) | Negativo | Devuelve `400 Bad Request`. |
| 1.5 | Registro con formato inválido de correo | Negativo | Devuelve `422 Unprocessable Entity`. |
| 1.6 | Registro con payload vacío | Negativo | Devuelve `400 Bad Request`. |
| 1.7 | Validar estructura de respuesta | Validación estructural | JSON contiene `user_id`, `email`, `created_at`. |
| 1.8 | Validar tiempo de respuesta < 500ms | Performance funcional | El endpoint responde rápidamente. |
| 1.9 | Registro y verificación de existencia posterior | Flujo | El usuario registrado puede autenticarse luego. |
| 1.10 | Registro masivo (5 usuarios consecutivos) | Stress funcional | Todos los registros devuelven 201 sin errores. |

2️⃣ Autenticación — /login (POST)

| # | Escenario | Tipo de caso | Descripción / Validación esperada |
|---|------------|---------------|----------------------------------|
| 2.1 | Inicio de sesión válido | Positivo | Retorna `200 OK` y token JWT válido. |
| 2.2 | Credenciales incorrectas | Negativo | Retorna `401 Unauthorized`. |
| 2.3 | Usuario inexistente | Negativo | Retorna `404 Not Found`. |
| 2.4 | Contraseña vacía | Negativo | Retorna `400 Bad Request`. |
| 2.5 | Email con formato incorrecto | Negativo | Retorna `422 Unprocessable Entity`. |
| 2.6 | Token devuelto tiene formato JWT válido | Validación estructural | Token contiene header, payload y firma. |
| 2.7 | Tiempo de respuesta < 400 ms | Performance funcional | Autenticación rápida. |
| 2.8 | Intentos fallidos múltiples bloquean usuario | Seguridad | Tras 5 intentos fallidos retorna `429 Too Many Requests`. |
| 2.9 | Login después de bloqueo temporal | Flujo | Devuelve `200 OK` tras periodo de espera. |
| 2.10 | Reautenticación con token expirado | Negativo | Retorna `403 Forbidden`. |

3️⃣ Recuperación de Contraseña — /password/reset (POST)

| # | Escenario | Tipo de caso | Descripción / Validación esperada |
|---|------------|---------------|----------------------------------|
| 3.1 | Envío de solicitud con email válido | Positivo | Retorna `200 OK`, correo enviado. |
| 3.2 | Email no registrado | Negativo | Retorna `404 Not Found`. |
| 3.3 | Email con formato incorrecto | Negativo | Retorna `422 Unprocessable Entity`. |
| 3.4 | Payload vacío | Negativo | Retorna `400 Bad Request`. |
| 3.5 | Reintentos consecutivos de recuperación | Seguridad | Devuelve `429 Too Many Requests` tras límite. |
| 3.6 | Validación del token de restablecimiento | Positivo | Token de reset es válido por X minutos. |
| 3.7 | Restablecimiento con token inválido | Negativo | Devuelve `403 Forbidden`. |
| 3.8 | Restablecimiento exitoso con nueva contraseña | Positivo | Devuelve `200 OK`. |
| 3.9 | Restablecimiento con contraseña débil | Negativo | Devuelve `400 Bad Request`. |
| 3.10 | Tiempo de respuesta < 600ms | Performance funcional | Flujo de recuperación eficiente. |

4️⃣ Listado de Bancos — /banks (GET)

| # | Escenario | Tipo de caso | Descripción / Validación esperada |
|---|------------|---------------|----------------------------------|
| 4.1 | Consulta de todos los bancos | Positivo | Retorna `200 OK` y lista no vacía. |
| 4.2 | Validación del schema de respuesta | Estructural | Cada elemento contiene `id`, `name`, `country`. |
| 4.3 | Filtro por país válido | Positivo | Retorna bancos del país especificado. |
| 4.4 | Filtro por país inexistente | Negativo | Devuelve lista vacía. |
| 4.5 | Consulta con header inválido | Negativo | Devuelve `400 Bad Request`. |
| 4.6 | Verificación de paginación (limit y offset) | Positivo | Devuelve resultados esperados. |
| 4.7 | Tiempo de respuesta < 500ms | Performance funcional | Consulta rápida. |
| 4.8 | Request concurrente (10 usuarios) | Stress funcional | No hay errores. |
| 4.9 | Verificar integridad de IDs únicos | Validación lógica | Ningún ID se repite. |
| 4.10 | Validar formato de campos (JSON schema) | Estructural | Cumple especificación del modelo. |

5️⃣ Detalle de Banco — /banks/{bank_id} (GET)

| # | Escenario | Tipo de caso | Descripción / Validación esperada |
|---|------------|---------------|----------------------------------|
| 5.1 | Consulta de banco válido | Positivo | Retorna `200 OK` y detalles correctos. |
| 5.2 | ID de banco inexistente | Negativo | Retorna `404 Not Found`. |
| 5.3 | ID de banco vacío | Negativo | Retorna `400 Bad Request`. |
| 5.4 | Validación de estructura del JSON | Estructural | Campos: `id`, `full_name`, `location`. |
| 5.5 | Validación de tiempo de respuesta < 400ms | Performance funcional | Consulta ágil. |
| 5.6 | Campo `location` contiene datos geográficos válidos | Validación lógica | Latitud/longitud válidas. |
| 5.7 | Headers de autorización inválidos | Negativo | Retorna `401 Unauthorized`. |
| 5.8 | Petición sin headers | Negativo | Retorna `400 Bad Request`. |
| 5.9 | Integración: consultar ATMs del banco | Flujo | Llamada encadenada `/banks/{id}/atms`. |
| 5.10 | ID de banco con caracteres especiales | Negativo | Retorna `400 Bad Request`. |

6️⃣ Listado de ATMs — /banks/{bank_id}/atms (GET)

| # | Escenario | Tipo de caso | Descripción / Validación esperada |
|---|------------|---------------|----------------------------------|
| 6.1 | Consulta de ATMs válidos | Positivo | Devuelve `200 OK` y lista de ATMs. |
| 6.2 | Banco inexistente | Negativo | Retorna `404 Not Found`. |
| 6.3 | Validación de coordenadas | Estructural | Cada ATM contiene `lat`, `lon`, `address`. |
| 6.4 | Filtro por ciudad válida | Positivo | Devuelve ATMs filtrados correctamente. |
| 6.5 | Filtro por ciudad inexistente | Negativo | Devuelve lista vacía. |
| 6.6 | Validación del tiempo de respuesta | Performance funcional | < 500 ms. |
| 6.7 | Petición concurrente de 10 usuarios | Stress funcional | Sin errores HTTP. |
| 6.8 | Validación del formato de dirección | Lógica | Campo `address` no vacío. |
| 6.9 | Endpoint sin token (si aplica) | Negativo | Devuelve `401 Unauthorized`. |
| 6.10 | ATM con ID inválido en ruta | Negativo | Retorna `400 Bad Request`. |

7️⃣ Listado de Cuentas — /accounts (GET)

| # | Escenario | Tipo de caso | Descripción / Validación esperada |
|---|------------|---------------|----------------------------------|
| 7.1 | Consulta de cuentas con token válido | Positivo | Retorna `200 OK` y lista no vacía. |
| 7.2 | Sin token de autenticación | Negativo | Retorna `401 Unauthorized`. |
| 7.3 | Token expirado | Negativo | Retorna `403 Forbidden`. |
| 7.4 | Validación de schema de respuesta | Estructural | Campos: `account_id`, `balance`, `currency`. |
| 7.5 | Validación de saldo positivo | Lógica | Ningún saldo negativo salvo sobregiros. |
| 7.6 | Consulta de cuenta inexistente | Negativo | Retorna `404 Not Found`. |
| 7.7 | Tiempo de respuesta < 400ms | Performance funcional | Consulta rápida. |
| 7.8 | Validación de paginación de cuentas | Positivo | `limit` y `offset` funcionan. |
| 7.9 | Campos extra no esperados | Estructural | No hay datos fuera del modelo esperado. |
| 7.10 | Cuentas de tipo diferente (ahorros/corriente) | Lógica | Diferencia por tipo correctamente. |

8️⃣ Transferencias — /transactions (POST)

| # | Escenario | Tipo de caso | Descripción / Validación esperada |
|---|------------|---------------|----------------------------------|
| 8.1 | Transferencia válida entre cuentas | Positivo | Retorna `200 OK` y confirmación exitosa. |
| 8.2 | Fondos insuficientes | Negativo | Retorna `400 Bad Request`. |
| 8.3 | Cuenta origen inexistente | Negativo | Retorna `404 Not Found`. |
| 8.4 | Cuenta destino inexistente | Negativo | Retorna `404 Not Found`. |
| 8.5 | Transferencia con monto negativo | Negativo | Retorna `400 Bad Request`. |
| 8.6 | Transferencia con token inválido | Negativo | Retorna `401 Unauthorized`. |
| 8.7 | Validación de idempotencia | Lógica | Reintento no duplica transacción. |
| 8.8 | Validación del schema de respuesta | Estructural | Campos: `transaction_id`, `status`, `timestamp`. |
| 8.9 | Tiempo de respuesta < 700ms | Performance funcional | Respuesta rápida. |
| 8.10 | Flujo: transferencia + consulta de movimientos | Flujo | Movimiento reflejado en `/transactions/history`. |

9️⃣ Movimientos — /transactions/history (GET)

| # | Escenario | Tipo de caso | Descripción / Validación esperada |
|---|------------|---------------|----------------------------------|
| 9.1 | Consulta de historial válido | Positivo | Retorna `200 OK` y lista de movimientos. |
| 9.2 | Usuario sin transacciones | Negativo | Lista vacía con mensaje informativo. |
| 9.3 | Filtro por rango de fechas válido | Positivo | Devuelve transacciones en el rango. |
| 9.4 | Filtro por rango inválido | Negativo | Retorna `400 Bad Request`. |
| 9.5 | Validación de schema | Estructural | Campos: `id`, `amount`, `type`, `date`. |
| 9.6 | Orden cronológico correcto | Lógica | Transacciones ordenadas por fecha. |
| 9.7 | Tiempo de respuesta < 600ms | Performance funcional | Consulta eficiente. |
| 9.8 | Consulta concurrente (10 usuarios) | Stress funcional | Sin errores HTTP. |
| 9.9 | Token inválido | Negativo | Retorna `401 Unauthorized`. |
| 9.10 | Validación de campos monetarios | Lógica | Monto con formato correcto. |

🔟 Solicitud de Productos — /products (POST)

| # | Escenario | Tipo de caso | Descripción / Validación esperada |
|---|------------|---------------|----------------------------------|
| 10.1 | Solicitud de producto válida | Positivo | Retorna `201 Created`. |
| 10.2 | Faltan campos requeridos | Negativo | Retorna `400 Bad Request`. |
| 10.3 | Tipo de producto inválido | Negativo | Retorna `422 Unprocessable Entity`. |
| 10.4 | Usuario no autenticado | Negativo | Retorna `401 Unauthorized`. |
| 10.5 | Validación del schema de respuesta | Estructural | Contiene `product_id`, `status`, `created_at`. |
| 10.6 | Solicitud duplicada | Negativo | Retorna `409 Conflict`. |
| 10.7 | Solicitud concurrente de 5 productos | Stress funcional | Sin fallos en el flujo. |
| 10.8 | Validación del tiempo de respuesta < 800ms | Performance funcional | Flujo eficiente. |
| 10.9 | Solicitud con datos límite (máximo texto) | Límite | Retorna `201 Created`. |
| 10.10 | Cancelación posterior de solicitud | Flujo | Producto se cancela correctamente. |

---

## 🚀 Casos de Prueba (Performance Testing con JMeter)

📌 **Definición general:**  
Se diseñarán pruebas de carga para medir el rendimiento de los endpoints críticos del sistema (como autenticación, consulta de cuentas y transferencias) bajo diferentes niveles de concurrencia.

### 📊 **Casos de rendimiento definidos:**

| #  | Endpoint                         | Tipo de prueba     | Usuarios concurrentes | Duración | Métricas esperadas                                             |
|----|----------------------------------|--------------------|------------------------|-----------|----------------------------------------------------------------|
| 1  | `/login`                         | Stress Test        | 100                    | 2 min     | % de fallos < 2%, tiempo de respuesta < 400 ms                 |
| 2  | `/token/refresh`                 | Load Test          | 50                     | 3 min     | Respuesta media < 500 ms, sin errores                          |
| 3  | `/banks`                         | Load Test          | 50                     | 3 min     | Tiempo medio < 500 ms, sin degradación                         |
| 4  | `/banks/{bank_id}`               | Stability Test     | 20                     | 10 min    | Sin variación de latencia >10%, respuesta estable               |
| 5  | `/banks/{bank_id}/atms`          | Endurance Test     | 20                     | 10 min    | Rendimiento sostenido, sin degradación                         |
| 6  | `/accounts`                      | Throughput Test    | 60                     | 2 min     | ≥150 transacciones/minuto, error rate < 1%                     |
| 7  | `/accounts/{account_id}/balance` | Concurrency Test   | 80                     | 5 min     | Sin errores bajo carga paralela, respuesta < 600 ms            |
| 8  | `/transactions`                  | Spike Test         | 200                    | 1 min     | Recuperación < 3 s tras picos, sin timeout                     |
| 9  | `/transactions/history`          | Soak Test          | 25                     | 15 min    | Sin memory leaks ni errores acumulativos                       |
| 10 | `/products`                      | Ramp-Up Test       | 40                     | 2 min     | Latencia media < 500 ms, estabilidad en escalamiento progresivo |

---

## ⚙️ Ejecución del Proyecto

### 🔧 1. Instalar dependencias
Asegúrate de tener **Java 17** y **Maven 3.9+** instalados:

```bash
java -version
mvn -version
```
Luego descarga las dependencias:

```bash
mvn clean install
```

🧩 2. Ejecutar pruebas funcionales (Karate)

Ejecuta todas las pruebas de la carpeta features:

```bash
mvn test
```

También puedes correr un archivo específico:
```bash
mvn test -Dkarate.options="classpath:features/openbank.feature"
```

Los reportes se generan automáticamente en:

target/karate-reports/

🔥 3. Ejecutar pruebas de rendimiento (JMeter)

Para correr las pruebas de carga definidas en el .jmx:

```bash
mvn clean verify
```
clean limpiara los registros y elementos generados como reportes para que ejecute sin problemas.

Los resultados se generan en:

```bash
target/jmeter/reports/OpenBankPerformance/
```

Y puedes abrir el archivo:
```bash
target/jmeter/reports/OpenBankPerformance/index.html
```
para visualizar los resultados en tu navegador.

📊 Reportes Generados

* Karate HTML Report: target/karate-reports/karate-summary.html

* JMeter Performance Report: target/jmeter/reports/OpenBankPerformance/index.html

* Resultados crudos (CSV/XML): target/jmeter/results/

📚 Propósito Académico

Este proyecto fue desarrollado con fines formativos y de práctica profesional, para reforzar conocimientos sobre:

* Automatización de pruebas de servicios REST.

* Integración de herramientas de testing dentro de un flujo Maven.

* Diseño de escenarios funcionales y de rendimiento.

* Análisis e interpretación de métricas de rendimiento (latencia, throughput, errores).

👩‍💻 Equipo de Trabajo

Nombre: Bryan Campuzano y Douglas Urbina
Institución: Besmart Corp
Año: 2025

📝 Licencia

Este proyecto se distribuye únicamente con fines educativos y no comerciales.
La API de OpenBank pertenece a sus respectivos propietarios y solo se usa para prácticas de aprendizaje.