# Foodreal

Foodreal is a SwiftUI-based iOS application currently in its beta phase. The app aims to provide Lehigh Students with an engaging platform to explore and review various dining options. The app is still in the outline phase with several pages under development.

## Features

- **User Authentication:** Integrated with Google SignIn and Firebase for secure user authentication.
- **Navigation:** Custom navigation using the Coordinator pattern.
- **Views:** Multiple views for different functionalities including Login, Onboarding, Home, Food, Review Creation, Settings, Account, About, and Privacy & Terms.
- **Dynamic UI Components:** Customizable UI elements for a seamless user experience.

## Structure

- **Coordinator.swift:** Manages app navigation and view building.
- **UserAuthModel.swift:** Handles user authentication logic, including Google SignIn and Firebase integration.
- **CoordinatorView.swift:** Root view that manages the navigation flow.
- **HomePageView.swift:** The home screen of the app.
- **LoginView.swift:** View for user authentication.
- **UIElements.swift:** Custom UI components used across the app.
- **FoodrealApp.swift:** Entry point of the app with Firebase configuration.

## Getting Started

1. **Clone the repository:**

   ```bash
   git clone https://github.com/ecpeter23/FoodReal
2. **Open the project in Xcode:**
   
   Navigate to the cloned directory and open the Foodreal.xcodeproj file.
4. **Configure Firebase:**
   
   Ensure you have a Firebase project set up and the necessary configuration files added to the project.
6. **Run the app:**
   
   Select an iOS simulator or a connected iOS device and run the app.

## Contribution

As the app is in its early stages of development, contributions are welcome. Feel free to fork the repository, make changes, and submit pull requests.

## License
