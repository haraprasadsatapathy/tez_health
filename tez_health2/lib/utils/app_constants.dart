class AppConstants {
  // API Configuration
  static const String baseUrl = 'https://apitest.vmedo.com/api/';

  // API Endpoints
  static const String fetchCategoriesEndpoint = 'tez/FetchCategoryDetails';
  static const String fetchProductsEndpoint = 'tez/FetchProductsDetails';
  static const String fetchProductsByCategoryEndpoint = 'tez/FetchProductsByCategory';
  static const String fetchProductDetailsByIdEndpoint = 'tez/FetchProductsDetailsById';
  static const String searchProductsEndpoint = 'tez/SearchProducts';
  static const String bookingFormDetailEndpoint = 'tez/BookingFormDetail';

  // App Info
  static const String appName = 'Tez Health';
  static const String companyName = 'TezHealth Pvt Ltd.';
  static const String copyright = '© 2026 TezHealth Pvt Ltd.';

  // Social Media Links
  static const String facebookUrl = 'https://www.facebook.com/share/1Zgx91kvaS/?mibextid=wwXIfr';
  static const String twitterUrl = 'https://x.com';
  static const String youtubeUrl = 'https://youtube.com/@tezhealth?si=kgLD3FYObaglZexc';
  static const String instagramUrl = 'https://www.instagram.com/tez.health?igsh=NjM5OWx4M3Z6Mmk3';
  static const String linkedinUrl = 'https://linkedin.com';
  static const String googleReviewsUrl = 'https://www.google.com/search?q=vmedo+reviews';

  // Timing Constants
  static const int carouselAutoPlayInterval = 4; // seconds
  static const int searchDebounceTime = 400; // milliseconds
  static const int minSearchLength = 2;

  // Image Paths
  static const String logoBlue = 'assets/images/logo_blue.png';
  static const String logoWhite = 'assets/images/logo_white.png';
  static const String faviconLogo = 'assets/images/favicon_logo.png';
  static const String verifiedBadge = 'assets/images/verified.png';
  static const String workInProgress = 'assets/images/work-in-progress.png';
  static const String partnerTezHealth = 'assets/images/partner_tez_health.png';
  static const String doctorConsultation = 'assets/images/doctor_consultation.png';
  static const String doctorVisit = 'assets/images/doctor_visit.jpg';
  static const String vaccination = 'assets/images/vaccination.png';
  static const String category = 'assets/images/category.png';
  static const String home = 'assets/images/home.png';
  static const String shop = 'assets/images/shop.png';
  static const String motorcycle = 'assets/images/motorcycle.png';

  // Review Avatars
  static const String radhikaAvatar = 'assets/images/radhika_freebird.png';
  static const String sunilAvatar = 'assets/images/sunil_reddy.png';
  static const String heenaAvatar = 'assets/images/heena_shaman.png';

  // Error Images
  static const String error404 = 'assets/images/error/404.svg';
  static const String error500 = 'assets/images/error/500.svg';
  static const String error503 = 'assets/images/error/503.svg';
  static const String errorMaintenance = 'assets/images/error/maintenance.svg';
  static const String errorSuccess = 'assets/images/error/success.svg';
}
