import 'package:http/http.dart' as http;
import 'token_service.dart';

Future<void> fetchData() async {
  final token = await TokenService.getToken();

  final response = await http.get(
    Uri.parse('https://your-api.com/data'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    print('Data: ${response.body}');
  } else {
    print('Failed to fetch data');
  }
 }
// dhahsdhasdkjasdjnasdas
// das
//     das
// d
//     asdasd
// as
//     d
//     as
// d
//     asdasdasdasdasfasa
// sdasda
//     sdasd