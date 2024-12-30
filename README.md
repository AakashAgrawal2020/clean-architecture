Features in the App -

1. Screen 1: Product Listing and Location Map
2. Screen 2: Product Locations on Google Map
3. Theme(Light & Dark) in App, along with local storage implementation of chosen theme
4. Responsive Design
5. Animations/Transitions
6. Handling of edge cases (e.g., no internet, error states, pull to refresh, retry options,
   permission denied)
7. Clean and modular code
8. BLoC State Management
9. Google Maps integration with a smooth transition.
10. Interactive Map

App Architecture has mainly four directories/sections explained below -

a) Core
b) Data
c) Domain
d) Presentation

The **CORE** folder contains foundational components and utilities that are shared across the
application. It ensures reusability, maintainability, and central management of common
functionalities. Below is an overview of its subfolders:

1. **blocs**
   a) Houses global BLoC (Business Logic Component) classes that manage the state of the whole app
   like theming in this case.

2. **components**
   a) Contains reusable UI components/widgets such as buttons, network images, loaders etc.

3. **config**
   a) Includes configuration files, such as app constants, environment variables, and theme
   definitions. Helps manage settings and values used throughout the application.

4. **helpers**
   a) Contains helper classes or functions for performing repetitive or utility tasks (e.g.,
   styling(fonts, textstyles), assets(svgs, pngs, lotties) paths,constant strings etc.),
   ensures code modularity and avoids duplication.

5. **network**
   a) Includes network-related utilities such as API endpoints, and services for making HTTP calls
   using Dio, typically used for managing remote data communication.

6. **service_locator**
   a) Implements dependency injection using a service locator pattern (e.g., GetIt),
   centralizes the management of dependencies for better scalability and testing.

7. **services**
   a) Encapsulates app-specific services like theme manager, session manager, analytics etc.
   Acts as a bridge between the core logic and service integrations.

8. **utils**
   a) Contains general-purpose utility classes or functions that do not belong to a specific
   module (e.g. - google map operations, extensions,local storage, animations, permissions, string
   manipulation etc.)

The **DATA** folder is responsible for managing all the data-related aspects of the application,
including models and data handling. It acts as a source layer to fetch, manipulate, and structure
data before passing it to the domain layer. Below is an overview of its structure:

1. **model**
   a) Contains the data models that define the structure and schema of the application's data.
   b) Subfolders like product are used to group models based on specific features or entities.

Example: Product Model
**product_model.dart**: The base class defining the Product data model, including fields and
methods.
**product_model.freezed.dart**: Generated file using the freezed package for immutable data classes
and pattern matching.
**product_model.g.dart**: Generated file for JSON serialization/deserialization using the
json_serializable package.

Key Responsibilities:

Defining and managing structured data models.
Handling serialization and deserialization of JSON data.
Ensuring the data integrity required by the domain layer.

The **DOMAIN** folder serves as the core of the application's business logic.
It acts as an intermediary between the data and presentation layers, ensuring a clean separation of
concerns.
This folder includes abstract definitions and interfaces, focusing on the rules and logic of the
application without depending on specific implementations.

1. **repositories**
   a) This directory houses the repository interfaces and their implementations,
   which abstract the data sources for the domain layer.

   b) Subfolders:
   google_map:
   **google_map_repository.dart**: Defines an abstract repository interface for Google Maps-related
   functionality, specifying the contracts for map data operations.
   **google_map_repository_impl.dart**: Provides the concrete implementation of the
   GoogleMapRepository interface, interacting with data sources such as APIs or local databases.

   product:
   **product_repository.dart**: Defines an abstract repository interface for product-related
   operations, outlining the contract for fetching and managing product data.
   **product_repository_impl.dart**: Implements the ProductRepository interface, managing the actual
   data retrieval and operations from the data layer.

Key Responsibilities:

Abstraction: Defines abstract interfaces (e.g., repositories) for the business logic.
Implementation Independence: Does not directly depend on how data is fetched or stored, promoting a
loosely coupled architecture.
Business Logic: Centralizes core business rules and operations.

The **PRESENTATION** folder contains all the code related to the UI layer of the application. It
follows the BLoC architecture to separate business logic from the UI and provide a clean structure
for maintaining the app. Below is an overview of its subdirectories:

1. routes
   This subfolder manages the navigation and routing within the app. It contains:
   **route_generator.dart**: Implements a route generator function to handle dynamic navigation and
   screen transitions.
   **routes.dart**: Defines static route names as constants for consistency and easy maintenance.

2. screens
   This subfolder organizes UI components into feature-specific directories. Each feature contains
   its screens, associated widgets, and BLoC (Business Logic Component) files.

3. directions
   bloc: Contains state management logic for the DirectionsScreen using the BLoC pattern.
   widgets: Houses reusable widgets specific to the DirectionsScreen.
   directions_screen.dart: Implements the main screen UI for displaying directions.

4. products
   bloc: Contains state management logic for the ProductListingScreen.
   widgets: Contains reusable widgets specific to the product listing feature.
   product_listing_screen.dart: Implements the UI for displaying a list of products.

5. views.dart
   This file includes shared widgets, mixins, or views that are used across multiple screens.

The **ASSETS** folder contains all the static resources used in the application, such as images,
animations, and other JSON files. These resources are pre-bundled with the app and accessed during
runtime for various UI components.

1. map_modes

   Contains assets related to the map functionality or display modes.
   **asgard_logo.png**: A logo image used within the application, for branding or map overlay.
   **error.json**: A Lottie animation or configuration file for displaying error states.
   **loading.json**: A Lottie animation or configuration file for indicating loading processes.
   **no_internet.json**: A Lottie animation or configuration file to display a "no internet connection"
   state.
   **zero_products.json**: A Lottie animation or configuration file used when there are no products to
   display.

Plugins Used -

1. equatable: Simplifies object comparison in Dart by making it easy to override equality operators.
2. bloc: State management library implementing the BLoC (Business Logic Component) pattern.
3. flutter_bloc: Integrates the BLoC library seamlessly with Flutter widgets.
4. freezed: Code generation tool for immutable classes, union types, and data classes.
5. freezed_annotation: Provides annotations required for the freezed package to generate code.
6. get_it: Simple dependency injection library for service location in Flutter.
7. flutter_secure_storage: Handles secure storage of sensitive data using platform-specific
   encryption.
8. dio: A powerful HTTP client for networking, supporting REST APIs, interceptors, and advanced
   configurations.
9. cached_network_image: Displays images from the network with built-in caching for better
   performance.
10. geolocator: Fetches the device's current location and handles geolocation-related tasks.
11. lottie: Renders animations in JSON format created using Adobe After Effects.
12. google_maps_flutter: Integrates Google Maps functionality in Flutter applications.

