import 'package:get/get.dart';
import 'package:reviews_link_v2/pages/change_password/binding.dart';
import 'package:reviews_link_v2/pages/change_password/index.dart';
import 'package:reviews_link_v2/pages/auth/create_account/binding.dart';
import 'package:reviews_link_v2/pages/auth/create_account/index.dart';
import 'package:reviews_link_v2/pages/main_page/services/reviews/binding.dart';
import 'package:reviews_link_v2/pages/main_page/services/reviews/index.dart';
import 'package:reviews_link_v2/pages/main_page/services/social_media_services/binding.dart';
import 'package:reviews_link_v2/pages/main_page/services/social_media_services/index.dart';
import 'package:reviews_link_v2/pages/qr_requests/binding.dart';
import 'package:reviews_link_v2/pages/qr_requests/create_qr_request/binding.dart';
import 'package:reviews_link_v2/pages/qr_requests/create_qr_request/index.dart';
import 'package:reviews_link_v2/pages/qr_requests/index.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/binding.dart';
import 'package:reviews_link_v2/pages/main_page/services/create_service/index.dart';
import 'package:reviews_link_v2/pages/support_tickets/create_support_tickets/binding.dart';
import 'package:reviews_link_v2/pages/support_tickets/create_support_tickets/index.dart';
import 'package:reviews_link_v2/pages/auth/forget_password/binding.dart';
import 'package:reviews_link_v2/pages/auth/forget_password/index.dart';
import 'package:reviews_link_v2/pages/auth/login/binding.dart';
import 'package:reviews_link_v2/pages/auth/login/index.dart';
import 'package:reviews_link_v2/pages/main_page/binding.dart';
import 'package:reviews_link_v2/pages/main_page/index.dart';
import 'package:reviews_link_v2/pages/profile/binding.dart';
import 'package:reviews_link_v2/pages/profile/index.dart';
import 'package:reviews_link_v2/pages/splash/binding.dart';
import 'package:reviews_link_v2/pages/splash/index.dart';
import 'package:reviews_link_v2/pages/support_tickets/support_ticket_details/binding.dart';
import 'package:reviews_link_v2/pages/support_tickets/support_ticket_details/index.dart';
import 'package:reviews_link_v2/pages/support_tickets/binding.dart';
import 'package:reviews_link_v2/pages/support_tickets/index.dart';
import 'package:reviews_link_v2/pages/auth/verification_code/binding.dart';
import 'package:reviews_link_v2/pages/auth/verification_code/index.dart';

abstract class AppRouting {
  static List<GetPage> routes() => [
    GetPage(
      name: Pages.splash.value,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Pages.login.value,
      page: () => LogInPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Pages.createAccount.value,
      page: () => CreateAccountPage(),
      binding: CreateAccountBinding(),
    ),
    GetPage(
      name: Pages.forgetPassword.value,
      page: () => ForgetPasswordPage(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: Pages.verificationCode.value,
      page: () => VerificationCodePage(),
      binding: VerificationCodeBinding(),
    ),
    GetPage(
      name: Pages.mainPage.value,
      page: () => MainPage(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: Pages.changePassword.value,
      page: () => ChangePasswordPage(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: Pages.profile.value,
      page: () => ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Pages.createQrRequest.value,
      page: () => CreateQRRequestPage(),
      binding: CreateQRRequestBinding(),
    ),
    GetPage(
      name: Pages.createService.value,
      page: () => CreateServicePage(),
      binding: CreateServiceBinding(),
    ),
    GetPage(
      name: Pages.socialMediaServices.value,
      page: () => SocialMediaServicesPage(),
      binding: SocialMediaServicesBinding(),
    ),
    GetPage(
      name: Pages.myQrRequests.value,
      page: () => QrRequestsPage(),
      binding: QrRequestsBinding(),
    ),
    GetPage(
      name: Pages.createSupportTickets.value,
      page: () => CreateSupportTicketsPage(),
      binding: CreateSupportTicketsBinding(),
    ),
    GetPage(
      name: Pages.showSupportTickets.value,
      page: () => SupportTicketsPage(),
      binding: SupportTicketsBinding(),
    ),
    GetPage(
      name: Pages.showSupportTicketDetails.value,
      page: () => SupportTicketDetailsPage(),
      binding: SupportTicketDetailsBinding(),
    ),
    GetPage(
      name: Pages.reviews.value,
      page: () => ReviewsPage(),
      binding: ReviewsBinding(),
    ),
  ];
}

enum Pages {
  splash,
  login,
  createAccount,
  forgetPassword,
  verificationCode,
  mainPage,
  changePassword,
  profile,
  servicesListProducts,
  servicesSingleProduct,
  servicesRestaurantMenu,
  createQrRequest,
  createService,
  socialMediaServices,
  myQrRequests,
  createSupportTickets,
  showSupportTickets,
  showSupportTicketDetails,
  reviews
}

extension PagesExtension on Pages {
  String get value {
    switch (this) {
      case Pages.splash:
        return '/';
      case Pages.login:
        return '/login';
      case Pages.createAccount:
        return '/createAccount';
      case Pages.forgetPassword:
        return '/forgetPassword';
      case Pages.verificationCode:
        return '/verificationCode';
      case Pages.mainPage:
        return '/mainPage';
      case Pages.changePassword:
        return '/changePassword';
      case Pages.profile:
        return '/profile';
      case Pages.servicesListProducts:
        return '/servicesListProducts';
      case Pages.servicesSingleProduct:
        return '/servicesSingleProduct';
      case Pages.servicesRestaurantMenu:
        return '/servicesRestaurantMenu';
      case Pages.createQrRequest:
        return '/createQrRequest';
      case Pages.createService:
        return '/createService';
      case Pages.socialMediaServices:
        return '/socialMediaServices';
      case Pages.myQrRequests:
        return '/myQrRequests';
      case Pages.createSupportTickets:
        return '/createSupportTickets';
      case Pages.showSupportTickets:
        return '/showSupportTickets';
      case Pages.showSupportTicketDetails:
        return '/showSupportTicketDetails';
      case Pages.reviews:
        return '/reviews';
    }
  }
}

abstract class Navigation {
  static Pages? getPage(String route) {
    switch (route) {
      case '/':
        return Pages.splash;
      case '/login':
        return Pages.login;
      case '/createAccount':
        return Pages.createAccount;
      case '/forgetPassword':
        return Pages.forgetPassword;
      case '/verificationCode':
        return Pages.verificationCode;
      case '/mainPage':
        return Pages.mainPage;
      case '/changePassword':
        return Pages.changePassword;
      case '/profile':
        return Pages.profile;
      case '/servicesListProducts':
        return Pages.servicesListProducts;
      case '/servicesSingleProduct':
        return Pages.servicesSingleProduct;
      case '/servicesRestaurantMenu':
        return Pages.servicesRestaurantMenu;
      case '/createQrRequest':
        return Pages.createQrRequest;
      case '/createService':
        return Pages.createService;
      case '/socialMediaServices':
        return Pages.socialMediaServices;
      case '/myQrRequests':
        return Pages.myQrRequests;
      case '/createSupportTickets':
        return Pages.createSupportTickets;
      case '/showSupportTickets':
        return Pages.showSupportTickets;
      case '/showSupportTicketDetails':
        return Pages.showSupportTicketDetails;
      case '/reviews':
        return Pages.reviews;
      default:
        return null;
    }
  }
}
