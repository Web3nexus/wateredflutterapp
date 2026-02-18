-keep class com.ryanheise.audioservice.** { *; }
-keep interface com.ryanheise.audioservice.** { *; }
-keep class com.ryanheise.just_audio.** { *; }
-keep interface com.ryanheise.just_audio.** { *; }
-keep class com.ryanheise.just_audio_background.** { *; }
-keep interface com.ryanheise.just_audio_background.** { *; }
-dontwarn com.ryanheise.audioservice.**
-dontwarn com.ryanheise.just_audio.**
-dontwarn com.ryanheise.just_audio_background.**

# Stripe
-keep class com.stripe.android.** { *; }
-keep interface com.stripe.android.** { *; }
-dontwarn com.stripe.android.**
-dontwarn com.google.gson.**
-dontwarn kotlin**.**
-ignorewarnings

# Optimization
-optimizations !code/allocation/variable

# Keep MainActivity
-keep class com.watered.app.MainActivity { *; }
