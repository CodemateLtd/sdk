// Copyright (c) 2021, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analysis_server/src/protocol_server.dart';
import 'package:analyzer_utilities/check/check.dart';

class CompletionResponseForTesting {
  final int requestOffset;
  final int replacementOffset;
  final int replacementLength;
  final List<CompletionSuggestion> suggestions;

  CompletionResponseForTesting({
    required this.requestOffset,
    required this.replacementOffset,
    required this.replacementLength,
    required this.suggestions,
  });

  factory CompletionResponseForTesting.legacy(
    int requestOffset,
    CompletionResultsParams parameters,
  ) {
    return CompletionResponseForTesting(
      requestOffset: requestOffset,
      replacementOffset: parameters.replacementOffset,
      replacementLength: parameters.replacementLength,
      suggestions: parameters.results,
    );
  }
}

/// A completion suggestion with the response for context.
class CompletionSuggestionForTesting {
  final CompletionResponseForTesting response;
  final CompletionSuggestion suggestion;

  CompletionSuggestionForTesting({
    required this.response,
    required this.suggestion,
  });

  /// Return the effective replacement length.
  int get replacementLength =>
      suggestion.replacementLength ?? response.replacementLength;

  /// Return the effective replacement offset.
  int get replacementOffset =>
      suggestion.replacementOffset ?? response.replacementOffset;

  @override
  String toString() => '(completion: ${suggestion.completion})';
}

extension CompletionResponseExtension
    on CheckTarget<CompletionResponseForTesting> {
  CheckTarget<int> get replacementLength {
    return nest(
      value.replacementLength,
      (selected) => 'has replacementLength ${valueStr(selected)}',
    );
  }

  CheckTarget<int> get replacementOffset {
    return nest(
      value.replacementOffset,
      (selected) => 'has replacementOffset ${valueStr(selected)}',
    );
  }

  CheckTarget<List<CompletionSuggestionForTesting>> get suggestions {
    var suggestions = value.suggestions.map((e) {
      return CompletionSuggestionForTesting(
        response: value,
        suggestion: e,
      );
    }).toList();
    return nest(
      suggestions,
      (selected) => 'suggestions ${valueStr(selected)}',
    );
  }

  /// Check that the replacement offset is the completion request offset,
  /// and the length of the replacement is zero.
  void hasEmptyReplacement() {
    hasReplacement(left: 0, right: 0);
  }

  /// Check that the replacement offset is the completion request offset
  /// minus [left], and the length of the replacement is `left + right`.
  void hasReplacement({int left = 0, int right = 0}) {
    replacementOffset.isEqualTo(value.requestOffset - left);
    replacementLength.isEqualTo(left + right);
  }
}

extension CompletionSuggestionExtension
    on CheckTarget<CompletionSuggestionForTesting> {
  CheckTarget<String> get completion {
    return nest(
      value.suggestion.completion,
      (selected) => 'has completion ${valueStr(selected)}',
    );
  }

  CheckTarget<String?> get defaultArgumentListString {
    return nest(
      value.suggestion.defaultArgumentListString,
      (selected) => 'has defaultArgumentListString ${valueStr(selected)}',
    );
  }

  CheckTarget<List<int>?> get defaultArgumentListTextRanges {
    return nest(
      value.suggestion.defaultArgumentListTextRanges,
      (selected) => 'has defaultArgumentListTextRanges ${valueStr(selected)}',
    );
  }

  CheckTarget<String?> get docComplete {
    return nest(
      value.suggestion.docComplete,
      (selected) => 'has docComplete ${valueStr(selected)}',
    );
  }

  CheckTarget<String?> get docSummary {
    return nest(
      value.suggestion.docSummary,
      (selected) => 'has docSummary ${valueStr(selected)}',
    );
  }

  CheckTarget<Element?> get element {
    return nest(
      value.suggestion.element,
      (selected) => 'has element ${valueStr(selected)}',
    );
  }

  void get isField {
    kind.isIdentifier;
    element.isNotNull.kind.isField;
  }

  void get isParameter {
    kind.isIdentifier;
    element.isNotNull.kind.isParameter;
  }

  CheckTarget<CompletionSuggestionKind> get kind {
    return nest(
      value.suggestion.kind,
      (selected) => 'has kind ${valueStr(selected)}',
    );
  }

  CheckTarget<String?> get parameterType {
    return nest(
      value.suggestion.parameterType,
      (selected) => 'has parameterType ${valueStr(selected)}',
    );
  }

  /// Return the effective replacement length.
  CheckTarget<int> get replacementLength {
    return nest(
      value.replacementLength,
      (selected) => 'has replacementLength ${valueStr(selected)}',
    );
  }

  /// Return the effective replacement offset.
  CheckTarget<int> get replacementOffset {
    return nest(
      value.replacementOffset,
      (selected) => 'has replacementOffset ${valueStr(selected)}',
    );
  }

  CheckTarget<String?> get returnType {
    return nest(
      value.suggestion.returnType,
      (selected) => 'has returnType ${valueStr(selected)}',
    );
  }

  CheckTarget<int> get selectionLength {
    return nest(
      value.suggestion.selectionLength,
      (selected) => 'has selectionLength ${valueStr(selected)}',
    );
  }

  CheckTarget<int> get selectionOffset {
    return nest(
      value.suggestion.selectionOffset,
      (selected) => 'has selectionOffset ${valueStr(selected)}',
    );
  }

  /// Check that the effective replacement offset is the completion request
  /// offset, and the length of the replacement is zero.
  void hasEmptyReplacement() {
    hasReplacement(left: 0, right: 0);
  }

  /// Check that the effective replacement offset is the completion request
  /// offset minus [left], and the length of the replacement is `left + right`.
  void hasReplacement({int left = 0, int right = 0}) {
    replacementOffset.isEqualTo(value.response.requestOffset - left);
    replacementLength.isEqualTo(left + right);
  }

  void hasSelection({required int offset, int length = 0}) {
    selectionOffset.isEqualTo(offset);
    selectionLength.isEqualTo(length);
  }
}

extension CompletionSuggestionKindExtension
    on CheckTarget<CompletionSuggestionKind> {
  void get isIdentifier {
    isEqualTo(CompletionSuggestionKind.IDENTIFIER);
  }
}

extension CompletionSuggestionsExtension
    on CheckTarget<Iterable<CompletionSuggestionForTesting>> {
  CheckTarget<List<String>> get completions {
    return nest(
      value.map((e) => e.suggestion.completion).toList(),
      (selected) => 'completions ${valueStr(selected)}',
    );
  }

  CheckTarget<Iterable<CompletionSuggestionForTesting>> get namedArguments {
    var result = value
        .where((suggestion) =>
            suggestion.suggestion.kind ==
            CompletionSuggestionKind.NAMED_ARGUMENT)
        .toList();
    return nest(
      result,
      (selected) => 'named arguments ${valueStr(selected)}',
    );
  }
}

extension ElementExtension on CheckTarget<Element> {
  CheckTarget<ElementKind> get kind {
    return nest(
      value.kind,
      (selected) => 'has kind ${valueStr(selected)}',
    );
  }

  CheckTarget<String> get name {
    return nest(
      value.name,
      (selected) => 'has name ${valueStr(selected)}',
    );
  }
}

extension ElementKindExtension on CheckTarget<ElementKind> {
  void get isField {
    isEqualTo(ElementKind.FIELD);
  }

  void get isParameter {
    isEqualTo(ElementKind.PARAMETER);
  }
}
