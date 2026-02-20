allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    val buildToolsOverride = "36.1.0"
    if (project.state.executed) {
        project.extensions.findByType<com.android.build.gradle.BaseExtension>()?.buildToolsVersion = buildToolsOverride
    } else {
        project.afterEvaluate {
            project.extensions.findByType<com.android.build.gradle.BaseExtension>()?.buildToolsVersion = buildToolsOverride
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
