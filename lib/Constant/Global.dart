import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userapp/Services/SPHelper/SpHelper.dart';
import 'package:userapp/Services/Services/AboutYonetiService.dart';
import 'package:userapp/Services/Services/AddCardInfoService.dart';
import 'package:userapp/Services/Services/BookingService.dart';
import 'package:userapp/Services/Services/BookmarkService.dart';
import 'package:userapp/Services/Services/ChatService.dart';
import 'package:userapp/Services/Services/FeedbackService.dart';
import 'package:userapp/Services/Services/FilterService.dart';
import 'package:userapp/Services/Services/GetCommentService.dart';
import 'package:userapp/Services/Services/HomeService.dart';
import 'package:userapp/Services/Services/ImagesagainstuserService.dart';
import 'package:userapp/Services/Services/MarchantService.dart';
import 'package:userapp/Services/Services/NearbyService.dart';
import 'package:userapp/Services/Services/NotificationService.dart';
import 'package:userapp/Services/Services/OrderService.dart';
import 'package:userapp/Services/Services/PhotLikeService.dart';
import 'package:userapp/Services/Services/SwapBookingService.dart';
import 'package:userapp/Services/Services/TopPhotoService.dart';
import 'package:userapp/Services/Services/UserService.dart';
import 'package:userapp/Services/api_client/APICall.dart';
import 'package:userapp/Services/api_client/ErrorAndResponse/ErrorDisplay.dart';
import 'package:userapp/Services/api_client/ErrorAndResponse/ResponseMessage.dart';

late SharedPreferences sharedPreferences;
GlobalInitializer globalInitializer = GlobalInitializer();
SPHepler spHepler = SPHepler();
ResponseMessage responseMessage = ResponseMessage();
ErrorDisplay errorDisplay = ErrorDisplay();
APICall apiCall = APICall();
// late UserData userData;
// providers
final chatServiceProvider = ChangeNotifierProvider((m) => ChatService());
final userInfoProvider = ChangeNotifierProvider((m) => UserService());
final homeServiceProvider = ChangeNotifierProvider((m) => HomeService());
final marchantProvider = ChangeNotifierProvider((m) => MarchantService());
final orderProvider = ChangeNotifierProvider((m) => OrderSrervice());
final addcardProvider = ChangeNotifierProvider((m) => AddCardINfoService());
final feedbackProvider = ChangeNotifierProvider((m) => FeedBackService());
final notificationProvider = ChangeNotifierProvider((m) => NotificationService());
final bookmarkProvider = ChangeNotifierProvider((m) => BookmarkService());
final AboutyonetiProvider = ChangeNotifierProvider((m) => AboutYonetiService());
final topphotosProvider = ChangeNotifierProvider((m) => TopPhotosService());
final nearbyProvider = ChangeNotifierProvider((m) => NearbyService());
final getcommentProvider = ChangeNotifierProvider((m) => GetCommentService());
final getlikedataProvider = ChangeNotifierProvider((m) => GetLikeDataService());
final filterProvider = ChangeNotifierProvider((m) => FilterService());
final bookdetailsProvider = ChangeNotifierProvider((m) => BookdetailService());
final swapBookingProvider = ChangeNotifierProvider((m) => SwapBookingService());
final ImagesAgainstUserProvider = ChangeNotifierProvider((m) => ImagesAgainstUserService());

late String platform;
late String deviceId;

class GlobalInitializer {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  intialize() async {
    // shared pref
    sharedPreferences = await SharedPreferences.getInstance();
    // platform and device id

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        platform = 'Android';

        deviceId = androidInfo.androidId!; //UUID for Android
      } else if (Platform.isIOS) {
        platform = 'IOS';
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;

        deviceId = iosInfo.identifierForVendor!;
      } else {
        platform = 'Not define';
        deviceId = 'Not Found';
      }
    } catch (e) {
      print('Error in GlobalInitializer === ${e.toString()}');
    }
  }
}
