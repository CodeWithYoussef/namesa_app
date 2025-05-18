import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:namesa_yassin_preoject/models/service_model.dart';
import 'package:provider/provider.dart';
class NotificationItem extends StatefulWidget {
  final ServiceModel serviceModel;
  final VoidCallback onApprove;
  const NotificationItem({super.key, required this.serviceModel,required this.onApprove});

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Text("The needs that user needs is:"),
          Text(
              'Laundry: ${widget.serviceModel.laundry == true ? 'yes' : 'no'}'),
          Text(
              'Room service: ${widget.serviceModel.roomService == true ? 'yes' : 'no'}'),
          Text(
              'Total price: ${widget.serviceModel.roomPrice! + widget.serviceModel.extraPrice}'),
          Row(
            children: [
              MaterialButton(
                onPressed: () async {
                  Provider.of<HotelRooms>(context,listen:false).deleteUserService(widget.serviceModel.uid);
                  widget.onApprove();
                },
                color: Colors.green,
                child: const Text('Verify'),
              ),
            ],
          )
        ],
      ),
    );

  }
}
