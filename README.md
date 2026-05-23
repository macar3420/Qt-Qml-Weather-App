# Qt Qml Weather App

A desktop weather application built with **Qt 6**, **QML**, and **C++**. Search for any city, view current conditions (temperature, wind, humidity), and browse a 5-day forecast. The background gradient changes based on the weather.

## Screenshots

| Clear sky (Tampere) | Mist (Santiago) |
|:---:|:---:|
| ![Clear sky](screenshots/screenshot1.png) | ![Mist](screenshots/screenshot2.png) |

| Broken clouds (Helsinki) | Light rain (New York) |
|:---:|:---:|
| ![Broken clouds](screenshots/screenshot3.png) | ![Light rain](screenshots/screenshot4.png) |

## Features

- City search with live data from [OpenWeatherMap](https://openweathermap.org/api)
- Current weather: icon, description, temperature, wind speed, humidity
- 5-day forecast with daily icons and temperatures
- Dynamic UI colors that match the weather (clear, clouds, rain, snow, fog, and more)
- Built with Qt Quick Controls and responsive layouts

## Requirements

- **CMake** 3.21+
- **C++** compiler with C++17 support
- **Qt 6.2+** with modules:
  - Qt Core, Gui, Network, Qml, Quick, QuickControls2

On Fedora:

```bash
sudo dnf install qt6-qtbase-devel qt6-qtdeclarative-devel cmake gcc-c++
```

## Build & Run

```bash
git clone https://github.com/macar3420/Qt-Qml-Weather-App.git
cd Qt-Qml-Weather-App

cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build -j$(nproc)

./build/QtQmlWeatherApp
```

Run from the project root or the `build/` directory.

## OpenWeatherMap API Key

The API key is **not** stored in source code. Get a free key from [openweathermap.org](https://openweathermap.org/api), then either:

**Option A — environment variable (recommended)**

```bash
export OPENWEATHERMAP_API_KEY="your_api_key_here"
./build/QtQmlWeatherApp
```

**Option B — local `.env` file (gitignored)**

```bash
cp .env.example .env
# Edit .env and replace your_api_key_here with your real key
./build/QtQmlWeatherApp
```

The app searches for `.env` in the current directory, next to the executable (`build/.env`), and parent folders (so a `.env` in the project root works when you run `./build/QtQmlWeatherApp`).

If your key was ever committed to Git, **revoke it** in the OpenWeatherMap dashboard and create a new one.

## Project Structure

```
Qt-Qml-Weather-App/
├── content/           # Main UI (App.qml) and weather images
├── imports/           # QML module (QtQmlWeatherApp)
├── src/               # C++ entry point (main.cpp)
├── screenshots/       # App screenshots for documentation
├── CMakeLists.txt
└── QtQmlWeatherApp.qmlproject
```

## Tech Stack

- Qt 6 / QML / Qt Quick Controls 2
- CMake
- OpenWeatherMap REST API (`XMLHttpRequest`)

## License

Add your license here if applicable.
