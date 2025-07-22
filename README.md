# 📚 Quote & Poetry App

A Flutter app that combines inspirational quotes and beautiful poetry (ghazals) in one elegant interface. Built with Provider for state management.

![App Screenshot](screenshot.png) <!-- Replace with actual screenshot path -->

## ✨ Features

### 📜 Quotes Screen
- Fetches random quotes using the **ZenQuotes API**
- Refresh to discover new inspiring content
- Clean, minimalist design for focus

### ✍️ Poetry Screen
- Browse ghazals by famous poets
- **Search functionality** to find poets quickly
- Mark favorite ghazals for later reading
- Dual-language support (English/Urdu)

### ❤️ Favorites Screen
- Save and organize favorite ghazals
- Persistent storage using SharedPreferences
- Easy removal of saved items

## 🛠️ Tech Stack
- **Flutter** (Cross-platform development)
- **Provider** (State management)
- **Material 3** Design Components
- **Responsive UI** works on phones & tablets

## 📦 Key Packages Used
```yaml
dependencies:
  cupertino_icons: ^1.0.8
  http: ^1.4.0        # For API calls (Quotes)
  google_fonts: ^6.2.1 # Beautiful typography
  path: ^1.9.1
  path_provider: ^2.1.5 # File system access
  provider: ^6.1.5    # State management
  shared_preferences: ^2.5.3 # Local storage