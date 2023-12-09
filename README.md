# foodrecipe
## pages
|Folder Structure | Outcome |
| --- | --- |
| /lib/ProfilePage.dart | ProfilePage |
| /lib/signin_page.dart | LogIn Page |
| /lib/signup_page.dart | SignUp Page |
| /lib/landing_page.dart | Initial Page |
| /lib/home.dart | Home Page |
| /lib/model.dart | what should be the details should be present in the recipe page |
| /lib/RecipeView.dart|List of recipes for a given search |
| /lib/RecipeDetails.dart | Recipes Page|

## Project Overview
Explore, search, and discover delicious recipes with the FoodRecipe app.
## Project Analysis

The FoodRecipe app enables users to find recipes by searching for specific food items. Key screens include:

- **SignUp Page:**
  - Multiple sign-up methods: Username/Password, Google, Facebook.
- **Login Page:**
  - Multiple login methods: Username/Password, OAuth (Google, Facebook).
- **Home Page:**
  - Search for recipes and explore diverse dishes.
- **Recipe Details:**
  - View recipe details, including appearance, time taken, ingredients, and steps.
- **Profile:**
  - Displays user email and login method. Logout option available.
## Setup

Follow these steps to set up and run the FoodRecipe app locally:

### Prerequisites

1. **Flutter SDK:**
   - Install Flutter by following the [official documentation](https://docs.flutter.dev/get-started/install).

2. **IDE (Integrated Development Environment):**
   - Choose an IDE for Flutter development. Recommended options include Visual Studio Code or IntelliJ IDEA with the Dart and Flutter plugins.

3. **Firebase SDK:**
   - Set up a Firebase account and configure Firebase SDK for seamless integration into the app. Refer to the [Firebase Flutter setup guide](https://firebase.google.com/docs/flutter/setup?platform=ios).

### Development Environment

4. **Clone Repository:**
   - Clone the FoodRecipe repository from [GitHub](https://github.com/SasankKaramsetty/FoodRecipe).

5. **Flutter Packages:**
   - Open a terminal in the project directory and run:
     ```bash
     flutter pub get
     ```

6. **Run on Emulator/Device:**
   - Connect a physical device or set up an Android Emulator.
   - Ensure USB Debugging is enabled on the device.
   - Run the app using:
     ```bash
     flutter run
     ```
7. **Run Build Command:**
   - Execute the following command to build the APK:
     ```bash
     flutter build apk
     ```

8. **Locate APK File:**
   - After a successful build, locate the generated APK file. The default path is:
     ```
     build/app/outputs/flutter-apk/app-release.apk
     ```

9. **Explore the App:**
   - Once the app is running, explore the various features, including SignUp, Login, Recipe Search, and Recipe Details.


### Additional Information

- **Programming Language:**
   - Dart is used as the primary language for Flutter app development.

- **Testing Environment:**
   - Emulators and simulators can be used for testing. Connect a physical device for more accurate testing.

- **USB Debugging:**
   - Enable USB Debugging on the device for direct testing.

### References

- [Flutter Documentation](https://docs.flutter.dev/get-started/install)
- [Firebase Setup](https://firebase.google.com/docs/flutter/setup?platform=ios)  
