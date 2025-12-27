class AppConstants {
  // App Info
  static const String appName = 'Tez Health';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Your Health, Our Priority';

  // API Configuration
  static const String baseUrl = 'https://api.tezhealth.com';
  static const String apiVersion = '/api/v1';

  // Timeouts (in milliseconds)
  static const Duration connectTimeout = Duration(milliseconds: 30000);
  static const Duration receiveTimeout = Duration(milliseconds: 30000);
  static const Duration sendTimeout = Duration(milliseconds: 30000);

  // Storage Keys
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyUserRole = 'user_role';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  static const String keyOnboardingCompleted = 'onboarding_completed';

  // API Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String logoutEndpoint = '/auth/logout';
  static const String refreshTokenEndpoint = '/auth/refresh';
  static const String profileEndpoint = '/user/profile';
  static const String updateProfileEndpoint = '/user/profile/update';

  // Emergency Endpoints
  static const String emergencyEndpoint = '/emergency';
  static const String ambulanceBookingEndpoint = '/emergency/ambulance';
  static const String trackAmbulanceEndpoint = '/emergency/track';
  static const String hospitalNetworkEndpoint = '/emergency/hospitals';
  static const String sosEndpoint = '/emergency/sos';

  // Ambulance Types
  static const String ambulanceBLS = 'BLS'; // Basic Life Support
  static const String ambulanceALS = 'ALS'; // Advanced Life Support
  static const String ambulanceMortuary = 'Mortuary';

  // Healthcare Endpoints
  static const String doctorsEndpoint = '/healthcare/doctors';
  static const String diagnosticsEndpoint = '/healthcare/diagnostics';
  static const String nursingEndpoint = '/healthcare/nursing';
  static const String telemedicineEndpoint = '/healthcare/telemedicine';

  // Store Endpoints
  static const String productsEndpoint = '/store/products';
  static const String cartEndpoint = '/store/cart';
  static const String ordersEndpoint = '/store/orders';

  // Academy Endpoints
  static const String coursesEndpoint = '/academy/courses';
  static const String certificationsEndpoint = '/academy/certifications';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // SOS Configuration
  static const int sosCountdownSeconds = 3;
  static const String sosEmergencyNumber = '911';

  // Map Configuration
  static const double defaultZoom = 15.0;
  static const double defaultLatitude = 0.0;
  static const double defaultLongitude = 0.0;

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 32;
  static const int otpLength = 6;
  static const int otpExpiryMinutes = 5;

  // File Upload
  static const int maxFileSize = 10 * 1024 * 1024; // 10 MB
  static const List<String> allowedImageFormats = ['jpg', 'jpeg', 'png'];
  static const List<String> allowedDocumentFormats = ['pdf', 'doc', 'docx'];
}

class RouteNames {
  // Auth Routes
  static const String splash = '/';
  static const String roleSelection = '/role-selection';
  static const String login = '/login';
  static const String register = '/register';
  static const String otpVerification = '/otp-verification';
  static const String passwordRecovery = '/password-recovery';

  // Dashboard
  static const String dashboard = '/dashboard';
  static const String customerDashboard = '/customer-dashboard';
  static const String driverDashboard = '/driver-dashboard';

  // Emergency Module
  static const String emergency = '/emergency';
  static const String ambulanceBooking = '/emergency/ambulance-booking';
  static const String trackAmbulance = '/emergency/track-ambulance';
  static const String hospitalNetwork = '/emergency/hospital-network';

  // Healthcare Module
  static const String healthcare = '/healthcare';
  static const String doctorBooking = '/healthcare/doctor-booking';
  static const String diagnostics = '/healthcare/diagnostics';
  static const String nursing = '/healthcare/nursing';
  static const String telemedicine = '/healthcare/telemedicine';

  // Store Module
  static const String store = '/store';
  static const String productDetails = '/store/product';
  static const String cart = '/store/cart';
  static const String checkout = '/store/checkout';

