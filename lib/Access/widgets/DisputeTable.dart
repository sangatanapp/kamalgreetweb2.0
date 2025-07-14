import 'package:davi/davi.dart';
import 'package:flutter/widgets.dart';

class Person {
  Person(this.name, this.mobileNumber, this.subscriptionType,
      this.subscriptionId, this.createdAt);

  final String name;
  final String mobileNumber;
  final String subscriptionType;
  final String subscriptionId;
  final String createdAt;
}

class DisputeTable extends StatefulWidget {
  const DisputeTable({super.key});

  @override
  State<StatefulWidget> createState() => DisputeTableState();
}

class DisputeTableState extends State<DisputeTable> {
  late DaviModel<Person> _model;

  @override
  void initState() {
    super.initState();

    List<Person> rows = [
      Person('sumit', "9818004013", "success", "vhjkfdkhvj", "867896568"),
    ];

    _model = DaviModel(rows: rows, columns: [
      DaviColumn(name: 'name', cellValue: (params) => params.data.name),
      DaviColumn(
          name: 'mobile_number',
          cellValue: (params) => params.data.mobileNumber),
      DaviColumn(
          name: 'subscription_type',
          cellValue: (params) => params.data.subscriptionType),
      DaviColumn(
          name: 'subscription_id',
          cellValue: (params) => params.data.subscriptionId),
      DaviColumn(
          name: 'created_at', cellValue: (params) => params.data.createdAt)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Davi<Person>(_model);
  }
}
