import 'package:chopper/chopper.dart';
import '../models/partecipant.dart';

part 'api_service.chopper.dart';

@ChopperApi()
abstract class ApiService extends ChopperService {
  @POST(path: '/partecipants/')
  Future<Response> createPartecipant(@Body() Partecipant partecipant);

  static ApiService create({required String baseUrl}) {
    final client = ChopperClient(
      baseUrl: Uri.parse(baseUrl),
      services: [_$ApiService()],
      converter: JsonConverter(),
      errorConverter: JsonConverter(),
    );

    return _$ApiService(client);
  }
}
