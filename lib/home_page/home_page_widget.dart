import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../status/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../backend/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  TextEditingController textController1;
  TextEditingController textController2;
  final storage = new FlutterSecureStorage();
  bool passwordVisibility;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    passwordVisibility = false;
    checkLogin();
  }

  checkLogin() async {
    var username = await this.storage.read(key: "username");
    var password = await this.storage.read(key: "password");
    if (username != "" && password != "") {
      UserService.login(username, password).then((value) async {
        print(value);
        if (value) {
          await this.storage.write(key: "username", value: username);
          await this.storage.write(key: "password", value: password);
          await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.scale,
                alignment: Alignment.bottomCenter,
                duration: Duration(milliseconds: 200),
                reverseDuration: Duration(milliseconds: 200),
                child: StatusWidget(),
              ));
        } else {
          print('Fail');
          showDialog(
              context: context,
              builder: (context) => Center(
                      child: Material(
                    color: Colors.transparent,
                    child: Text('รหัสผ่านไม่ถูกต้อง'),
                  )));
        }
      });
    }
  }

  onLogin() async {
    var username = textController1.value.text;
    var password = textController2.value.text;
    print(username + password);
    UserService.login(username, password).then((value) async {
      print(value);
      if (value) {
        await this.storage.write(key: "username", value: username);
        await this.storage.write(key: "password", value: password);
        await Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.scale,
              alignment: Alignment.bottomCenter,
              duration: Duration(milliseconds: 200),
              reverseDuration: Duration(milliseconds: 200),
              child: StatusWidget(),
            ));
      } else {
        print('Fail');
        showDialog(
            context: context,
            builder: (context) => Center(
                    child: Material(
                  color: Colors.transparent,
                  child: Text('รหัสผ่านไม่ถูกต้อง'),
                )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 3),
                  child: Text(
                    'ระบบตรวจสอบการเข้าชั้นเรียน',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Mitr',
                          color: Color(0xFF343434),
                          fontSize: 28,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 20),
                  child: Text(
                    'สาขาวิทยาการคอมพิวเตอร์',
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Mitr',
                          color: Color(0xFF343434),
                          fontSize: 16,
                        ),
                  ),
                ),
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'รหัสนักศึกษา',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Mitr',
                                      color: Color(0xFF343434),
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              TextFormField(
                                controller: textController1,
                                obscureText: false,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFF5F5F5),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Mitr',
                                      color: Color(0xFF343434),
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'รหัสผ่าน',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Mitr',
                                      color: Color(0xFF343434),
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                              TextFormField(
                                controller: textController2,
                                obscureText: !passwordVisibility,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFF5F5F5),
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                      () => passwordVisibility =
                                          !passwordVisibility,
                                    ),
                                    child: Icon(
                                      passwordVisibility
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Color(0xFF757575),
                                      size: 22,
                                    ),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Mitr',
                                      color: Color(0xFF343434),
                                    ),
                              ),
                            ],
                          ),
                          FFButtonWidget(
                            onPressed: () => {onLogin()},
                            text: 'เข้าสู่ระบบ',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 50,
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
                        ],
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
