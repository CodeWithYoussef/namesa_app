import 'package:flutter/material.dart';
import 'package:namesa_yassin_preoject/models/hotel_rooms.dart';
import 'package:namesa_yassin_preoject/models/service_model.dart';
import 'package:provider/provider.dart';

class DisplayServiceForAdmin extends StatefulWidget {
  final ServiceModel serviceModel;
  final VoidCallback onApprove;

  DisplayServiceForAdmin({
    super.key,
    required this.serviceModel,
    required this.onApprove,
  });

  @override
  State<DisplayServiceForAdmin> createState() => _DisplayServiceForAdminState();
}

class _DisplayServiceForAdminState extends State<DisplayServiceForAdmin> {

  @override
  Widget build(BuildContext context) {
    print(widget.serviceModel.roomPrice);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Card(
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                      child: Text(
                    'The user id = ${widget.serviceModel.uid}',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ))),
              Text("The needs that user needs is:"),
              Text(
                  'Laundry: ${widget.serviceModel.laundry == true ? 'yes' : 'no'}'),
              Text(
                  'Room service: ${widget.serviceModel.roomService == true ? 'yes' : 'no'}'),
              Text(
                  'Total price: ${widget.serviceModel.roomPrice + widget.serviceModel.extraPrice}'),
              Row(
                children: [
                  MaterialButton(
                    onPressed: () async {
                      // Update isDone in Firestore (optional)
                      await Provider.of<HotelRooms>(context, listen: false)
                          .markServiceAsDone(widget.serviceModel.uid);

                      // Trigger removal from screen
                      widget.onApprove();
                    },
                    color: Colors.green,
                    child: const Text('Approve'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
