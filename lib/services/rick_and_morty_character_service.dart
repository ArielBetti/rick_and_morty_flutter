import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';
import 'package:rick_and_morty_flutter/models/RickAndMortyCharacter.dart';
import 'package:rick_and_morty_flutter/services/http_interceptors.dart';

class RickAndMortyCharacterService {
  http.Client client =
      InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  static const String url = "https://rickandmortyapi.com/api";
  static const String resource = "/character";

  getURI() {
    return "$url$resource";
  }

  Future<List<Results>> getAll() async {
    http.Response response = await client.get(Uri.parse(getURI()));

    try {
      if (response.statusCode == 200) {
        final persons = json.decode(response.body);
        final List<Results> personMap = (persons['results'] as List<dynamic>)
            .map((e) => Results.fromJson(e))
            .toList();

        return personMap;
      } else {
        throw Exception(('Failed to load characters'));
      }
    } catch (error) {
      rethrow;
    }
  }
}

class NetworkError extends Error {}
