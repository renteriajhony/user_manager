# user_manager

**Descripción del proyecto:**
Prueba técnica de Double V Partners; es una aplicación Flutter que permite crear, leer y actualizar usuarios en una base de datos SQLite utilizando Drift como solución para la persistencia. El proyecto aplica arquitectura limpia y principios SOLID, con un manejo eficiente de rutas utilizando `go_router`.

## Características principales

1. **Arquitectura limpia (Clean Architecture):**  
   Se utilizó Clean Architecture para mantener una estructura escalable y separada en capas, lo que facilita la mantenibilidad y extensibilidad de la aplicación.

2. **Aplicación de principios SOLID:**  
   Se aplicaron los principios SOLID para garantizar que el código fuera limpio, modular y fácil de mantener, asegurando así un desarrollo de calidad.

3. **Persistencia con SQLite y Drift:**  
   La base de datos utilizada para la persistencia de los datos de usuario es SQLite, gestionada a través de Drift, un paquete de Flutter que simplifica las interacciones con la base de datos.

4. **Manejo de rutas con go_router:**  
   Se utilizó el paquete `go_router` para la gestión de rutas, facilitando una navegación eficiente y declarativa entre las distintas pantallas de la aplicación.

## Requisitos previos

Antes de ejecutar el proyecto, asegúrate de tener configurado lo siguiente:

- **Flutter SDK**: Debes tener Flutter instalado. Si no lo tienes, sigue las instrucciones de instalación oficial: [Instalar Flutter](https://flutter.dev/docs/get-started/install).
  
- **Editor de código**: Te recomendamos usar [Visual Studio Code](https://code.visualstudio.com/) o [Android Studio](https://developer.android.com/studio).

## Clonar el repositorio

Para clonar el proyecto en tu máquina local, usa el siguiente comando:

```bash
git clone https://github.com/renteriajhony/user_manager.git 
```

Después de clonar el repositorio, navega al directorio del proyecto:
```bash 
cd user_manager
```

### Instalación de dependencias
Una vez dentro del directorio del proyecto, instala las dependencias necesarias con el siguiente comando:
 ```bash 
flutter pub get
```

### Ejecución de la aplicación
Para correr la aplicación, simplemente usa el siguiente comando: 
```bash 
flutter run
```
Esto compilará y ejecutará la aplicación en el dispositivo o emulador conectado.

## Tests unitarios
Este proyecto utiliza Mockito para la simulación de dependencias en los tests unitarios.

Para correr los tests unitarios, usa el siguiente comando:
```bash
flutter test --coverage test/widget_test.dart
# Para correr test y ver coverage desde navegador utiliza
# Requiere tener instalado LCOV
flutter test --coverage test/widget_test.dart && genhtml coverage/lcov.info -o coverage/html && open coverage/html/index.html
```
Este comando ejecutará los tests y generará un reporte de cobertura en formato HTML, el cual se abrirá automáticamente en tu navegador.