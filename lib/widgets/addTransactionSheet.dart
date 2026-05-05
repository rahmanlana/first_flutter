import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:wri_fluter/models/trxModel.dart';
import 'package:wri_fluter/provider/trxProvider.dart';
import 'package:wri_fluter/services/trxService.dart';

class Addtransactionsheet extends StatefulWidget {
  const Addtransactionsheet({super.key});

  static Future<void> show(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Addtransactionsheet(),
    );
  }

  @override
  State<Addtransactionsheet> createState() => _AddtransactionsheetState();
}

class _AddtransactionsheetState extends State<Addtransactionsheet> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TransactionType selectedType = TransactionType.income;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(theme),
            const SizedBox(height: 24),
            _buldTypeToggle(theme),
            const SizedBox(height: 16),
            _buildTextField(
              controller: titleController,
              label: "Nama Transaksi",
              hint: "Misalnya: Gaji Bulanan",
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: amountController,
              label: "Jumlah",
              hint: "Masukkan jumlah transaksi",
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),
            _buildTextField(
              controller: noteController,
              label: "Catatan (Opsional)",
              hint: "Misalnya: Gaji bulan Oktober",
            ),
            const SizedBox(height: 12),
            _buildDatePicker(theme),
            const SizedBox(height: 24),
            _buildSubmitButton(theme, context),
            SizedBox(height: bottomInset), // Tambahkan padding untuk keyboard
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Row(
      children: [
        Text(
          "Tambah Transaction",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.close),
          style: IconButton.styleFrom(
            backgroundColor: theme.colorScheme.surfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buldTypeToggle(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedType = TransactionType.income;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: selectedType == TransactionType.income
                      ? const Color.fromARGB(255, 19, 163, 6)
                      : theme.colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Pemasukan",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedType = TransactionType.expense;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: selectedType == TransactionType.expense
                      ? const Color.fromARGB(255, 19, 163, 6)
                      : theme.colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Pengeluaran",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
  }) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
      ),
    );
  }

  Widget _buildDatePicker(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, color: Colors.white70, size: 18),
          const SizedBox(width: 8),
          Text(
            selectedDate.toString().split(' ')[0],
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Future submitTransaction(BuildContext context) async {
    // final provider = Provider.of<TransactionProvider>(context, listen: false);
    await context.read<TransactionProvider>().addTransaction(
      titleController.text,
      amountController.text,
      selectedDate.toIso8601String(),
      selectedType,
      noteController.text,
    );
    Navigator.of(context).pop();
  }

  Widget _buildSubmitButton(ThemeData theme, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        onPressed: () {
          // print("Title: ${titleController.text}");
          // print("Amount: ${amountController.text}");
          // print("Note: ${noteController.text}");
          // print("Date: ${selectedDate.toIso8601String()}");
          // print("Type: ${selectedType.name}");
          submitTransaction(context);
        },
        style: FilledButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 19, 163, 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "Simpan Transaksi",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
