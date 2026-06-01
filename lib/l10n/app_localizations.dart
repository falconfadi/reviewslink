import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @login.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get login;

  /// No description provided for @success.
  ///
  /// In ar, this message translates to:
  /// **'نجاح'**
  String get success;

  /// No description provided for @alert.
  ///
  /// In ar, this message translates to:
  /// **'تحذير'**
  String get alert;

  /// No description provided for @warning.
  ///
  /// In ar, this message translates to:
  /// **'تحذير'**
  String get warning;

  /// No description provided for @sign_up.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل حساب'**
  String get sign_up;

  /// No description provided for @phone.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف'**
  String get phone;

  /// No description provided for @password.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get confirmPassword;

  /// No description provided for @not_have_account.
  ///
  /// In ar, this message translates to:
  /// **'لا تملك حساب؟'**
  String get not_have_account;

  /// No description provided for @first_name.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الأول'**
  String get first_name;

  /// No description provided for @father_name.
  ///
  /// In ar, this message translates to:
  /// **'اسم الأب'**
  String get father_name;

  /// No description provided for @last_name.
  ///
  /// In ar, this message translates to:
  /// **'الكنية'**
  String get last_name;

  /// No description provided for @home.
  ///
  /// In ar, this message translates to:
  /// **'الصفحة الرئيسية'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In ar, this message translates to:
  /// **'الصفحة الشخصية'**
  String get profile;

  /// No description provided for @id.
  ///
  /// In ar, this message translates to:
  /// **'بطاقة مستفيد'**
  String get id;

  /// No description provided for @date.
  ///
  /// In ar, this message translates to:
  /// **'التاريخ'**
  String get date;

  /// No description provided for @doc_num.
  ///
  /// In ar, this message translates to:
  /// **'رقم الاستمارة'**
  String get doc_num;

  /// No description provided for @file_num.
  ///
  /// In ar, this message translates to:
  /// **'رقم الملف'**
  String get file_num;

  /// No description provided for @name.
  ///
  /// In ar, this message translates to:
  /// **'الاسم'**
  String get name;

  /// No description provided for @notifications.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get notifications;

  /// No description provided for @create_file.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء ملف للمستفيد'**
  String get create_file;

  /// No description provided for @settings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settings;

  /// No description provided for @edit.
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get edit;

  /// No description provided for @contact_info.
  ///
  /// In ar, this message translates to:
  /// **'معلومات التواصل'**
  String get contact_info;

  /// No description provided for @our_services.
  ///
  /// In ar, this message translates to:
  /// **'خدماتنا'**
  String get our_services;

  /// No description provided for @local_partners.
  ///
  /// In ar, this message translates to:
  /// **'الشركاء المحليين'**
  String get local_partners;

  /// No description provided for @ads.
  ///
  /// In ar, this message translates to:
  /// **'الإعلانات'**
  String get ads;

  /// No description provided for @volunteer_guide.
  ///
  /// In ar, this message translates to:
  /// **'دليل التطوع'**
  String get volunteer_guide;

  /// No description provided for @help.
  ///
  /// In ar, this message translates to:
  /// **'المساعدة'**
  String get help;

  /// No description provided for @news.
  ///
  /// In ar, this message translates to:
  /// **'الأخبار'**
  String get news;

  /// No description provided for @last_news.
  ///
  /// In ar, this message translates to:
  /// **'آخر الأخبار'**
  String get last_news;

  /// No description provided for @show_more.
  ///
  /// In ar, this message translates to:
  /// **'مشاهدة المزيد'**
  String get show_more;

  /// No description provided for @beneficiary_file.
  ///
  /// In ar, this message translates to:
  /// **'ملف المستفيد'**
  String get beneficiary_file;

  /// No description provided for @mobile_password_wrong.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف أو كلمة المرور غير صحيحة'**
  String get mobile_password_wrong;

  /// No description provided for @user_name_email.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف او الإيميل موجود مسبقاً'**
  String get user_name_email;

  /// No description provided for @empty_field.
  ///
  /// In ar, this message translates to:
  /// **'يوجد حقول فارغة'**
  String get empty_field;

  /// No description provided for @something_wrong.
  ///
  /// In ar, this message translates to:
  /// **'هناك خطأ ما'**
  String get something_wrong;

  /// No description provided for @refresh.
  ///
  /// In ar, this message translates to:
  /// **'تحديث'**
  String get refresh;

  /// No description provided for @head_family.
  ///
  /// In ar, this message translates to:
  /// **'اسم رب الأسرة'**
  String get head_family;

  /// No description provided for @date_of_birth.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الميلاد'**
  String get date_of_birth;

  /// No description provided for @honesty.
  ///
  /// In ar, this message translates to:
  /// **'الأمانة / القيد'**
  String get honesty;

  /// No description provided for @family_num.
  ///
  /// In ar, this message translates to:
  /// **'عدد أفراد الأسرة'**
  String get family_num;

  /// No description provided for @social_status.
  ///
  /// In ar, this message translates to:
  /// **'الحالة الاجتماعية'**
  String get social_status;

  /// No description provided for @family_book_num.
  ///
  /// In ar, this message translates to:
  /// **'رقم دفتر العائلة'**
  String get family_book_num;

  /// No description provided for @national_num.
  ///
  /// In ar, this message translates to:
  /// **'الرقم الوطني'**
  String get national_num;

  /// No description provided for @other_phone.
  ///
  /// In ar, this message translates to:
  /// **'هاتف احتياطي'**
  String get other_phone;

  /// No description provided for @student_grade_1.
  ///
  /// In ar, this message translates to:
  /// **'عدد الأولاد الطلبة الروضة'**
  String get student_grade_1;

  /// No description provided for @student_grade_2.
  ///
  /// In ar, this message translates to:
  /// **'عدد الأولاد الطلبة الابتدائي'**
  String get student_grade_2;

  /// No description provided for @student_grade_3.
  ///
  /// In ar, this message translates to:
  /// **'عدد الأولاد الطلبة الإعدادي'**
  String get student_grade_3;

  /// No description provided for @student_grade_4.
  ///
  /// In ar, this message translates to:
  /// **'عدد الأولاد الطلبة الثانوي'**
  String get student_grade_4;

  /// No description provided for @student_grade_5.
  ///
  /// In ar, this message translates to:
  /// **'عدد الأولاد الطلبة الجامعة'**
  String get student_grade_5;

  /// No description provided for @governorate.
  ///
  /// In ar, this message translates to:
  /// **'المحافظة'**
  String get governorate;

  /// No description provided for @area.
  ///
  /// In ar, this message translates to:
  /// **'المنطقة'**
  String get area;

  /// No description provided for @address_desc.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل العنوان'**
  String get address_desc;

  /// No description provided for @home_type.
  ///
  /// In ar, this message translates to:
  /// **'نوع السكن'**
  String get home_type;

  /// No description provided for @other_address_details.
  ///
  /// In ar, this message translates to:
  /// **'بيانات السكن الأخر'**
  String get other_address_details;

  /// No description provided for @rent_cost.
  ///
  /// In ar, this message translates to:
  /// **'مبلغ الإيجار'**
  String get rent_cost;

  /// No description provided for @workers_data.
  ///
  /// In ar, this message translates to:
  /// **'العاملين في الأسرة'**
  String get workers_data;

  /// No description provided for @assist_exists.
  ///
  /// In ar, this message translates to:
  /// **'هل توجد مساعدات أقارب؟'**
  String get assist_exists;

  /// No description provided for @assist_amount.
  ///
  /// In ar, this message translates to:
  /// **'قيمة المساعدة تقديرياً'**
  String get assist_amount;

  /// No description provided for @financial_aids.
  ///
  /// In ar, this message translates to:
  /// **'مساعدات مالية'**
  String get financial_aids;

  /// No description provided for @food_aids.
  ///
  /// In ar, this message translates to:
  /// **'مساعدات غذائية'**
  String get food_aids;

  /// No description provided for @medical_aids.
  ///
  /// In ar, this message translates to:
  /// **'مساعدات طبية'**
  String get medical_aids;

  /// No description provided for @educational_support.
  ///
  /// In ar, this message translates to:
  /// **'دعم تعليمي'**
  String get educational_support;

  /// No description provided for @psychological_support.
  ///
  /// In ar, this message translates to:
  /// **'دعم نفسي'**
  String get psychological_support;

  /// No description provided for @next.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get next;

  /// No description provided for @previous.
  ///
  /// In ar, this message translates to:
  /// **'السابق'**
  String get previous;

  /// No description provided for @personal_info.
  ///
  /// In ar, this message translates to:
  /// **'المعلومات الشخصية'**
  String get personal_info;

  /// No description provided for @attachment.
  ///
  /// In ar, this message translates to:
  /// **'الملفات'**
  String get attachment;

  /// No description provided for @worker_name.
  ///
  /// In ar, this message translates to:
  /// **'اسم العامل'**
  String get worker_name;

  /// No description provided for @work_place.
  ///
  /// In ar, this message translates to:
  /// **'العمل'**
  String get work_place;

  /// No description provided for @salary.
  ///
  /// In ar, this message translates to:
  /// **'الراتب'**
  String get salary;

  /// No description provided for @work_address.
  ///
  /// In ar, this message translates to:
  /// **'عنوان العمل'**
  String get work_address;

  /// No description provided for @add.
  ///
  /// In ar, this message translates to:
  /// **'إضافة'**
  String get add;

  /// No description provided for @attachment_type.
  ///
  /// In ar, this message translates to:
  /// **'نوع المرفق'**
  String get attachment_type;

  /// No description provided for @notes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات'**
  String get notes;

  /// No description provided for @file.
  ///
  /// In ar, this message translates to:
  /// **'المرفق'**
  String get file;

  /// No description provided for @attachments.
  ///
  /// In ar, this message translates to:
  /// **'المرفقات'**
  String get attachments;

  /// No description provided for @save.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get save;

  /// No description provided for @workers_data_empty.
  ///
  /// In ar, this message translates to:
  /// **'قائمة العاملين فارغة'**
  String get workers_data_empty;

  /// No description provided for @warning_working_data.
  ///
  /// In ar, this message translates to:
  /// **'يجب تعبئة المعلومات الشخصية أولاً'**
  String get warning_working_data;

  /// No description provided for @required_field.
  ///
  /// In ar, this message translates to:
  /// **'الحقول التي بجانبها الرمز (*) هي حقول إجبارية'**
  String get required_field;

  /// No description provided for @yes.
  ///
  /// In ar, this message translates to:
  /// **'نعم'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In ar, this message translates to:
  /// **'لا'**
  String get no;

  /// No description provided for @phone_note.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف غير قابل للتعديل'**
  String get phone_note;

  /// No description provided for @doc_preparing.
  ///
  /// In ar, this message translates to:
  /// **'جاري تحضير الاستمارة'**
  String get doc_preparing;

  /// No description provided for @add_worker_succ.
  ///
  /// In ar, this message translates to:
  /// **'تمت إضافة معلومات العامل بنجاح'**
  String get add_worker_succ;

  /// No description provided for @add_worker_loading.
  ///
  /// In ar, this message translates to:
  /// **'جاري تحضير البيانات'**
  String get add_worker_loading;

  /// No description provided for @delete_worker_loading.
  ///
  /// In ar, this message translates to:
  /// **'جاري حذف البيانات'**
  String get delete_worker_loading;

  /// No description provided for @edit_worker_loading.
  ///
  /// In ar, this message translates to:
  /// **'جاري تعديل البيانات'**
  String get edit_worker_loading;

  /// No description provided for @attachments_data_empty.
  ///
  /// In ar, this message translates to:
  /// **'قائمة المرفقات فارغة'**
  String get attachments_data_empty;

  /// No description provided for @show_attachment.
  ///
  /// In ar, this message translates to:
  /// **'عرض المرفق'**
  String get show_attachment;

  /// No description provided for @delete_attachment_loading.
  ///
  /// In ar, this message translates to:
  /// **'جاري حذف المرفق'**
  String get delete_attachment_loading;

  /// No description provided for @add_attachment_loading.
  ///
  /// In ar, this message translates to:
  /// **'جاري إضافة المرفق'**
  String get add_attachment_loading;

  /// No description provided for @status3.
  ///
  /// In ar, this message translates to:
  /// **'هل تريد إرسال الاستمارة للمراجعة؟'**
  String get status3;

  /// No description provided for @status3_note.
  ///
  /// In ar, this message translates to:
  /// **'تحذير: لن تتمكن من تعديل الاستمارة بعد إرسالها للمراحعة'**
  String get status3_note;

  /// No description provided for @status2.
  ///
  /// In ar, this message translates to:
  /// **'تم الموافقة على الاستمارة'**
  String get status2;

  /// No description provided for @status1.
  ///
  /// In ar, this message translates to:
  /// **'تم رفض الاستمارة'**
  String get status1;

  /// No description provided for @status0.
  ///
  /// In ar, this message translates to:
  /// **'استمارتك قيد المراجعة'**
  String get status0;

  /// No description provided for @send_to_review.
  ///
  /// In ar, this message translates to:
  /// **'إرسال للمراجعة'**
  String get send_to_review;

  /// No description provided for @reedit.
  ///
  /// In ar, this message translates to:
  /// **'إعادة التعديل'**
  String get reedit;

  /// No description provided for @loading_review.
  ///
  /// In ar, this message translates to:
  /// **'جاري إرسال الملف للمراجعة'**
  String get loading_review;

  /// No description provided for @loading_send_edit.
  ///
  /// In ar, this message translates to:
  /// **'جاري تحضير الملف'**
  String get loading_send_edit;

  /// No description provided for @rejected_note.
  ///
  /// In ar, this message translates to:
  /// **'سبب الرفض'**
  String get rejected_note;

  /// No description provided for @send_to_edit.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الملف'**
  String get send_to_edit;

  /// No description provided for @no_notifications.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد إشعارات'**
  String get no_notifications;

  /// No description provided for @last_ads.
  ///
  /// In ar, this message translates to:
  /// **'آخر الإعلانات'**
  String get last_ads;

  /// No description provided for @has_doc.
  ///
  /// In ar, this message translates to:
  /// **'لديك بطاقة مستفيد فعالة'**
  String get has_doc;

  /// No description provided for @my_services.
  ///
  /// In ar, this message translates to:
  /// **'خدماتي'**
  String get my_services;

  /// No description provided for @my_qrs.
  ///
  /// In ar, this message translates to:
  /// **'My QRs'**
  String get my_qrs;

  /// No description provided for @press_back_to_exit.
  ///
  /// In ar, this message translates to:
  /// **'اضغط مرة اخرى للخروج'**
  String get press_back_to_exit;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
