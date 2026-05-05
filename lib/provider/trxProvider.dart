import 'package:flutter/material.dart';
import 'package:wri_fluter/models/trxModel.dart';
import 'package:wri_fluter/services/trxService.dart';
import 'package:uuid/uuid.dart';

class TransactionProvider extends ChangeNotifier {
  final service = TransactionService();
  final _uuid = Uuid();
  final List<TransactionModel> transactions = [];
  bool isLoading = false;

  Future<void> loadTransactions() async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await service.getAll();
      transactions.clear();
      transactions.addAll(data);
      notifyListeners();
    } catch (e) {
      print("Error loading transactions: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTransaction(
    String title,
    String amount,
    String date,
    TransactionType type,
    String? note,
  ) async {
    try {
      final model = TransactionModel(
        id: _uuid.v4(),
        amount: double.parse(amount),
        title: title,
        date: DateTime.parse(date),
        type: type,
        note: note,
      );
      await service.add(model);
    } catch (e) {
      print("Error adding transaction: $e");
    }
  }
}
