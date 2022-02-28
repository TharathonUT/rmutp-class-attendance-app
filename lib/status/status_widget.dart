import 'package:rmutp/backend/api.dart';

import '../browsing/browsing_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../home_page/home_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class StatusWidget extends StatefulWidget {
  const StatusWidget({Key key}) : super(key: key);

  @override
  _StatusWidgetState createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  FlutterBlue flutterBlue = FlutterBlue.instance;
  final storage = new FlutterSecureStorage();
  String roomNumber = "(กำลังตรวจสอบ...)";
  bool isStartingClass = true;
  String studentNumber = "";
  var userInfo;
  var classInfo;
  Timer classRoomChecking;
  String classStatus = "กำลังรอเริ่มชั้นเรียน";
  Color statusColor = Color(0xFFFFD500);

  logout() async {
    await this.storage.delete(key: 'username');
    await this.storage.delete(key: 'password');
    await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.scale,
                alignment: Alignment.bottomCenter,
                duration: Duration(milliseconds: 200),
                reverseDuration: Duration(milliseconds: 200),
                child: HomePageWidget(),
              ));
  }

  void checkClassRoom() {
    flutterBlue.stopScan();
    this.roomNumber = "(กำลังตรวจสอบ...)";
    var subscription = flutterBlue.scan();
    subscription.listen((event) {
      var ad = event.advertisementData;
      if (ad.localName.startsWith('R99')) {
        print(ad);
        setState(() {
          this.roomNumber = ad.localName.split('R')[1].split('D')[0];
          getClassInfo(this.roomNumber);
        });

        if (isStartingClass) {
          this.classRoomChecking =
              new Timer.periodic(Duration(minutes: 10), ((Timer timer) {
            flutterBlue.stopScan();
            var subscription = flutterBlue.scan();
            subscription.listen((event) {
              var rssi = event.rssi;
              var ad = event.advertisementData;
              if (ad.localName.startsWith('R99')) {
                print(ad);
                setState(() {
                  this.roomNumber = ad.localName.split('R')[1].split('D')[0];
                  getClassInfo(this.roomNumber);
                });
                flutterBlue.stopScan();
                print("stopped");
              } else {
                setState(() {
                  this.roomNumber = "ไม่พบห้องเรียน";
                });
                flutterBlue.stopScan();
                print("stopped");
              }
            });
          }));
        }

        flutterBlue.stopScan();
        print("stopped");
      }
    });
  }

  getInfo() async {
    var username = await this.storage.read(key: "username");
    var userInfo = await UserService.getInfo(username);
    setState(() {
      this.userInfo = userInfo;
      this.studentNumber = username;
    });
  }

  getClassInfo(room_number) async {
    var classInfo = await UserService.getClassInfo(room_number);
    setState(() {
      this.classInfo = classInfo;
    });
    if (classInfo['is_started'] == "1") {
      setState(() {
        this.classStatus = "เข้าเรียนปกติ";
        this.statusColor = Color(0xFF70FFA4);
      });
    }
    else{
      setState(() {
        this.classStatus = "กำลังรอเริ่มชั้นเรียน";
        this.statusColor = Color(0xFFFFD500);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    checkClassRoom();
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0x004B39EF),
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                duration: Duration(milliseconds: 300),
                reverseDuration: Duration(milliseconds: 300),
                child: BrowsingWidget(),
              ),
            );
          },
          child: Icon(
            Icons.menu_sharp,
            color: Colors.black,
            size: 24,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
            child: InkWell(
              onTap: () async {
                scaffoldKey.currentState.openEndDrawer();
              },
              child: Icon(
                Icons.settings_outlined,
                color: Colors.black,
                size: 24,
              ),
            ),
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      endDrawer: Drawer(
        elevation: 16,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                child: FFButtonWidget(
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  text: 'แก้ไขข้อมูลส่วนตัว',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50,
                    color: Color(0x004B39EF),
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Mitr',
                          color: Color(0xFF343434),
                        ),
                    elevation: 0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 12,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                child: FFButtonWidget(
                  onPressed: () {
                    logout();
                  },
                  text: 'ออกจากระบบ',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50,
                    color: Color(0x004B39EF),
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Mitr',
                          color: Color(0xFF343434),
                        ),
                    elevation: 0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: statusColor,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 30),
                    child: Text(
                      classStatus,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Mitr',
                            color: Color(0xFF343434),
                            fontSize: 25,
                          ),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 1),
                      child: Text(
                        userInfo['first_name'] + " " + userInfo['last_name'],
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Mitr',
                              color: Color(0xFF343434),
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 10),
                      child: Text(
                        '$studentNumber',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Mitr',
                              color: Color(0xFF343434),
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                  ],
                ),
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Color(0xFFF5F5F5),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Color(0x00FFFFFF),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Color(0x00EEEEEE),
                              ),
                              child: Text(
                                'ห้องเรียน $roomNumber',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Mitr',
                                      color: Color(0xFF343434),
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'รหัสวิชา :',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Mitr',
                                              color: Color(0xFF343434),
                                            ),
                                      ),
                                      Text(
                                        classInfo['subject_id'],
                                        textAlign: TextAlign.justify,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Mitr',
                                              color: Color(0xFF343434),
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'ชื่อวิชา :',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Mitr',
                                              color: Color(0xFF343434),
                                            ),
                                      ),
                                      Text(
                                        classInfo['subject_name'],
                                        textAlign: TextAlign.justify,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Mitr',
                                              color: Color(0xFF343434),
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'อาจารย์ผู้สอน :',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Mitr',
                                              color: Color(0xFF343434),
                                            ),
                                      ),
                                      Text(
                                        classInfo['first_name'] +
                                            " " +
                                            classInfo['last_name'],
                                        textAlign: TextAlign.justify,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Mitr',
                                              color: Color(0xFF343434),
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'เวลาเรียน:',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Mitr',
                                              color: Color(0xFF343434),
                                            ),
                                      ),
                                      Text(
                                        classInfo['on_week_date'],
                                        textAlign: TextAlign.justify,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Mitr',
                                              color: Color(0xFF343434),
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 20, 5, 0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      checkClassRoom();
                                    },
                                    text: 'รีเฟรช',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 30,
                                      color: Color(0xFFFFD500),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Mitr',
                                            color: Color(0xFF343434),
                                          ),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
