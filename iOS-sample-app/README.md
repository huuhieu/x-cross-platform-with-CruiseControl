x-platform-example
==================

Example of cross-platform BDD with Cucumber and Calabash.

There is a companion talk given at CukeUp'13:

[Cross-platform for Mobile](http://skillsmatter.com/podcast/java-jee/cross-platform-and-end-to-end-bdd-for-mobile)


And a companion Article which explains the idea:

[Test Architecture for Cross-platform](https://github.com/calabash/calabash-ios/blob/0.9.x/calabash-cucumber/doc/x-platform-testing.md)


Getting Started
===============

The example uses the open source WordPress apps for iOS and Android. Since the Android app is licensed as GPL, we do not distribute the app with this project.

You can download the apps by doing the following.

First ensure subversion is installed by typing `svn --version` in a command prompt.

# Download and Build: Android

Ensure you ant and have Android API 13 installed.  To install API 13:

    $ANDROID_HOME/tools/android #now install android-13

Ensure you have Calabash Android installed in version 0.4.4.

Download and build

    mkdir -p android-source
    cd android-source
    svn co http://android.svn.wordpress.org/tags/2.2.7/

You should now have a directory: `2.2.7` containing the source code for Android.

Finally build the `.apk` file

    cd 2.7.7
    ant debug

This should produce a file `bin/Dashboard-debug.apk`.


# Download and Build: iOS

Ensure you have XCode (4.5+) and XCode Command Line tools installed.

Ensure you have Calabash iOS version 0.9.144 installed.

From the root directory (the one containing `android-source`),

    mkdir -p ios-source
    cd ios-source
    svn co http://iphone.svn.wordpress.org/tags/3.3.1/

Setup Calabash iOS

    cd 3.3.1
    calabash-ios setup

Just select the default target (WordPress).

Now open the WordPress XCode workspace: `open WordPress.xcworkspace`

Run this xcode incantation to build:

    xcodebuild build -workspace WordPress.xcworkspace -scheme WordPress-cal -configuration Debug -sdk iphonesimulator6.1 DEPLOYMENT_LOCATION=YES DSTROOT=build TARGETED_DEVICE_FAMILY=1

If you're running XCode 5, replace `-sdk iphonesimulator6.1` with `-sdk iphonesimulator7.0`.

If it complains about a missing WordPress-cal scheme then just create it from XCode and make sure you select the target: `WordPress-cal`.

# Being Safe with Bundler

While this step is not strictly required, we recommend that you use the bundler tool to manage Ruby gem dependencies.
Bundler will ensure that you're always running an explicitly defined set of Ruby gem versions.

Check that you have bundler installed by running `bundle version`.

If bundler is not installed run `gem install bundler` to install it.

Now run

    bundle install

# Running the tests
Plug in an Android phone (or for the patient, start an Android emulator).
Run the login feature on Android phone:

    bundle exec calabash-android run android-source/2.2.7/bin/Dashboard-debug.apk -p android features/login.feature

You should see

    No test server found for this combination of app and calabash version. Recreating test server.
    Done signing the test server. Moved it to test_servers/80b8b6c0a44b6e16d2bd7f4aeba0d2ac_0.4.4.apk
    Using the android profile...
    Feature: Login
    ...

Now run the login feature on iPhone:

    bundle exec cucumber -p ios features/login.feature

Hopefully that works out well :)
