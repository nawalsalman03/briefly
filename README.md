# 📰 Briefly - Tech News with Gemini AI

A modern Flutter application that delivers tech news from **two intelligent data sources**, combining traditional REST APIs with cutting-edge AI curation. Built with clean **BLoC Architecture** and Google's Generative AI API.

---

## ✨ Features

- ✅ **Dual Data Sources**
  - REST API for latest tech news
  - Gemini AI for intelligent news curation
- ✅ **AI-Powered Summaries** in Pakistani Roman Urdu (Korangi slang)
- ✅ **Clean BLoC Architecture** - Scalable and maintainable
- ✅ **Tab-Based Navigation** - Easy switching between sources
- ✅ **Real-time Updates** - Google Search integration for latest news
- ✅ **Error Handling & Retry** - Graceful error states with user feedback
- ✅ **Dark Theme UI** - Modern and visually appealing design

---

## 🏗️ Architecture Overview

This project demonstrates the **BLoC (Business Logic Component)** pattern with a clean, layered architecture:

```
lib/
├── bloc/                          # State Management Layer
│   ├── news_bloc.dart            # Main bloc with event handlers
│   ├── news_event.dart           # Events: LoadNews, LoadGeminiSummary
│   └── news_state.dart           # States for all UI scenarios
│
├── data/                         # Data Layer
│   ├── datasources/
│   │   ├── news_remote_data_source.dart    # REST API integration
│   │   └── gemini_data_source.dart         # Gemini AI integration ⭐ NEW
│   │
│   ├── models/
│   │   └── news_item.dart       # Data model
│   │
│   └── repositories/
│       └── news_repository.dart # Repository pattern implementation
│
├── presentation/                 # UI Layer
│   └── screens/
│       └── news_screen.dart     # Main screen with tabs
│
└── main.dart                    # App entry point
```

### Data Flow

```
UI Event → NewsBloc → NewsRepository → DataSource → API
                ↑                                    ↓
                └────────── State Updates ←────────┘
```

---

## 🎯 What Was Added (Gemini Integration)

### New Files Created
- **`lib/data/datasources/gemini_data_source.dart`** - Gemini API integration
- **`lib/data/models/news_model.dart`** - AI response data model

### Files Modified
| File | Changes |
|------|---------|
| `lib/data/repositories/news_repository.dart` | Added `getGeminiSummary()` method |
| `lib/bloc/news_event.dart` | Added `LoadGeminiSummary` event |
| `lib/bloc/news_state.dart` | Added `GeminiLoading`, `GeminiLoaded` states |
| `lib/bloc/news_bloc.dart` | Added Gemini event handler |
| `lib/main.dart` | Initialize dotenv & GeminiDataSource |
| `lib/presentation/screens/news_screen.dart` | Added Gemini Summary tab |
| `pubspec.yaml` | Added Gemini & dotenv dependencies |

---

## 🚀 Getting Started

### Prerequisites
- Flutter 3.0+
- Dart 3.0+
- Google Account (for Gemini API key)

### Installation

#### 1. Clone the Repository
```bash
git clone https://github.com/YOUR_USERNAME/briefly.git
cd briefly
```

