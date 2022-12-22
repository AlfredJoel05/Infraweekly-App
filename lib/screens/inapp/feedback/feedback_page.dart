import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trid_travel/Utils/exit_alert.dart';
import 'package:trid_travel/Utils/menu/side_menu.dart';
import 'package:trid_travel/constants/constants_values.dart';
import 'package:trid_travel/services/api_service.dart';
import 'package:trid_travel/utils/alert_dialog.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);
  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _feedbackController = TextEditingController();
  final apiService = ApiService();
  int? finalRating;
  bool _isLoading = false;
  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future submitFeedback(feedback, rating) async {
    // var data = jsonEncode(<String, String>{"comments": feedback, "rating": rating});
    var data = json.encode({"comments": feedback, "rating": rating});
    var response = await apiService.postFeedboack(data);
    var message = json.decode(response.body);
    if (!mounted) return;
    if (response.statusCode == 201) {
      setState(() {
        _isLoading = !_isLoading;
      });
      showAlertDialogBox(context, message['body'], true);
    } else {
      showAlertDialogBox(context, message['body'], false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const SideMenu(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          automaticallyImplyLeading: false,
          title: Text(
            "Feedback",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
          ),
          centerTitle: true,
          // ignore: prefer_const_literals_to_create_immutables
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.amber),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                  child: Text(
                    'Share your thoughts...',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                TextField(
                  controller: _feedbackController,
                  minLines: 5,
                  maxLines: null,
                  maxLength: 200,
                  keyboardType: TextInputType.multiline,
                  cursorColor: Colors.amber,
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)))),
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.w600),
                ),
                RatingBar.builder(
                  initialRating: 4,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    finalRating = rating.toInt();
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          _feedbackController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey),
                        child: const Text('Cancel',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: getIsLoggedIn()
                            ? () {
                                setState(() {
                                  _isLoading = !_isLoading;
                                });
                                submitFeedback(
                                    _feedbackController.text, finalRating);
                              }
                            : () => showAlertDialogBox(context,
                                'Login Required to submit Feedback', false),
                        child: _isLoading
                            ? const SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator.adaptive(
                                    backgroundColor: Colors.white))
                            : const Text('Submit',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
