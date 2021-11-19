import 'package:dentistry_app/resources/colors_res.dart';
import 'package:dentistry_app/resources/images_res.dart';
import 'package:dentistry_app/screens/splashScreen/splash_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenViewModel viewModel = SplashScreenViewModel();
  
  @override
  void initState() {
    viewModel.initState(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<SplashScreenViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: ColorsRes.fromHex(ColorsRes.whiteColor),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 120.0,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      ImageRes.mainLogo,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const CircularProgressIndicator()
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
