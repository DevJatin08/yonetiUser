import 'package:userapp/Constant/Global.dart';
import 'package:userapp/Model/Response/ResponseModel.dart';
import 'package:userapp/Model/Reviews/TopReviews.dart';

class TopYoneti {
  TopReviews empty = TopReviews(reviews: []);

  Future<TopReviews> topReviews() async {
    final res = await apiCall.apiTopReviews();
    ResponseData responseData = ResponseData.fromJson(res);
    if (responseData.statusCode!) {
      TopReviews loc = TopReviews.fromJson(res['result']);
      loc.reviews!.sort((a, b) => (a.rank!).compareTo(b.rank!));
      return loc;
    } else {
      return empty;
    }
  }
}
