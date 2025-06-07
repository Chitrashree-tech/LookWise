import 'dart:convert';

import 'package:http/http.dart' as http;

class ChatGPTService {
  final String apiKey =
      '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'; // Replace with your key

  Future<String> sendMessage(String message) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final body = jsonEncode({
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": message},
      ],
      "max_tokens": 150,
      "temperature": 0.7,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final reply = data['choices'][0]['message']['content'];
      return reply.trim();
    } else {
      throw Exception(
        'Failed to get response: ${response.statusCode} ${response.body}',
      );
    }
  }
}
