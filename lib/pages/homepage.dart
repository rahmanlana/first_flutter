import 'package:flutter/material.dart';
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
    getTransactions();
  }

  getTransactions() async {
    final data = await trxService.getAll();
    setState(() => transactions.addAll(data));
    print(transactions.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Finance')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SummaryCard(),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: transactions.length,
                  itemBuilder: (_, i) => Transactioncard(),
                ),
              ],
            ),
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
