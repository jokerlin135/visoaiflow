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
The app is configured to run as a web application on port 5000. Use the build script to compile and serve the app:

```bash
./build_web.sh
python3 -m http.server 5000 --directory build/web --bind 0.0.0.0
```

Or use the configured workflow which runs automatically.

### Platform Support
- Web (primary for Replit, with limitations)
- iOS (native, recommended for full functionality)
- Android (native, recommended for full functionality)

### Known Limitations in Replit

**CRITICAL: Web Preview Not Functional**: The Replit preview environment does not support WebGL/GPU acceleration, and the installed Flutter version (3.32.0) does not support the `--web-renderer html` flag needed to compile for HTML renderer. This creates a fundamental incompatibility:

- The app compiles with CanvasKit renderer (requires WebGL)
- Replit's preview browser does not support WebGL
- Result: **Blank white screen in Replit preview**

**Current Workaround (Partial)**:
- The `build_web.sh` script attempts to patch the renderer configuration after build
- This changes the config but cannot remove CanvasKit dependencies from the compiled JavaScript
- The app may load intermittently but is not reliable

**Solutions**:
1. **Upgrade Flutter** (if possible): Use Flutter 3.10+ which supports `--web-renderer html` flag
2. **Test Locally**: Download the code and run on a WebGL-capable browser
3. **Deploy Elsewhere**: Use Vercel, Netlify, or Firebase Hosting which support WebGL
4. **Use Native Apps**: The iOS and Android builds will work perfectly without these limitations
5. **Regenerate from FlutterFlow**: If you have access to the original FlutterFlow project, regenerate with HTML renderer settings

## Import Status

**STATUS: PARTIAL IMPORT - Web Preview Not Functional**

The Flutter environment has been successfully set up in Replit with all dependencies installed, build scripts configured, and workflows established. However, the web preview does not render the app due to a fundamental compatibility issue between:
- Flutter's CanvasKit renderer (requires WebGL)
- Replit's preview browser (WebGL disabled)
- Available Flutter tooling (lacks `--web-renderer html` support)

**What Works:**
✅ Flutter SDK installed and configured
✅ All dependencies installed via `flutter pub get`
✅ Build system configured (`build_web.sh`)
✅ Workflow serving on port 5000
✅ Deployment configuration set
✅ Git ignore and documentation complete

**What Doesn't Work:**
❌ Web preview shows blank screen
❌ Cannot render UI in Replit environment
❌ Requires WebGL which Replit doesn't provide

**User Options:**
1. Use native iOS/Android builds (recommended)
2. Deploy to WebGL-capable hosting (Vercel, Netlify, Firebase)
3. Download and test locally in Chrome/Edge
4. Access FlutterFlow project and regenerate with HTML renderer

## Recent Changes
- **2025-10-08**: Fixed Fix Old Photo page navigation and UI
  - Back button (<-) now correctly navigates to homepage
  - Replaced Grab advertisement with bottom navigation bar (Home, AI Tools, Mine) + AdMob banner
  - Consistent navigation experience with other pages
  - Added 180px bottom padding to prevent content overlap with fixed navigation

- **2025-10-08**: Updated Supabase configuration for better security
  - Changed Supabase URL to new project: https://pmewibnkntbcaigkasnz.supabase.co
  - Migrated credentials to Replit Secrets (SUPABASE_URL, SUPABASE_ANON_KEY)
  - Code now uses String.fromEnvironment() instead of Platform.environment for web compatibility
  - Build script passes secrets via --dart-define flags
  - Improved security by removing secrets from source code

- **2025-10-08**: Cleaned up Mine page UI
  - Removed time/signal header (11:43, 🔇📶📱88) for cleaner design
  - More streamlined and professional appearance
  - Content starts directly with main features

- **2025-10-08**: Fixed duplicate navigation on Mine page
  - Removed hardcoded navigation bar that was showing duplicate tabs
  - Mine page now uses only the shared BottomNavigationWithAd component
  - Consistent navigation experience across all pages (Homepage, AI Tools, Mine)

- **2025-10-07**: Improved Pro page background for better readability
  - Changed background from flower image to purple-pink gradient
  - Gradient uses app theme colors (#7C3AED → #9810FA → #DB2777)
  - White text and UI elements now clearly readable on solid gradient background

- **2025-10-07**: Removed Grab advertisement from app
  - Removed Grab (VN) advertisement card from Homepage and Mine pages
  - Bottom navigation (Home, AI Tools, Mine) and AdMob banner remain intact
  - Cleaner UI without third-party app promotions

- **2025-10-07**: Removed unnecessary header from homepage
  - Removed time display ("11:31") and signal icons (📶 📶 90) from homepage top
  - Cleaned up UI to show only relevant content
  - Homepage now starts directly with main app content

- **2025-10-07**: Fixed dark mode issue in bottom navigation
  - Changed bottom navigation background from theme-based to hardcoded `Colors.white`
  - Resolves black background issue when Android phone is in dark mode
  - Navigation now displays correctly regardless of system theme settings

- **2025-10-07**: Fixed bottom navigation with banner ads
  - Created reusable `BottomNavigationWithAd` component at `lib/components/bottom_navigation_with_ad.dart`
  - Implemented fixed bottom navigation (Home, AI Tools, Mine tabs) across all main pages
  - Banner ads display below navigation and remain visible when scrolling
  - Updated Homepage, AI Tools, and Mine pages to use shared navigation widget
  - Added 180px bottom padding to content to prevent overlap with fixed navigation

- **2025-10-07**: Initial Replit environment setup
  - Installed Flutter SDK (3.32.0) via Nix
  - Configured web platform support
  - Created build script with renderer patching attempt
  - Set up workflow to serve static build on port 5000
  - Added .gitignore for Flutter projects
  - Documented WebGL/CanvasKit limitation

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
