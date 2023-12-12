import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart';
import 'package:jobhunt_ftl/blocs/app_riverpod_object.dart';

import '../../model/payment.dart';
import '../../value/keystring.dart';
import '../../value/style.dart';

class PaymentHistoryScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PaymentHistoryScreen();
}

class _PaymentHistoryScreen extends ConsumerState<PaymentHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            Keystring.PAYMENT_HISTORY.tr,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: appPrimaryColor,
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.primary,
          leading: IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back))),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Row(children: [
              SizedBox(width: 5),
              Expanded(flex:1, child: Text(Keystring.STT.tr,style: TextStyle(fontSize: 15),)),
              SizedBox(width: 5),
              Expanded(flex:2,child: Text(Keystring.TYPE_BANK.tr,style: TextStyle(fontSize: 15),)),
              SizedBox(width: 5),
              Expanded(flex:2,child: Text(Keystring.STATUS.tr,style: TextStyle(fontSize: 15),)),
              SizedBox(width: 5),
              Expanded(flex:2,child: Text(Keystring.PRICE.tr,style: TextStyle(fontSize: 15),)),
              SizedBox(width: 5),
              Expanded(flex:2,child: Text(Keystring.DATE_CREATED.tr,style: TextStyle(fontSize: 15),)),
              SizedBox(width: 5),
            ],),
          ),
          Container(height: 1,color: Colors.black,),
          ListHistoryPayment()
        ],
      ),
    );
  }
}

class ListHistoryPayment extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListHistoryPayment();
}

class _ListHistoryPayment extends ConsumerState<ListHistoryPayment> {
  @override
  Widget build(BuildContext context) {
    final _data = ref.watch(listHistoryPaymentsProvider);

    return _data.when(
      data: (data) {
        return data.isNotEmpty
            ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  String userId = data[index].userId ?? '';
                  String payment_type = data[index].payment_type ?? '';
                  String status = data[index].status ?? '';
                  String date = data[index].date ?? '';
                  String money = data[index].money ?? '';

                  return Container(
                    color: index % 2 == 0 ? Colors.black12 : Colors.white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 5),
                            Expanded(flex:1,child: Text(index.toString())),
                            SizedBox(width: 5),
                            Expanded(flex:2,child: Text(payment_type)),
                            SizedBox(width: 5),
                            Expanded(flex:2,child: Text(status==0?'':Keystring.SUCCESSFUL.tr,style: TextStyle(color: Colors.green),)),
                            SizedBox(width: 5),
                            Expanded(flex:2,child: Text(money)),
                            SizedBox(width: 5),
                            Expanded(flex:2,child: Text(date)),
                            SizedBox(width: 5),
                          ],
                        )
                      ],
                    ),
                  );
                },
                itemCount: data.length)
            : SizedBox(
                height: 160,
                child: Center(
                  child: Text(Keystring.NO_DATA.tr),
                ),
              );
      },
      error: (error, stackTrace) => SizedBox(
        height: 160,
        child: Center(
          child: Text(Keystring.NO_DATA.tr),
        ),
      ),
      loading: () => const SizedBox(
        height: 160,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
