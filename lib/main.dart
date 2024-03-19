import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants/Themes.dart';
import 'package:flutter_application_1/Constants/cache%20helper.dart';
import 'package:flutter_application_1/Inner%20Screens/Product%20Details.dart';
import 'package:flutter_application_1/Inner%20Screens/categiory%20screen.dart';
import 'package:flutter_application_1/Inner%20Screens/feed%20Screen.dart';
import 'package:flutter_application_1/provider/DarkThemeProvider.dart';
import 'package:flutter_application_1/provider/Viewed%20provider.dart';
import 'package:flutter_application_1/provider/cart%20provider.dart';
import 'package:flutter_application_1/provider/order%20provider.dart';
import 'package:flutter_application_1/provider/products_provider.dart';
import 'package:flutter_application_1/provider/wishlist%20provider.dart';
import 'package:flutter_application_1/screens/Orders/order%20screen.dart';
import 'package:flutter_application_1/screens/Wishlist/wishlist%20screen.dart';
import 'package:flutter_application_1/screens/auth/Register.dart';
import 'package:flutter_application_1/screens/auth/forget%20password.dart';
import 'package:flutter_application_1/screens/auth/login.dart';
import 'package:flutter_application_1/screens/onboarding.dart';
import 'package:provider/provider.dart';


import 'Inner Screens/Onsale.dart';
void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  await SystemChrome.setPreferredOrientations([
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
  ]);
  runApp(My_APP());
}
class My_APP extends StatefulWidget {
   My_APP({Key? key}) : super(key: key);

  @override
  State<My_APP> createState() => _My_APPState();
}

class _My_APPState extends State<My_APP> {
  DarkThemeProvider themechangeprovider=DarkThemeProvider();

void getCurrentAppTheme()async
{
themechangeprovider.setDarkTheme=
await themechangeprovider.darkThemePrefs.getTheme();
}
@override
  void initState() {
  getCurrentAppTheme();
  super.initState();
  }
final Future<FirebaseApp> firebaseinitilization=Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebaseinitilization,
      builder: (context,snapshot)
      {
        if(snapshot.connectionState==ConnectionState.waiting)
          {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          }else if(snapshot.hasError)
            {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  body: Center(child:Text('An Error occured'),
                  ),
                ),
              );
            }

            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) {
                  return themechangeprovider;
                }),
                ChangeNotifierProvider(
                  create: (_) => ProductsProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => CartProvider(),
                ),
                ChangeNotifierProvider(
                  create:(_) =>WishlistProvider(),
                ),
                ChangeNotifierProvider(
                  create:(_) =>ViewedProvider(),
                ),
                ChangeNotifierProvider(
                  create:(_) =>OrdersProvider(),
                ),
              ],
              child: Consumer<DarkThemeProvider>(
                  builder: (context,themeprovider,child) {
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: Styles.themeData(themeprovider.getDarkTheme,context),
                      home:Onboarding(),
                      routes: {
                        OnsaleScreen.routename:(ctx)=>const OnsaleScreen(),
                        FeedsScreen.routeName: (ctx) => const FeedsScreen(),
                        Product_Details.routename:(ctx)=>const Product_Details(),
                        Wishlistscreen.routename:(ctx)=>const Wishlistscreen(),
                        RegisterScreen.routeName:(ctx)=>const RegisterScreen(),
                        ForgetPasswordScreen.routeName:(ctx)=>const ForgetPasswordScreen(),
                        LoginScreen.routeName:(ctx)=>const LoginScreen(),
                        CategoryScreen.routeName:(ctx)=>const CategoryScreen(),
                        OrdersScreen.routeName: (ctx) => const OrdersScreen(),

                      },
                    );
                  }
              ),
            );

      },

    );
  }
}
