import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:namesa_yassin_preoject/models/service_model.dart';
import 'package:namesa_yassin_preoject/widgets/notification_item.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationsScreen extends StatefulWidget {
  static const String routeName = "notifications screen";

  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<ServiceModel> _allServices = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserServices();
  }

  Future<void> loadUserServices() async {
    final provider = Provider.of<HotelRooms>(context, listen: false);
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final services = await provider.loadUserServicesById(uid); // ✅ your existing function
    setState(() {
      _allServices = services;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          "Notification Screen",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.white, height: 2),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _allServices.isEmpty
          ? const Center(child: Text("No notifications found."))
          : ListView.builder(
        itemCount: _allServices.length,
        itemBuilder: (context, index) {
          return NotificationItem(
            serviceModel: _allServices[index],
            onApprove: () {
              setState(() {
                _allServices.removeAt(index);
              });
            },
          );
        },
      ),
    );
  }
}
