plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.mentis_ai"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html ).
        applicationId = "com.example.mentis_ai"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug" )
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'),'proguard-rules.pro'
        }
    }
}

apply(plugin = "com.google.gms.google-services")

<<<<<<< HEAD
//Dependencias usadas no firebase para configuração do login com o google
dependencies{ 
    implementation platform('com.google.firebase:firebase-bom:34.5.0')
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.android.libraries.identity.googleid:googleid:1.1.1")
    implementation("androidx.credentials:credentials:1.6.0-beta03")
    implementation("androidx.credentials:credentials-play-services-auth:1.6.0-beta03")
}


=======
>>>>>>> 8b8d95f8b6cf950e5072d6b505f8d5bef0b4dac7
flutter {
    source = "../.."
}
