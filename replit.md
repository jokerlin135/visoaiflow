# Viso AI - Photo Avatar Headshot

## Overview
A Flutter-based AI photo application built with FlutterFlow that creates studio-grade AI headshots and avatars. The app supports multiple styles and includes features for photo enhancement, face swapping, and AI-powered transformations.

## Project Architecture

### Technology Stack
- **Framework**: Flutter 3.32.0 (Dart 3.8.0)
- **Backend**: Supabase (authentication, database, storage)
- **Monetization**: Google Mobile Ads (AdMob)
- **UI Framework**: FlutterFlow-generated components

### Key Dependencies
- `supabase_flutter`: Backend services integration
- `google_mobile_ads`: Advertisement integration
- `cached_network_image`: Image caching
- `go_router`: Navigation
- `google_fonts`: Typography
- `flutter_animate`: Animations

### Project Structure
- `/lib` - Main application code
  - `/pages` - Application pages (homepage, IAP, intro screens, etc.)
  - `/backend/supabase` - Supabase integration
  - `/flutter_flow` - FlutterFlow generated utilities
  - Various feature modules (aiphoto, headshots, swapface, etc.)
- `/assets` - Static assets (images, fonts, videos, etc.)
- `/web` - Web platform specific files
- `/android` - Android platform files
- `/ios` - iOS platform files

### Backend Configuration
- **Supabase URL**: https://lfeyveflpbkrzsoscjcv.supabase.co
- API keys are hardcoded in `lib/backend/supabase/supabase.dart`

## Development Setup

### Running the App
The app is configured to run as a web application on port 5000:
```bash
flutter run -d web-server --web-port 5000 --web-hostname 0.0.0.0
```

### Platform Support
- Web (primary for Replit)
- iOS (native)
- Android (native)

## Recent Changes
- **2025-10-07**: Initial Replit environment setup
  - Installed Flutter SDK via Nix
  - Configured web platform support
  - Set up workflow to run on port 5000
  - Added .gitignore for Flutter projects

## Features
- AI-powered headshot generation
- Photo enhancement (HD Photo, Fix Old Photo)
- Face swapping
- Multiple AI style templates (60+ styles)
- In-app purchases
- Multi-language support (EN, FR, ES, PT, ZH-Hans, ZH-Hant)
- AdMob integration for monetization

## User Preferences
None documented yet.
