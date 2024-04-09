**Overview**
The Nutritionix App is a Swift project built using the MVVM architecture and SwiftUI framework. It adheres to best practices, incorporating Dependency Injection, following SOLID principles, DRY, and includes comprehensive unit testing.

**Features**
**MVVM Architecture**: The project is structured using the Model-View-ViewModel (MVVM) architectural pattern for clear separation of concerns.

**Async await** :
It is being used for async programming


**SwiftUI Framework:** 

**Dependency Injection:** The project embraces Dependency Injection, ensuring a flexible and maintainable codebase.

**SOLID Principles:** The code adheres to SOLID principles, promoting scalability, flexibility, and maintainability.

**Unit Testing:** Comprehensive unit testing is in place to ensure the reliability and correctness of the codebase.

**Project Structure**
UpTick.swift

**FoodItemViewModel**
FoodItemListView, FoodItemInputView interacts with FoodItemViewModel to manage and display of data.
- Error Handling
- Combine, Debounce is use to delay the call by 300ms

**Dependency Injection**
URL and session dependencies are injected from UpTickApp, where the application is loaded.

** Generic:**
Network classes uses Generic 

** SDWebImageSwiftUI:**
Package is used for Image cache

** UserDefault**
To store the data

**Mocking**
Mock responses and mocking of URLSession and URLProtocol are implemented under the Mock folder.
