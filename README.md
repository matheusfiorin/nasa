# Astronomy Picture of the Day

This projects uses the [NASA API](https://api.nasa.gov/) to fetch the Astronomy Picture of the Day
using Flutter as the main framework to work on. The goal is to display their gallery in a fashion
manner, striving for a good user experience using cache strategies and a clean UI.

## Getting started

To run this project, you need to have the Flutter SDK installed on your machine. You can follow the
official documentation to do so [here](https://flutter.dev/docs/get-started/install).
After that, you can clone this repository and run the following command to install the dependencies:

```bash
flutter pub get
```

You also have to create a `.env` file in the root of the project, and you can use the `.env.example`
file to get started. Please note that this is the expected content of the file:

```env
NASA_API_KEY=your_api_key_here
```

### Recommended versions

- **Flutter version** :: 3.24.5 • channel stable • revision dec2ee5c1f
- **Dart version** :: 3.5.4

## Running the project

To manually run the project, you can use the following command:

```bash
flutter run
```

It'll give you the option to run on a physical device or an emulator, and the device must be
connected and ready to receive the application.

## Running tests

To run the tests, you can use the traditional flutter command:

```bash
flutter test
```

But I've also created a script in the root of this project to run the tests with coverage, which can
be executed with the following command:

```bash
./coverage.sh
```

It'll generate a coverage report in the `coverage` folder, which will be automatically opened in
your browser.

> Make sure to have `lcov` and `genhtml` installed on your machine to generate the coverage report.
> For MacOS, `brew` is enough for both installations.
> For Linux, you can use `apt-get` to install them.

## Architecture

This project uses the Clean Architecture as the main architecture, with some adaptations to fit the
application challenge and my personal view of the modern implementation of it. The main goal is to
separate the business logic from the presentation logic, and
the data layer from the domain layer.

### Folder structure

The project is divided into the following folders:

```
.
└── src
    ├── core
    │   ├── config
    │   ├── di
    │   ├── error
    │   ├── network
    │   └── utils
    ├── data
    │   ├── model
    │   ├── provider
    │   │   ├── local
    │   │   └── remote
    │   └── repository
    │       └── contracts
    ├── domain
    │   ├── entity
    │   ├── repository
    │   └── use_case
    └── presentation
        ├── common
        │   ├── theme
        │   └── widgets
        ├── feature
        │   ├── apod_detail
        │   │   ├── controller
        │   │   └── widgets
        │   └── apod_list
        │       ├── controller
        │       ├── state
        │       └── widgets
        └── routes
```

### Core

The core folder contains the main configurations of the application, like the dependency injection,
the ApiConfig, error handling, network configurations, and some utility functions - all of those
shared across the application.

### Data

The data folder contains models, providers, and repositories. The providers are divided into local
and remote, and inside the repository folder we also have the `contracts` needed by it that the
providers must fulfill.

### Domain

The domain folder contains the entities, repositories, and use cases. The `Apod` entity is the main
entity of the application, which deals with the Astronomy Picture of the Day in a way that also
binds the data layer with the domain layer in a semantic way, by purpose. The repositories are
interfaces that the data layer must implement, and the use cases are the business logic of the
application that the presentation layer will have access to.

### Presentation

The presentation folder contains the common elements of the application, like the theme and widgets,
and the feature folder, which contains the main features of the application.

Each feature has its own folder, with a controller, state, and widgets. The controller is
responsible for the business logic of the feature, the state is responsible for the state management
of the feature, and the widgets are the UI components of the feature - all of them could have a
screen representation inside the main feature folder,
like `feature/apod_list/apod_list_screen.dart`.

The routes folder contains the routes of the application, which are used to navigate between the
features.

## Dependencies

This project mainly uses the following dependencies:

- [dio](https://pub.dev/packages/dio) - A powerful Http client for Dart, which handles the network
  requests of the application.
- [get_it](https://pub.dev/packages/get_it) - A simple service locator for Dart and Flutter
  projects, which handles the dependency injection of the application.
- [cached_network_image](https://pub.dev/packages/cached_network_image) - A Flutter library to load
  and cache network images, which handles the image loading and caching without much effort.
- [dartz](https://pub.dev/packages/dartz) - A functional programming package for Dart, which helps
  to deal with immutable modeling in a functional way.
- [hive](https://pub.dev/packages/hive) - A lightweight and blazing fast key-value database written
  in pure Dart, which handles the local storage of the application.

## Preview

<table>
  <tr>
    <th>iOS light theme</th>
    <th>iOS dark theme</th>
    <th>Video playing</th>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/db254ace-c7fa-4b26-a63c-2d2250fbd1d5" width="300" /></td>
    <td><img src="https://github.com/user-attachments/assets/713bff59-37d4-4055-9ffa-2a8018beb804" width="300" /></td>
    <td><img src="https://github.com/user-attachments/assets/74543902-565f-473a-9218-f5bebd675ead" width="300" /></td>
  </tr>
</table>
