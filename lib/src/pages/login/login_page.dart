import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school/src/game/game_screen.dart';
import 'package:school/src/pages/calendar/calendar_page.dart';
import 'package:school/src/pages/grade/data_screen.dart';
import 'package:school/src/pages/grade/student_details.dart';
import 'package:school/src/pages/login/login_controller.dart';
import 'package:school/src/quiz/home_screen.dart';
import '../../components/main_button.dart';
import '../../helpers/font_size.dart';
import '../../helpers/theme_colors.dart';
import '../my_home_page/home_page.dart';
import '../signup/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  String? userType; // Variable para almacenar el tipo de usuario seleccionado

  @override
  void initState() {

    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's get you in!",
                  style: GoogleFonts.poppins(
                    color: ThemeColors.whiteTextColor,
                    fontSize: FontSize.xxLarge,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Text(
                    "Login to your account.",
                    style: GoogleFonts.poppins(
                      color: ThemeColors.greyTextColor,
                      fontSize: FontSize.medium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 70),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ///Email Input Field
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (_emailController.text.isEmpty) {
                            return "This field can't be empty";
                          }
                        },
                        style: GoogleFonts.poppins(
                          color: ThemeColors.whiteTextColor,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: ThemeColors.primaryColor,
                        decoration: InputDecoration(
                          fillColor: ThemeColors.textFieldBgColor,
                          filled: true,
                          hintText: "Carnet de identidad",
                          hintStyle: GoogleFonts.poppins(
                            color: ThemeColors.textFieldHintColor,
                            fontSize: FontSize.medium,
                            fontWeight: FontWeight.w400,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      PopupMenuButton<String>(
                        onSelected: (String value) {
                          setState(() {
                            userType = value;
                          });
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'Estudiante',
                            child: Text('Estudiante'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Apoderado',
                            child: Text('Apoderado'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Profesor',
                            child: Text('Profesor'),
                          ),
                        ],
                        child: Container(
                          decoration: BoxDecoration(
                            color: ThemeColors.primaryColor, // Cambiar el color de fondo del botón
                            borderRadius: BorderRadius.circular(8.0), // Cambiar la forma del botón
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Selecciona tu tipo',
                                style: TextStyle(color: Colors.white), // Cambiar el color del texto del botón
                              ),
                              Icon(Icons.arrow_drop_down, color: Colors.white), // Cambiar el color del icono
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            "Forgot password?",
                            style: GoogleFonts.poppins(
                              color: ThemeColors.greyTextColor,
                              fontSize: FontSize.medium,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 70),
                      MainButton(
                        onTap: () {
                          if (userType == 'Estudiante') {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                // builder: (context) => DataScreen(ci: _emailController.text), // Pasa el CI aquí
                                builder: (context) => HomeScreen(ci: _emailController.text),
                              ),
                            );
                          } else if (userType == 'Apoderado') {
                            // Navegar a la pantalla de apoderado
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => StudentDetails(ci: _emailController.text), // Pasa el CI aquí
                              ),
                            );
                          } else if (userType == 'Profesor') {

                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => CalendarPage(UserRole.admin), // Pasa el CI aquí
                              ),
                            );
                          } else {
                            // Si no se ha seleccionado un tipo de usuario
                            // mostrar un mensaje o hacer algo
                          }
                        },
                        text: 'Login',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: GoogleFonts.poppins(
                          color: ThemeColors.whiteTextColor,
                          fontSize: FontSize.medium,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ),
                        ),
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.poppins(
                            color: ThemeColors.primaryColor,
                            fontSize: FontSize.medium,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}