import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:namesa_yassin_preoject/models/service_model.dart'; // Import your ServiceModel
import 'package:provider/provider.dart';

import '../../widgets/servicesDisplayForAdmin.dart'; // This should display ServiceModel

class AdminService extends StatefulWidget {
  static const String routeName = "AdminService";

  const AdminService({super.key});

  @override
  State<AdminService> createState() => _AdminServiceState();
}

class _AdminServiceState extends State<AdminService> {
  List<ServiceModel> _allServices = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAllServices();
  }

  Future<void> loadAllServices() async {
    final provider = Provider.of<HotelRooms>(context, listen: false);
    final services = await provider
        .loadAllUserServices(); // This must be defined in your provider
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
          "Reserved Rooms",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.white, height: 2),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _allServices.isEmpty
              ? const Center(child: Text("No services requested."))
              : ListView.builder(
                  itemCount: _allServices.length,
                  itemBuilder: (context, index) {
                    return DisplayServiceForAdmin(
                      serviceModel: _allServices[index], onApprove: () {
                        setState(() {

                        });
                        _allServices.removeAt(index);  },
                    );
                  },
                ),
    );
  }
}
