import '../auth/authentication_types.dart';
import '../common/config.dart';
import '../common/constants.dart';
import '../voices/voices.dart';
import '../voices/voices_client.dart';
import '../voices/voices_response_mapper.dart';
import 'package:http/http.dart' as http;

class VoicesHandler {
  Future<VoicesSuccess> getVoices() async {
    final client = http.Client();
    final header = BearerAuthenticationHeader(token: Config.authToken!.token);
    final voiceClient = VoicesClient(client: client, header: header);

    try {
      final mapper = VoicesResponseMapper();
      final response = await voiceClient.get(Uri.parse(Endpoints.voicesList));
      final voicesResponse = mapper.map(response);
      if (voicesResponse is VoicesSuccess) {
        return voicesResponse;
      } else {
        throw voicesResponse;
      }
    } catch (e) {
      rethrow;
    }
  }
}
