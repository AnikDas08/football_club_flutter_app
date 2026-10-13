# Flutter Proguard Rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# For Dio / Retrofit / OkHttp
-dontwarn okio.**
-dontwarn javax.annotation.**
-keepattributes *Annotation*,Signature,InnerClasses,EnclosingMethod

# Keep Flutter models and json serialization
-keepattributes EnclosingMethod
-keepattributes InnerClasses
