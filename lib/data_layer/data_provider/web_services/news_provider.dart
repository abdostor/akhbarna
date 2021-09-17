import 'package:akhbarna/constants/strings.dart';
import 'package:akhbarna/data_layer/entities/article_model_entities.dart';
import 'package:akhbarna/data_layer/entities/news_model.dart';
import 'package:dio/dio.dart';

class NewsProvider {
  final Dio _dio = Dio();
  final _baseUrl = 'https://newsapi.org/v2/';
  final _APIKey = '20170889514c4c0f88e1839d33ffb096';

  NewsProvider() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: _baseUrl,
      sendTimeout: 2500,
      receiveTimeout: 2000,
    );
    _dio.options = baseOptions;
  }

  Future<List<ArticleEntitiesModel>> getTopHeadLine() async {
    try {
      Response response =
          await _dio.get('top-headlines?country=$country&apiKey=$_APIKey');

      List<ArticleEntitiesModel>? articles =
          NewsModel.fromJson(response.data).articles;

      return articles!;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<ArticleEntitiesModel>> searchForArticles(String search) async {
    Response response = await _dio.get(
      'everything?apiKey=$_APIKey',
      queryParameters: {
        'q': search,
        'from': '17-9-2021',
        'sortBy': 'popularity',
        'apiKey': _APIKey
      },
    );
    List<dynamic> data = response.data['articles'];
    List<ArticleEntitiesModel> searchArticles =
        data.map((e) => ArticleEntitiesModel.fromJson(e)).toList();
    print(searchArticles[0].title);
    return searchArticles;
  }
}
