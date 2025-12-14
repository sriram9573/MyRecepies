# MyRecepies 🍳 🍲

**Personal Recipe Manager & Discovery App**

[![Swift](https://img.shields.io/badge/Swift-5.0+-orange?style=flat-square&logo=swift)](https://developer.apple.com/swift/)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-Latest-blue?style=flat-square&logo=swift)](https://developer.apple.com/xcode/swiftui/)
[![RapidAPI](https://img.shields.io/badge/API-RapidAPI-blueviolet?style=flat-square&logo=rapid)](https://rapidapi.com/)
[![MapKit](https://img.shields.io/badge/MapKit-Apple-green?style=flat-square&logo=apple)](https://developer.apple.com/documentation/mapkit)

---

## 🚀 Overview

MyRecepies is a comprehensive iOS application designed to be your digital cookbook and kitchen companion. It bridges the gap between organizing your own family secrets and discovering new culinary trends.

Users can manually catalog their personal recipes, search for thousands of new dishes via the **Tasty API**, and even locate the nearest grocery stores to grab missing ingredients—all within a clean, modern iOS interface.

---

## ✨ Key Features

### 📖 **Digital Recipe Box**
- **Create & Edit**: Manually add your own recipes with detailed ingredient lists and step-by-step instructions.
- **Local Storage**: Your personal cookbook is saved locally, ensuring your data is always available.
- **Clean UI**: A dedicated detail view for reading recipes while cooking without distractions.

### 🔍 **Global Recipe Search**
- **Powered by Tasty API**: Access a massive database of world-class recipes.
- **Instant Search**: Type a query (e.g., "Pasta", "Vegan") and get results instantly.
- **One-Tap Save**: Found something you like? Add it directly to your personal Recipe Box.

### 📍 **Smart Grocery Finder**
- **Integrated Maps**: Built-in MapKit integration.
- **Nearby Stores**: Automatically locates the nearest grocery stores based on your current location.
- **Navigation**: Get directions to the store without leaving the context of your cooking planning.

---

## 🛠️ Technical Stack

- **Language**: Swift
- **UI Framework**: SwiftUI
- **Networking**: `Combine` framework for handling API calls.
- **APIs**: 
    - **RapidAPI (Tasty)**: For fetching external recipe data.
    - **MapKit**: For location services and rendering maps.
- **Architecture**: MVVM (Model-View-ViewModel) pattern for clean separation of logic and UI.

---

## 🏁 Getting Started

### Prerequisites
- Xcode 14.0+
- iOS 16.0+
- RapidAPI Key

### Installation

1.  **Clone the repo**
    ```bash
    git clone https://github.com/sriram9573/MyRecepies.git
    cd MyRecepies
    ```

2.  **Open in Xcode**
    ```bash
    open MyRecepies.xcodeproj
    ```

3.  **Configure API Key**
    > **Note:** This project uses RapidAPI. You need to provide your own key.
    
    Open `API.swift` and replace the placeholder key:
    ```swift
    request.setValue("YOUR_RAPIDAPI_KEY", forHTTPHeaderField: "X-RapidAPI-Key")
    ```

4.  **Run the App**
    Select your target simulator (e.g., iPhone 15 Pro) and hit **Run (Cmd+R)**.

---

## 🚀 Future Roadmap
- [ ] User Authentication (Cloud Sync)
- [ ] Shopping List generation
- [ ] Categorization/Tags for local recipes
- [ ] Widget support