#### 2. Get Gemini API Key
1. Visit [Google AI Studio](https://aistudio.google.com/)
2. Click **"Get API Key"** → **"Create API key in new project"**
3. Copy your API key

#### 3. Setup Environment Variables
Create `assets/.env` file:
```
GEMINI_API_KEY=your_api_key_here
```

#### 4. Install Dependencies & Run
```bash
flutter pub get
flutter run
```

---

## 📸 Screenshots

### Latest News Tab (REST API)
![Latest News](images/latest_news.png)
*REST API tab showing curated tech news items with refresh functionality and clean card layout*

### Gemini AI Summary Tab
Shows AI-curated news summaries in Pakistani Roman Urdu with intelligent bullet-point formatting and real-time news fetching via Google Search integration.

---

## 🔑 Key Technologies

| Technology | Purpose |
|-----------|---------|
| **Flutter** | Cross-platform UI framework |
| **Dart** | Programming language |
| **Flutter Bloc** | State management (v9.0.0) |
| **Google Generative AI** | Gemini API integration |
| **HTTP** | REST API client |
| **flutter_dotenv** | Environment variable management |

---

## 🔒 Security & Best Practices

✅ **API Key Protection**
- Stored in `.env` file (never committed)
- Loaded at runtime via `flutter_dotenv`
- Safe from version control with `.gitignore`

✅ **Error Handling**
- Try-catch blocks in all async operations
- User-friendly error messages
- Retry functionality with exponential backoff

✅ **Clean Architecture**
- Separation of concerns (data, business logic, presentation)
- Repository pattern for data access
- BLoC for state management

---

## 💡 How It Works

### REST API Flow (Tab 1: Latest News)
1. User taps "Load News"
2. BLoC emits `NewsLoading` state
3. Repository calls `NewsRemoteDataSource`
4. HTTP request to Cloud Function
5. Response parsed into `NewsItem` models
6. UI updates via `NewsLoaded` state

### Gemini AI Flow (Tab 2: Summary) ⭐
1. User taps "Get AI Summary"
2. BLoC emits `GeminiLoading` state
3. Repository calls `GeminiDataSource`
4. HTTP request to Gemini API with:
   - System instruction: "Expert news reporter in Roman Urdu"
   - Query: "Latest tech news summary in last 24 hours"
   - Tools: Google Search for real-time data
5. AI generates curated summary
6. UI updates via `GeminiLoaded` state

---

## 📱 API Information

### Gemini API
- **Model:** `gemini-2.0-flash`
- **Features:** Real-time web search, content curation
- **Language:** Pakistani Korangi slang Roman Urdu
- **Output Format:** Bullet points (no long paragraphs)

### REST API
- **Base URL:** `https://news-curator-3494615909.us-central1.run.app/news`
- **Returns:** NewsItem objects (headline, body)
- **Format:** Parses markdown bold text (**headline**)

---

## 🧪 Testing the App

### Test REST API Source
1. Open app → Select "Latest News" tab
2. Tap "Load News" button
3. Verify news items appear in cards
4. Tap refresh icon to reload

### Test Gemini AI Source
1. Open app → Select "Gemini Summary" tab
2. Tap "Get AI Summary" button
3. Wait for Gemini to fetch and curate news (3-5 seconds)
4. Read summary in Pakistani Roman Urdu
5. Tap refresh for new summary

---

## 🐛 Troubleshooting

| Issue | Solution |
|-------|----------|
| "GEMINI_API_KEY not found" | Verify `.env` exists in `assets/` with correct key |
| Build fails | Run `flutter clean && flutter pub get` |
| Quota exceeded error | Wait 30 seconds or create new API key |
| White screen on web | Check browser console (F12), verify .env path |
| Tab navigation not working | Ensure `TabController` initialized in `initState` |

---

## 📚 Learning Outcomes

This project demonstrates:
- ✅ BLoC pattern for state management
- ✅ Repository pattern for data access
- ✅ Multiple data sources in single app
- ✅ Google Generative AI API integration
- ✅ Environment variable management
- ✅ Error handling and user feedback
- ✅ Flutter clean architecture best practices

---

## 👥 Group Members

| Roll Number |
|------------ |
| 22k-4236    |
| 22k-4460    |
| 22k-4584    |

---

## 📋 Assignment Details

**Course:** Gemini API for Flutter Developers  
**Assignment:** Add Gemini API as Secondary Data Source to Bloc App  

---

## 🔗 Useful Resources

- [Flutter Bloc Documentation](https://bloclibrary.dev/)
- [Google Generative AI Docs](https://ai.google.dev/docs)
- [Clean Architecture in Flutter](https://resocoder.com/flutter-clean-architecture)
- [Environment Variables Guide](https://pub.dev/packages/flutter_dotenv)

---



## 🎉 Project Status

✅ **Complete** - Both data sources integrated and tested
- REST API: Fully functional
- Gemini AI: Fully functional with Google Search
- UI: Tab-based navigation with error handling
- Documentation: Comprehensive README

---

**Built with ❤️ for the Flutter developer community**

