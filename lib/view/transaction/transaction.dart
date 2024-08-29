// lib/view/transaction/transaction_screen.dart
import 'package:flutter/material.dart';

import 'package:lifelinekerala/model/transactionmodel/transaction_model.dart';
import 'package:lifelinekerala/service/api_service.dart';
import 'widget/transaction_card.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  late Future<List<Transaction>> _transactionList;

  @override
  void initState() {
    super.initState();
    _transactionList = ApiService().getTransactionList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Your existing header code
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transactions',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    FutureBuilder<List<Transaction>>(
                      future: _transactionList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Failed to load transactions'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                              child: Text('No transactions available'));
                        } else {
                          return Column(
                            children: snapshot.data!.map((transaction) {
                              return TransactionCard(
                                date: transaction.date,
                                amount: transaction.amount,
                                referenceNumber: transaction.referenceNumber,
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
