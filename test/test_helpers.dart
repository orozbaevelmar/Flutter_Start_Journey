import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dartz/dartz.dart';

// Test utilities
void testPrint(String message) {
  log('\x1B[32m$message\x1B[0m');
}

void testError(String message) {
  log('\x1B[31m$message\x1B[0m');
}

// Test setup
void setUpTestEnvironment() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Set up any global test configurations here
  SharedPreferences.setMockInitialValues({});
}

// Test teardown
void tearDownTestEnvironment() {
  // Clean up any test resources here
}

// Common test assertions
void expectSuccess(Either<dynamic, dynamic> result) {
  expect(result.isRight(), true);
  expect(result.isLeft(), false);
}

void expectFailure(Either<dynamic, dynamic> result) {
  expect(result.isRight(), false);
  expect(result.isLeft(), true);
}

// Mock response helpers
Response mockResponse(String body, {int statusCode = 200}) {
  return Response(
    data: body,
    statusCode: statusCode,
    requestOptions: RequestOptions(path: ''),
  );
}
