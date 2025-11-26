// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Nutrition Facts Vision';

  @override
  String get accountInfo => 'Account Info';

  @override
  String created(String date) {
    return 'Created: $date';
  }

  @override
  String lastSignIn(String date) {
    return 'Last Sign In: $date';
  }

  @override
  String get signOut => 'Sign Out';

  @override
  String get signOutConfirmTitle => 'Sign Out';

  @override
  String get signOutConfirmMessage => 'Are you sure you want to sign out?';

  @override
  String get cancel => 'Cancel';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get turkish => 'Türkçe';

  @override
  String signOutFailed(String error) {
    return 'Sign out failed: $error';
  }

  @override
  String get unknown => 'Unknown';

  @override
  String get profile => 'Profile';

  @override
  String get birthDate => 'Birth Date';

  @override
  String get selectDate => 'Select Date';

  @override
  String get gender => 'Gender';

  @override
  String get selectGender => 'Select Gender';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get heightCm => 'Height (cm)';

  @override
  String get enterHeight => 'Enter height';

  @override
  String get weightKg => 'Weight (kg)';

  @override
  String get enterWeight => 'Enter weight';

  @override
  String get allergies => 'Allergies';

  @override
  String get healthConditions => 'Health Conditions';

  @override
  String get dietaryPreferences => 'Dietary preferences?';

  @override
  String get add => 'Add';

  @override
  String addItem(String title) {
    return 'Add';
  }

  @override
  String get ok => 'OK';

  @override
  String get profileRefreshed => 'Profile refreshed';

  @override
  String get newScan => 'New Scan';

  @override
  String get title => 'Title';

  @override
  String get enterTitle => 'Enter a title for the nutrition facts';

  @override
  String get noPhotosAdded => 'No photos added';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get addPhoto => 'Add Photo';

  @override
  String get analyze => 'Analyze';

  @override
  String get remove => 'Remove';

  @override
  String get overview => 'Overview';

  @override
  String get askAI => 'Ask AI';

  @override
  String get askAnything => 'Ask anything...';

  @override
  String get aiHealthSummary => 'AI Health Summary';

  @override
  String get noIngredientData => 'No ingredient data available';

  @override
  String get noSummaryAvailable => 'No summary available.';

  @override
  String error(String message) {
    return 'Error: $message';
  }

  @override
  String get profileSetup => 'Profile Setup';

  @override
  String get welcome => 'Welcome!';

  @override
  String get setupProfileDescription => 'Let\'s set up your profile to provide personalized nutrition recommendations.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get whatsYourGender => 'What\'s your gender?';

  @override
  String get continueButton => 'Continue';

  @override
  String get whensBirthday => 'When\'s your birthday?';

  @override
  String get selectBirthDate => 'Select your birth date';

  @override
  String get bodyMeasurements => 'Your body measurements';

  @override
  String get anyAllergies => 'Any allergies?';

  @override
  String get addAllergies => 'Add any food allergies you have';

  @override
  String get anyHealthConditions => 'Any health conditions?';

  @override
  String get addHealthConditions => 'Add any health conditions we should know about';

  @override
  String get addDietaryPreferences => 'Add your dietary preferences (e.g., Vegan, Vegetarian)';

  @override
  String get finish => 'Finish';

  @override
  String get newScanNav => 'New Scan';

  @override
  String get homeNav => 'Home';

  @override
  String get profileNav => 'Profile';

  @override
  String get signIn => 'Sign In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get signInSubtitle => 'Sign in to continue';

  @override
  String get createAccount => 'Create account';

  @override
  String get createAccountSubtitle => 'Quick & secure';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get name => 'Name';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get pleaseEnterEmail => 'Please enter your email';

  @override
  String get pleaseEnterPassword => 'Please enter your password';

  @override
  String get pleaseEnterDisplayName => 'Please enter your display name';

  @override
  String get minimumCharacters => 'Minimum 6 characters';

  @override
  String get pleaseConfirmPassword => 'Please confirm your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get signInFailed => 'Sign-in failed';

  @override
  String get signUpFailed => 'Sign-up failed';

  @override
  String get dontHaveAccount => 'Don\'t have an account? Sign up';

  @override
  String get alreadyHaveAccount => 'Already have an account? Sign in';

  @override
  String get noItemsAdded => 'No items added yet';

  @override
  String get skip => 'Skip';

  @override
  String get addItemButton => 'Add Item';

  @override
  String get noScansYet => 'No scans yet';

  @override
  String failedToLoadScans(String error) {
    return 'Failed to load scans. $error';
  }

  @override
  String get scanIdMissing => 'Scan id missing, cannot delete';

  @override
  String deleteFailed(String error) {
    return 'Delete failed: $error';
  }

  @override
  String get noNutrientData => 'No nutrient data available';

  @override
  String get nutrients => 'Nutrients';
}
