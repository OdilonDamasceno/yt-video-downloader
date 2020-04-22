import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../.env.dart';

class HomeController {
  static String _baseUrl = Env().baseUrl;
  Dio dio = Dio(BaseOptions(baseUrl: _baseUrl));
  Future downloadVideo(String url) async {
    if (await canLaunch(_baseUrl))
      return await launch('$_baseUrl/video?URL=$url');
    else
      throw 'Could not launch $url';
  }

  Future downloadAudio(String url) async {
    if (await canLaunch('$_baseUrl'))
      return await launch('$_baseUrl/audio?URL=$url');
    else
      throw 'Could not launch $url';
  }

  Future<Response> getInfo(String url) async {
    if (await canLaunch('$_baseUrl'))
      return dio.get('/info', queryParameters: {"URL": url});
    else
      throw 'Could not launch $url';
  }
}
