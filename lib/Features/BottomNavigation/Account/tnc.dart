import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/Account/TermsCondionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class TnCPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => TermsCondionProvider(), child: TnCScreen());
  }
}
class TnCScreen extends StatefulWidget {
  @override
  _TnCPageState createState() => _TnCPageState();
}

class _TnCPageState extends State<TnCScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TermsCondionProvider>(context, listen: false).termsCondionServices();
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var termsProvider= Provider.of<TermsCondionProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.termsAndCond!),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body:termsProvider.termsCondionInfo["data"]==""?Center(child: CircularProgressIndicator(),): FadedSlideAnimation(
        ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 18),
              child: Text(
                termsProvider.termsCondionInfo["data"][0]["body"],
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w400, fontSize: 20),
              ),
            )
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
