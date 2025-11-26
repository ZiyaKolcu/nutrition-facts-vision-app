// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Beslenme Bilgileri Görüntü Analizi';

  @override
  String get accountInfo => 'Hesap Bilgileri';

  @override
  String created(String date) {
    return 'Oluşturulma: $date';
  }

  @override
  String lastSignIn(String date) {
    return 'Son Giriş: $date';
  }

  @override
  String get signOut => 'Çıkış Yap';

  @override
  String get signOutConfirmTitle => 'Çıkış Yap';

  @override
  String get signOutConfirmMessage => 'Çıkış yapmak istediğinizden emin misiniz?';

  @override
  String get cancel => 'İptal';

  @override
  String get language => 'Dil';

  @override
  String get english => 'English';

  @override
  String get turkish => 'Türkçe';

  @override
  String signOutFailed(String error) {
    return 'Çıkış yapılamadı: $error';
  }

  @override
  String get unknown => 'Bilinmiyor';

  @override
  String get profile => 'Profil';

  @override
  String get birthDate => 'Doğum Tarihi';

  @override
  String get selectDate => 'Tarih Seç';

  @override
  String get gender => 'Cinsiyet';

  @override
  String get selectGender => 'Cinsiyet Seç';

  @override
  String get male => 'Erkek';

  @override
  String get female => 'Kadın';

  @override
  String get heightCm => 'Boy (cm)';

  @override
  String get enterHeight => 'Boy girin';

  @override
  String get weightKg => 'Ağırlık (kg)';

  @override
  String get enterWeight => 'Ağırlık girin';

  @override
  String get allergies => 'Alerjiler';

  @override
  String get healthConditions => 'Sağlık Durumları';

  @override
  String get dietaryPreferences => 'Beslenme tercihleri';

  @override
  String get add => 'Ekle';

  @override
  String addItem(String title) {
    return 'Ekle';
  }

  @override
  String get ok => 'Tamam';

  @override
  String get profileRefreshed => 'Profil güncellendi';

  @override
  String get newScan => 'Yeni Tarama';

  @override
  String get title => 'Başlık';

  @override
  String get enterTitle => 'Beslenme bilgileri için bir başlık girin';

  @override
  String get noPhotosAdded => 'Fotoğraf eklenmedi';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galeri';

  @override
  String get addPhoto => 'Fotoğraf Ekle';

  @override
  String get analyze => 'Analiz Et';

  @override
  String get remove => 'Kaldır';

  @override
  String get overview => 'Genel Bakış';

  @override
  String get askAI => 'Yapay Zekaya Sor';

  @override
  String get askAnything => 'Herhangi bir şey sorun...';

  @override
  String get aiHealthSummary => 'Yapay Zeka Sağlık Özeti';

  @override
  String get noIngredientData => 'İçerik verisi yok';

  @override
  String get noSummaryAvailable => 'Özet mevcut değil.';

  @override
  String error(String message) {
    return 'Hata: $message';
  }

  @override
  String get profileSetup => 'Profil Kurulumu';

  @override
  String get welcome => 'Hoş Geldiniz!';

  @override
  String get setupProfileDescription => 'Kişiselleştirilmiş beslenme önerileri sağlamak için profilinizi kuralım.';

  @override
  String get getStarted => 'Başla';

  @override
  String get whatsYourGender => 'Cinsiyetiniz nedir?';

  @override
  String get continueButton => 'Devam Et';

  @override
  String get whensBirthday => 'Doğum tarihiniz ne?';

  @override
  String get selectBirthDate => 'Doğum tarihinizi seçin';

  @override
  String get bodyMeasurements => 'Vücut ölçüleriniz';

  @override
  String get anyAllergies => 'Herhangi bir alerjiniz var mı?';

  @override
  String get addAllergies => 'Sahip olduğunuz gıda alerjilerini ekleyin';

  @override
  String get anyHealthConditions => 'Herhangi bir sağlık durumunuz var mı?';

  @override
  String get addHealthConditions => 'Bilmemiz gereken sağlık durumlarını ekleyin';

  @override
  String get addDietaryPreferences => 'Beslenme tercihlerinizi ekleyin (örn: Vegan, Vejetaryen)';

  @override
  String get finish => 'Bitir';

  @override
  String get newScanNav => 'Yeni Tarama';

  @override
  String get homeNav => 'Ana Ekran';

  @override
  String get profileNav => 'Profil';

  @override
  String get signIn => 'Giriş Yap';

  @override
  String get signUp => 'Kayıt Ol';

  @override
  String get welcomeBack => 'Hoş geldiniz';

  @override
  String get signInSubtitle => 'Devam etmek için giriş yapın';

  @override
  String get createAccount => 'Hesap oluştur';

  @override
  String get createAccountSubtitle => 'Hızlı ve güvenli';

  @override
  String get email => 'E-posta';

  @override
  String get password => 'Şifre';

  @override
  String get name => 'Ad';

  @override
  String get confirmPassword => 'Şifreyi onayla';

  @override
  String get pleaseEnterEmail => 'Lütfen e-postanızı girin';

  @override
  String get pleaseEnterPassword => 'Lütfen şifrenizi girin';

  @override
  String get pleaseEnterDisplayName => 'Lütfen görünen adınızı girin';

  @override
  String get minimumCharacters => 'En az 6 karakter';

  @override
  String get pleaseConfirmPassword => 'Lütfen şifrenizi onaylayın';

  @override
  String get passwordsDoNotMatch => 'Şifreler eşleşmiyor';

  @override
  String get signInFailed => 'Giriş yapılamadı';

  @override
  String get signUpFailed => 'Kayıt yapılamadı';

  @override
  String get dontHaveAccount => 'Hesabınız yok mu? Kayıt olun';

  @override
  String get alreadyHaveAccount => 'Zaten hesabınız var mı? Giriş yapın';

  @override
  String get noItemsAdded => 'Henüz öğe eklenmedi';

  @override
  String get skip => 'Atla';

  @override
  String get addItemButton => 'Öğe Ekle';

  @override
  String get noScansYet => 'Henüz tarama yok';

  @override
  String failedToLoadScans(String error) {
    return 'Taramalar yüklenemedi. $error';
  }

  @override
  String get scanIdMissing => 'Tarama kimliği eksik, silinemiyor';

  @override
  String deleteFailed(String error) {
    return 'Silme başarısız: $error';
  }

  @override
  String get noNutrientData => 'Besin değeri bulunamadı';

  @override
  String get nutrients => 'Besin Değerleri';
}
