# Nutrition Facts Vision App

A Flutter mobile application that allows users to scan food labels and receive a health risk analysis based on the listed ingredients. The app combines OCR (Optical Character Recognition) using Google ML Kit with AI-powered analysis through OpenAI's GPT-4o-mini model.

## Features

- User authentication (Email/Password) with Firebase  
- Profile screen with user information and settings 
- Home screen with history of previous scans 
- Health risk analysis based on ingredients 
- AI-powered insights using OpenAI GPT (mock implementation)
- Analysis screen showing risk levels and summaries 
- Scan food labels using the device camera 
- OCR recognition using Google ML Kit 

## Tech Stack

- **Flutter**: Cross-platform mobile development
- **Firebase Authentication**: User sign-up and login
- **Google ML Kit**: OCR label text extraction
- **FastAPI**: Backend services and database integration
- **PostgreSQL**: Storage for scan history and results
- **OpenAI API**: Ingredient risk evaluation via LLM