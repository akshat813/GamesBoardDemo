import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class RequestApi{

  static getHttpRequest(String url,{var headers}) async
  {
    try{
      var response = await http.get(Uri.parse(url));
      print("GetAPI $url, GetResponse $response");
      if(response.statusCode==200)
      {
        print("ResponseBody $url-> ${response.body}");
        return response.body;
      }
      else{
        print("Response error ${response.body}");
      }
    }

    catch(e)
    {
      print("EXCEPTION $e");
      Fluttertoast.showToast(msg: "Error: $e");
    }

  }
}