import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:job_solution/constants/color_constant.dart';
import 'package:job_solution/models/card_model.dart';
import 'package:job_solution/models/operation_model.dart';
import 'package:job_solution/models/transaction_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;

  // Handle Indicator
  List<T> map<T>(List list, Function handle) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handle(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 8),
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: [
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SvgPicture.asset("assets/svg/drawer_icon.svg"),
                    Container(
                      width: 59,
                      height: 59,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          image: DecorationImage(
                              image: AssetImage('assets/images/user_photo.png'))),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good morning',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: kBlueColor),
                    ),
                    Text(
                      'Amanda Alax',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Container(
                height: 159,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 16, right: 6),
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        height: 159,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Color(cards[index].cardBackground)),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 158,
                              top: 22,
                              child: SvgPicture.asset(
                                  cards[index].cardElementBottom),
                            ),
                            Positioned(
                                child: SvgPicture.asset(
                                    cards[index].cardElementTop)),
                            Positioned(
                                left: 46,
                                top: 35,
                                child: Text(
                                  'Card Number',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )),
                            Positioned(
                                left: 46,
                                top: 65,
                                child: Text(
                                  cards[index].cardNumber,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )),
                          ],
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, bottom: 13, top: 29, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'operation',
                      style: TextStyle(fontSize: 20),
                    ),
                    Row(
                      children: map<Widget>(datas, (index, selected) {
                        return Container(
                          alignment: Alignment.centerLeft,
                          height: 9,
                          width: 9,
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                _current == index ? kBlueColor : kTenBlackColor,
                          ),
                        );
                      }),
                    )
                  ],
                ),
              ),
              Container(
                height: 123,
                child: ListView.builder(
                    itemCount: datas.length,
                    padding: EdgeInsets.only(left: 16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _current = index;
                          });
                        },
                        child: OperationCard(
                          operation: datas[index].name,
                          selectedIcon: datas[index].selectedIcon,
                          unselectedIcon: datas[index].unselectedIcon,
                          isSelected: _current == index,
                        ),
                      );
                    }),
              ),
              //Transaction Section
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, bottom: 13, top: 29, right: 8),
                child: Text(
                  'Transaction',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ListView.builder(
                  itemCount: transactions.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 57,
                      margin: EdgeInsets.only(bottom: 13),
                      padding: EdgeInsets.only(
                          left: 24, top: 12, bottom: 12, right: 22),
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: kTenBlackColor,
                            blurRadius: 10,
                            spreadRadius: 5,
                            offset: Offset(8.0, 8.0),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 57,
                                width: 57,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            transactions[index].photo)
                                    )
                                ),
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(transactions[index].name),
                                  Text(transactions[index].date),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(transactions[index].amount),

                            ],
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class OperationCard extends StatefulWidget {
  final String operation;
  final String selectedIcon;
  final String unselectedIcon;
  final bool isSelected;
  _HomePageState context;

  OperationCard(
      {Key key,
      this.operation,
      this.selectedIcon,
      this.unselectedIcon,
      this.isSelected,
      this.context});

  @override
  _OperationCardState createState() => _OperationCardState();
}

class _OperationCardState extends State<OperationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      height: 123,
      width: 123,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kTenBlackColor,
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(8.0, 8.0),
            )
          ],
          borderRadius: BorderRadius.circular(15),
          color: widget.isSelected ? kBlueColor : kWhiteColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            widget.isSelected ? widget.selectedIcon : widget.unselectedIcon,
          ),
          SizedBox(
            height: 13,
          ),
          Text(
            widget.operation,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: widget.isSelected ? kWhiteColor : kBlueColor),
          )
        ],
      ),
    );
  }
}
