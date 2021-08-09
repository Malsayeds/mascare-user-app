import 'package:doctoworld_user/Features/Auth/Login/UI/login_ui.dart';
import 'package:doctoworld_user/Features/Auth/Registration/UI/registration_ui.dart';
import 'package:doctoworld_user/Features/Auth/login_navigator.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Doctors/appointment_booked.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Doctors/book_appointment.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Doctors/doctor_info.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Doctors/doctor_map_view.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Doctors/doctor_review_page.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Doctors/list_of_doctors.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Doctors/search_doctors.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Doctors/search_history.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Doctors/sort_filter.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Hospitals/hospital_info.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Hospitals/hospital_map_view.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Medicine/medicine_info.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Medicine/medicines.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Medicine/my_cart.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Medicine/offers.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Medicine/order_placed_page.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Medicine/reviews_page.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Medicine/select_payment_method.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Medicine/seller_profile.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Medicine/shop_by_category_page.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Account/add_money.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Account/change_language_page.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Account/faq_page.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Account/saved_addresses_page.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Account/saved_page.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Account/support_page.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Account/tnc.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Account/wallet_page.dart';
import 'package:doctoworld_user/Features/BottomNavigation/appointments_page.dart';
import 'package:doctoworld_user/Features/BottomNavigation/bottom_navigation.dart';
import 'package:doctoworld_user/Features/BottomNavigation/hospitals_page.dart';
import 'package:doctoworld_user/Features/BottomNavigation/medicine_find_page.dart';
import 'package:doctoworld_user/Features/Checkout/confirm_order.dart';
import 'package:doctoworld_user/Features/Location/location_page.dart';
import 'package:doctoworld_user/Features/Pages/appointment_detail.dart';
import 'package:doctoworld_user/Features/Pages/chat_with_doctor.dart';
import 'package:doctoworld_user/Features/Pages/give_feedback.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Account/PillReminder/create_pill_reminder_page.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Account/PillReminder/pill_reminder_page.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Account/Order/recent_orders_page.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Account/Order/review_order_page.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Account/Order/order_info.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Account/Order/order_tracking_page.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Account/Order/chat_screen.dart';
import 'package:flutter/material.dart';

class PageRoutes {
  static const String findMedicinesPage = 'find_medicines_page';
  static const String bottomNavigation = 'bottom_navigation';
  static const String shopByCategory = 'shop_by_category';
  static const String medicines = 'medicines';
  static const String reviewsPage = 'reviews_page';
  static const String sellerProfile = 'seller_profile';
  static const String medicineInfo = 'medicine_info';
  static const String myCartPage = 'my_cart_page';
  static const String confirmOrderPage = 'confirm_order_page';
  static const String choosePaymentMethod = 'choose_payment_method';
  static const String orderPlacedPage = 'order_placed_page';
  static const String searchDoctors = 'search_doctors_page';
  static const String searchHistoryPage = 'search_history_page';
  static const String listOfDoctorsPage = 'list_of_doctors';
  static const String sortFilterPage = 'sort_filter';
  static const String doctorInfo = 'doctor_info';
  static const String doctorReviewPage = 'doctor_review_page';
  static const String bookAppointment = 'book_appointment';
  static const String appointmentBooked = 'appointment_booked';
  static const String giveFeedback = 'give_feedback';
  static const String hospitalsHome = 'hospitals_page';
  static const String hospitalMapView = 'hospital_map_view';
  static const String appointmentDetail = 'appointment_detail';
  static const String doctorChat = 'chat_with_doctor';
  static const String hospitalInfo = 'hospital_info';
  static const String walletPage = 'wallet_page';
  static const String addMoney = 'add_money';
  static const String createPillReminder = 'create_pill_reminder';
  static const String recentOrder = 'recent_orders_page';
  static const String orderTracking = 'order_tracking_page';
  static const String pillReminder = 'pill_reminder_page';
  static const String createReminder = 'create_pill_reminder_page';
  static const String faqPage = 'faq_page';
  static const String tncPage = 'tnc_page';
  static const String supportPage = 'support_page';
  static const String chatWithDelivery = 'chat_screen';
  static const String addressesPage = 'addresses_page';
  static const String locationPage = 'location_page';
  static const String savedPage = 'saved_page';
  static const String offersPage = 'offers_page';
  static const String reviewOrderPage = 'review_order_page';
  static const String orderInfoPage = 'order_info_page';
  static const String doctorMapView = 'doctor_map_view';
  static const String appointmentPage = 'appointments_page';
  static const String languagePage = 'language_page';
  static const String loginNavigator = 'loginNavigator';
  static const String register = 'register';
  static const String login = 'login';

  // static const String trial = 'trial';

  Map<String, WidgetBuilder> routes() {
    return {
      findMedicinesPage: (context) => MedicinePage(),
      bottomNavigation: (context) => BottomNavigation(),
      shopByCategory: (context) => ShopByCategoryPage(),
      medicines: (context) => MedicinesPage(),
      reviewsPage: (context) => ReviewPage(),
      sellerProfile: (context) => SellerProfilePage(),
      medicineInfo: (context) => ProductInfo(),
      myCartPage: (context) => CartPage(),
      confirmOrderPage: (context) => ConfirmOrder(),
      choosePaymentMethod: (context) => ChoosePaymentMethod(),
      orderPlacedPage: (context) => OrderPlacedPage(),
      searchDoctors: (context) => SearchDoctors(),
      searchHistoryPage: (context) => SearchHistoryPage(),
      listOfDoctorsPage: (context) => DoctorsPage(),
      sortFilterPage: (context) => SortFilter(),
      doctorInfo: (context) => DoctorInfo(),
      doctorReviewPage: (context) => DoctorReviewPage(),
      bookAppointment: (context) => BookAppointment(),
      appointmentBooked: (context) => AppointmentBooked(),
      giveFeedback: (context) => GiveFeedback(),
      hospitalsHome: (context) => HospitalsHome(),
      hospitalMapView: (context) => HospitalMapView(),
      appointmentDetail: (context) => AppointmentDetail(),
      doctorChat: (context) => DoctorChat(),
      hospitalInfo: (context) => HospitalInfo(),
      walletPage: (context) => WalletPage(),
      addMoney: (context) => AddMoney(),
      createPillReminder: (context) => CreatePillReminderPage(),
      recentOrder: (context) => RecentOrdersPage(),
      orderTracking: (context) => OrderTrackingPage(),
      pillReminder: (context) => PillReminderPage(),
      createReminder: (context) => CreatePillReminderPage(),
      faqPage: (context) => FAQPage(),
      supportPage: (context) => SupportPage(),
      tncPage: (context) => TnCPage(),
      chatWithDelivery: (context) => ChatScreen(),
      addressesPage: (context) => SavedAddressesPage(),
      locationPage: (context) => LocationPage(),
      savedPage: (context) => SavedPage(),
      offersPage: (context) => OffersPage(),
      reviewOrderPage: (context) => ReviewOrderPage(),
      orderInfoPage: (context) => OrderInfoPage(),
      doctorMapView: (context) => DoctorMapView(),
      appointmentPage: (context) => AppointmentPage(),
      languagePage: (context) => ChangeLanguagePage(true),
     // loginNavigator: (context) => LoginNavigator(),
      register: (context) => RegisterScreen(),
      login: (context) => LoginScreen(),

      // trial: (context) => Trail(),
    };
  }
}