  // Academy Module
  static const String academy = '/academy';
  static const String courseDetails = '/academy/course';
  static const String certifications = '/academy/certifications';

  // Profile Module
  static const String profile = '/profile';
  static const String userProfile = '/profile/user';
  static const String customerProfile = '/profile/customer';
  static const String editProfile = '/profile/edit';
  static const String settings = '/profile/settings';
  static const String savedAddresses = '/profile/addresses';
  static const String addAddress = '/profile/addresses/add';
  static const String ratingReview = '/profile/rating-review';

  // Driver Routes
  static const String addVehicle = '/driver/add-vehicle';
  static const String showVehicle = '/driver/show-vehicle';
  static const String documentUpload = '/driver/document-upload';
  static const String showDocuments = '/driver/show-documents';
  static const String addLoad = '/driver/add-load';
  static const String offerLoadsList = '/driver/offer-loads-list';
  static const String editOfferPrice = '/driver/edit-offer-price';
  static const String mapLocationPicker = '/driver/map-location-picker';
  static const String routeMap = '/driver/route-map';

  // Trip Routes
  static const String tripRequest = '/trip/request';
  static const String tripTracking = '/trip/tracking';

  // Payment Routes
  static const String payment = '/payment';
  static const String transactionHistory = '/payment/history';

  // Notifications
  static const String notifications = '/notifications';

  // Insurance
  static const String insurance = '/insurance';

  // Common
  static const String languageSelection = '/language-selection';
  static const String rating = '/rating';
}

class ErrorMessages {
  static const String networkError = 'Network error. Please check your internet connection.';
  static const String serverError = 'Server error. Please try again later.';
  static const String unauthorizedError = 'Unauthorized. Please login again.';
  static const String notFoundError = 'Resource not found.';
  static const String validationError = 'Please check your input and try again.';
  static const String unknownError = 'An unknown error occurred.';
  static const String timeoutError = 'Request timeout. Please try again.';
  static const String locationPermissionDenied = 'Location permission denied.';
  static const String locationServiceDisabled = 'Location services are disabled.';
}

class SuccessMessages {
  static const String loginSuccess = 'Login successful!';
  static const String registerSuccess = 'Registration successful!';
  static const String logoutSuccess = 'Logout successful!';
  static const String profileUpdateSuccess = 'Profile updated successfully!';
  static const String passwordChangeSuccess = 'Password changed successfully!';
  static const String bookingSuccess = 'Booking confirmed!';
  static const String orderPlaced = 'Order placed successfully!';
  static const String sosAlertSent = 'SOS alert sent successfully!';
  static const String sosTriggered = 'Emergency SOS triggered!';
  static const String documentUploadSuccess = 'Document uploaded successfully!';
  static const String vehicleAddedSuccess = 'Vehicle added successfully!';
}

class ValidationMessages {
  static const String emailRequired = 'Email is required';
  static const String emailInvalid = 'Please enter a valid email';
  static const String passwordRequired = 'Password is required';
  static const String passwordTooShort = 'Password must be at least 8 characters';
  static const String passwordMismatch = 'Passwords do not match';
  static const String phoneRequired = 'Phone number is required';
  static const String phoneInvalid = 'Please enter a valid phone number';
  static const String nameRequired = 'Name is required';
  static const String addressRequired = 'Address is required';
  static const String otpRequired = 'OTP is required';
  static const String otpInvalid = 'Please enter a valid OTP';
}

class UserRoles {
  static const String customer = 'customer';
  static const String driver = 'driver';
  static const String admin = 'admin';
}

class BookingStatus {
  static const String pending = 'pending';
  static const String confirmed = 'confirmed';
  static const String inProgress = 'in_progress';
  static const String completed = 'completed';
  static const String cancelled = 'cancelled';
}

class PaymentStatus {
  static const String pending = 'pending';
  static const String processing = 'processing';
  static const String completed = 'completed';
  static const String failed = 'failed';
  static const String refunded = 'refunded';
}
