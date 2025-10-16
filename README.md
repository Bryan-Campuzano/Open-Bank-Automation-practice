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
├── pom.xml # Configuración de dependencias y plugins
├── README.md # Documentación del proyecto
├── src/
│ ├── test/
│ │ ├── java/
│ │ │ └── openbank/
│ │ │ └── OpenBankRunner.java # Ejecutor de los tests de Karate
│ │ ├── resources/
│ │ │ ├── features/
│ │ │ │ └── openbank.feature # Definición de los escenarios en Karate
│ │ │ └── data/
│ │ │ └── users.json # Archivos de prueba (si aplica)
│ │ └── jmeter/
│ │ └── OpenBankPerformance.jmx # Escenario de carga JMeter
└── target/
└── jmeter/
├── results/ # Resultados en CSV/XML
└── reports/ # Reportes HTML generados
```
---

## 🧪 Escenarios de Prueba (Functional Testing con Karate)

📌 **Definición general:**  
Los escenarios estarán diseñados para validar los endpoints públicos de OpenBank, verificando que las respuestas cumplan con los formatos esperados, códigos de estado correctos y contenido coherente.

### 🧩 **Escenarios definidos:**

| #  | Escenario                              | Descripción breve |
| -- | -------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| 1  | Autenticación válida                   | Verifica que el endpoint `/login` devuelve un token válido con credenciales correctas.                      |
| 2  | Autenticación inválida                 | Envía credenciales incorrectas y valida que la API responda con `401 Unauthorized`.                         |
| 3  | Listado de bancos                      | Consulta el endpoint `/banks` y verifica que devuelva la lista completa de bancos disponibles.              |
| 4  | Detalle de un banco específico         | Usa el endpoint `/banks/{bank_id}` y comprueba que la respuesta contiene información válida y estructurada. |
| 5  | Listado de ATMs                        | Valida que `/banks/{bank_id}/atms` devuelve una lista no vacía con coordenadas geográficas válidas.         |
| 6  | Creación de un ATM (POST)              | Envía un cuerpo JSON para crear un nuevo ATM (sandbox) y verifica el código `201 Created`.                  |
| 7  | Validación de datos faltantes (ATM)    | Prueba con campos obligatorios en blanco y valida el error `400 Bad Request`.                               |
| 8  | Listado de cuentas del usuario         | Usa `/accounts` para verificar que se obtienen las cuentas asociadas al usuario autenticado.                |
| 9  | Transferencia simulada                 | Ejecuta un POST en `/transactions` con datos válidos y verifica el código `200 OK` y mensaje de éxito.      |
| 10 | Transferencia con fondos insuficientes | Simula una transferencia sin fondos y valida el código `400` y mensaje de error.                            |

---

## 🚀 Casos de Prueba (Performance Testing con JMeter)

📌 **Definición general:**  
Se diseñarán pruebas de carga para medir el rendimiento de los endpoints críticos del sistema (como autenticación, consulta de cuentas y transferencias) bajo diferentes niveles de concurrencia.

### 📊 **Casos de rendimiento definidos:**

| #  | Endpoint                | Tipo de test     | Usuarios concurrentes | Duración | Métrica clave                                           |
| -- | ----------------------- | ---------------- | --------------------- | -------- | ------------------------------------------------------- |
| 1  | `/login`                | Stress Test      | 50                    | 1 min    | % de fallos < 5%                                        |
| 2  | `/banks`                | Load Test        | 25                    | 3 min    | Tiempo medio < 500 ms                                   |
| 3  | `/banks/{bank_id}/atms` | Endurance Test   | 10                    | 5 min    | Sin degradación notable del rendimiento                 |
| 4  | `/accounts`             | Throughput Test  | 30                    | 2 min    | ≥ 100 transacciones/minuto                              |
| 5  | `/transactions`         | Spike Test       | 100                   | 30 s     | Recuperación < 2 s                                      |
| 6  | `/banks/{bank_id}`      | Soak Test        | 15                    | 10 min   | Sin fugas de memoria o errores acumulativos             |
| 7  | `/login`                | Ramp-Up Test     | 60                    | 2 min    | Tiempo medio < 400 ms al aumentar usuarios gradualmente |
| 8  | `/accounts`             | Concurrency Test | 40                    | 3 min    | Sin errores, respuesta < 500 ms                         |
| 9  | `/transactions`         | Peak Load Test   | 120                   | 1 min    | Sistema soporta el pico sin caídas                      |
| 10 | `/banks/{bank_id}/atms` | Stability Test   | 20                    | 15 min   | Sin degradación en throughput ni latencia               |


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