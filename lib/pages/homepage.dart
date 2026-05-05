import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wri_fluter/provider/trxProvider.dart';
import 'package:wri_fluter/widgets/SummaryCard.dart';
import 'package:wri_fluter/widgets/addTransactionSheet.dart';
import 'package:wri_fluter/widgets/transactionCard.dart';
import 'package:wri_fluter/services/trxService.dart';
import 'package:wri_fluter/models/trxModel.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<TransactionModel> transactions = [];
  final TransactionService trxService = TransactionService();
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransactionProvider>(
        context,
        listen: false,
      ).loadTransactions();
    });
    // getTransactions();
  }

  // getTransactions() async {
  //   final data = await trxService.getAll();
  //   setState(() => transactions.addAll(data));
  //   print(transactions.length);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Finance')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<TransactionProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                children: [
                  SummaryCard(),
                  const SizedBox(height: 16),
                  ...provider.transactions
                      .map((e) => Transactioncard(trx: e))
                      .toList(),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: _buildFab(context),
    );
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => Addtransactionsheet.show(context),
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text("Tambah", style: TextStyle(color: Colors.white)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: const Color.fromARGB(255, 19, 163, 6),
    );
  }
}
