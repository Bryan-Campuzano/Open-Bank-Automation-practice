# 🏦 Proyecto de Testing API — OpenBank

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

| # | Escenario | Descripción breve |
|---|------------|-------------------|
| 1 | **Autenticación válida** | Validar que el endpoint `/login` devuelve un token válido al enviar credenciales correctas. |
| 2 | **Listado de cuentas** | Verificar que el endpoint `/accounts` devuelve la lista completa de cuentas del usuario autenticado. |
| 3 | **Transferencia fallida** | Simular una transferencia con fondos insuficientes y validar que retorna el error `400 Bad Request`. |
| 4 | ... | *(Espacio reservado para más casos)* |

---

## 🚀 Casos de Prueba (Performance Testing con JMeter)

📌 **Definición general:**  
Se diseñarán pruebas de carga para medir el rendimiento de los endpoints críticos del sistema (como autenticación, consulta de cuentas y transferencias) bajo diferentes niveles de concurrencia.

### 📊 **Casos de rendimiento definidos:**

| # | Endpoint | Tipo de test | Usuarios concurrentes | Duración | Métrica clave |
|---|-----------|---------------|------------------------|-----------|----------------|
| 1 | `/login` | Stress Test | 50 | 1 min | % de fallos < 5% |
| 2 | `/accounts` | Load Test | 20 | 3 min | Tiempo medio < 400ms |
| 3 | `/transfer` | Spike Test | 100 | 30 s | Recuperación < 2 s |
| 4 | ... | ... | ... | ... | ... |

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