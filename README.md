
**Assignment => Flutter App with Back4App Integration:**

**Name: M. ATHEES WARAN 
=> BITS ID: 2022mt93200**

**Reference link:**
https://www.back4app.com/docs/flutter/parse-sdk/data-objects/flutter-crud

**Step1: Setup Back4App**
1. Sign up for back4App => https://www.back4app.com/
2. Create a New Back4App App:
   a) Create a new app in the Back4App dashboard (for example: Assignment)
   b) Create a class named "Task" with columns "title" (String) and "description" (String). => See below image
  ![image](https://github.com/atheeswaran/CAPD-Assignment-Flutter-task-App/assets/19812046/ffbea6e3-d367-4bfd-a6c2-d812af2b2759)

**Step2: Install Pre-reqs**
1. Install Flutter on Windows:
  => Download the Flutter SDK.
  => Extract the downloaded ZIP file to a location on your computer.
  => Add the Flutter bin directory to your system PATH.
2. Install Android Studio and Visual Studio Code
3. Setup an Emulator
   a) Open Android Studio => Virtual Device Manager
   b) Create new device and download
   c) run the Emulator and check

**Step3: Verify installation**
1. run "Flutter doctor' on terminal and look for errors
2. ensure there are no errors (common error for example: download and install x64 latest android setup via android studio)

**Step 4: Flutter Setup**
1. Create a New Flutter Project:
   => "flutter create firstApp" under CAPD-Assignment-Flutter-task-App
2. Drag and Drop "firstApp" folder into VSCode

**Step 5: Update Dependencies in pubspec.yaml like below:**
![image](https://github.com/atheeswaran/CAPD-Assignment-Flutter-task-App/assets/19812046/3b344f8a-e675-4851-ae79-233fd5ce6b55)

=> parse_server_sdk, package_info_plus, parse_server_sdk_flutter

**Step 6: Build Flutter TaskApp:**
1. Start editing First_App/lib/main.dart
2. Import required dart packages
3. Declare Task Class
 ![image](https://github.com/atheeswaran/CAPD-Assignment-Flutter-task-App/assets/19812046/098c862e-c020-4c8c-8dc6-e4415a38c462)
   
4.In Main method, update Application ID, client key and parseapi url
  a) copy App ID, client key from back4App.
![image](https://github.com/atheeswaran/CAPD-Assignment-Flutter-task-App/assets/19812046/8ba79f58-4fa5-48df-b773-0d41454d70ea)


5.Implement TaskListScreen(homepage) extended from Main App (MyApp) with below methods
   a) **Fetchtasks** => to retrieve task and description by passing object ID from Back4App class using **Parse object**
   b) **Create task** => Creates task with name and description in Back4App
   
6. Implement TaskCreationScreen after user clicks "create task" icon or edits/deletes existing task
   a) **editTask**=> to edit the existing task and update the changes made to back4App
   b) **Deletetask**=> to delete the tapped task and remove it from Back4App

**Step 7: Run the application**
1. Select the device in VS Code => installed emulator or Chrome => see below
  ![image](https://github.com/atheeswaran/CAPD-Assignment-Flutter-task-App/assets/19812046/bf70e5d5-e1ac-47a3-ae22-e5db2d859049)
2. execute flutter run from terminal or Menu > run > start without debugging and from terminal => **flutter run --release** for release build
3. Ensure there are no errors in console

**Step 8: Test the Application against back4App Task Class**
1) **Home Page** => Fetch tasks with create task icon => verify against Back4App Task rows
 ![image](https://github.com/atheeswaran/CAPD-Assignment-Flutter-task-App/assets/19812046/909b66e1-1200-466b-a033-50e60f9eebf6)
![image](https://github.com/atheeswaran/CAPD-Assignment-Flutter-task-App/assets/19812046/193f113f-20a7-4079-b57d-8b1684361efe)

2) **Create task page** => with task name and description fields to create => Check Back4App if new task is added
  ![image](https://github.com/atheeswaran/CAPD-Assignment-Flutter-task-App/assets/19812046/a3a5c6e5-48de-4bb7-bf49-9eb546b5755c)
![image](https://github.com/atheeswaran/CAPD-Assignment-Flutter-task-App/assets/19812046/037d69be-0b52-4ec7-82a3-6d0e56e91f9d)
  
**Step 8A: Bonus Features (Edit and Delete tasks) **
1) **Edit task** => tap existing task and update the name or decription => Check back4App if task is updated with new details
     ![image](https://github.com/atheeswaran/CAPD-Assignment-Flutter-task-App/assets/19812046/891ebd00-e6a3-4451-83cc-677fa7c7a227)
     ![image](https://github.com/atheeswaran/CAPD-Assignment-Flutter-task-App/assets/19812046/8ab82466-683f-409e-9a2e-f1f8d1da32ef)
     ![image](https://github.com/atheeswaran/CAPD-Assignment-Flutter-task-App/assets/19812046/ddd30839-ae29-4717-8dbe-584bfe5f67ce)
2) **delete task** => tap existing task and click delete icon => check back4App if task is deleted
    ![image](https://github.com/atheeswaran/CAPD-Assignment-Flutter-task-App/assets/19812046/f5392566-7505-40d0-abd0-fde803dbe6ce)
    deleted task is not present in Back4App
   
**Step 9: Check Cross-Platform ness between mobile and web app**
![image](https://github.com/atheeswaran/CAPD-Assignment-Flutter-task-App/assets/19812046/537a8ceb-c097-4ff7-bbf2-4dbd5ddf3030)



   
 




