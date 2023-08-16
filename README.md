# miscellanous

A new Flutter project.

Rename App ID
```
    flutter pub run change_app_package_name:main com.gerar.ca.miscellaneous

```


create a sha256
```
cd android
./gradlew signingReport

```

## IOS tests

```
xcrun simctl openurl booted https://iridescent-kangaroo-239b32.netlify.app/pokemons/1/

```


## Localauth

plugin installed ot work with biometrics is local_auth

## Geolocator

A flutter geolocaiton plugin which provides easy access to platform specific location services.

## google_maps_flutter

Plugin for flutter to user google maps


## env variables

android/local.properties
ios is in root .env GOOGLE_MAPS_API_KEY=

## Remember to update googlemaps api keys

## Quick Actions

quick_actions plugin is installed to manage quick actions

## Badger

the plugin to show notifications is flutter_app_badger.


## Google mobile ads
The plugin to implement ads in our application

## Shared preferences
This plugin save the users preferences in our app.

## Workmanager

The WorkManager plugin for Flutter is a wrapper around Android's WorkManager, iOS' performFetchWithCompletionHandler, and iOS BGAppRefreshTask. It enables the execution of Dart code in the background, which is especially useful for running periodic tasks, such as fetching remote data on a regular basis.

## Isar database
Isar is a multi-platform, fast, fully asynchronous NoSQL database for Flutter, developed by Simon Leier. It's designed to be easy to use and has many features that make it an excellent choice for Flutter development. It is ACID-compliant and handles transactions automatically, rolling back changes if an error occurs. It's statically typed, meaning that queries are compile-time checked, reducing the likelihood of runtime errors.

## code generator 
```
dart run build_runner build

flutter pub run build_runner build

flutter pub run build_runner watch
```