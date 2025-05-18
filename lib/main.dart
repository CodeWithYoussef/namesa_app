import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namesa_yassin_preoject/splash%20screen/spalsh_screen.dart';
import 'package:namesa_yassin_preoject/theme/base_theme.dart';
import 'package:namesa_yassin_preoject/theme/light_theme.dart';
import 'package:provider/provider.dart';

import 'admin/admin screens/admin_reserved_events.dart';
import 'admin/admin screens/admin_reserved_restaurants.dart';
import 'admin/admin screens/admin_reserved_rooms.dart';
import 'admin/admin screens/admin_screen.dart';
import 'auth screens/auth_screen.dart';
import 'firebase_options.dart';
import 'home screens/home_screen.dart';
import 'home screens/notification tab/notifications_screen.dart';
import 'home screens/reserve screens/reserve_room.dart';
import 'home screens/tabs/Reservations _tab.dart';
import 'home screens/tabs/home_tab.dart';
import 'home screens/tabs/favourites_tab.dart';
import 'home screens/tabs/profile_tab.dart';
import 'models/hotel_room_model.dart';
import 'models/hotel_rooms.dart'; // ✅ Import your HotelRooms model

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Activate App Check
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );

  // Lock to portrait mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HotelRooms()),
        // You can add more providers here if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    BaseTheme lightTheme = LightTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme.themeData,
      routes: {
        AdminScreen.routeName: (context) => const AdminScreen(),
        AdminReservedRestaurants.routeName:
            (context) => const AdminReservedRestaurants(),
        AdminReservedEvents.routeName: (context) => const AdminReservedEvents(),
        AdminReservedRooms.routeName: (context) => const AdminReservedRooms(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        AuthScreen.routeName: (context) => const AuthScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        HomeTab.routeName: (context) => HomeTab(),
        FavouritesTab.routeName: (context) => const FavouritesTab(),
        ReservationsTab.routeName: (context) => const ReservationsTab(),
        ProfileTab.routeName: (context) => const ProfileTab(),
        NotificationsScreen.routeName: (context) => const NotificationsScreen(),
        ReserveRoom.routeName:
            (context) => ReserveRoom(
              hotelRoom:
                  ModalRoute.of(context)!.settings.arguments as HotelRoom,
            ),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}
