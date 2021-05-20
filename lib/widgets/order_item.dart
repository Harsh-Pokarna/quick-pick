import 'package:flutter/material.dart';
import 'package:quick_pick/providers/orders.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class EachOrderDisplay extends StatefulWidget {
  final OrderItem orderItem;
  EachOrderDisplay(this.orderItem);

  @override
  _EachOrderDisplayState createState() => _EachOrderDisplayState();
}

class _EachOrderDisplayState extends State<EachOrderDisplay> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text(
                '${widget.orderItem.amount}',
              ),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm')
                    .format(widget.orderItem.dateTime),
              ),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_more : Icons.expand_less),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            if (_expanded)
              Container(
                height: min(
                    widget.orderItem.products.length.toDouble() * 20 + 100,
                    180),
                child: ListView(
                  children: widget.orderItem.products.map((prod) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          prod.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${prod.quantitiy}x Rs${prod.price}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
