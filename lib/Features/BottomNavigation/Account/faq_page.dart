import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/Account/FaqsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class FAQPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => FaqsProvider(), child: FAQScreen());
  }
}

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class FAQ {
  String? question;
  String answer;

  FAQ(this.question, this.answer);
}

class _FAQScreenState extends State<FAQScreen> {
  int showAnswer=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FaqsProvider>(context, listen: false).faqsServices();
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final faqsProvider= Provider.of<FaqsProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.faqs!),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body:faqsProvider.FaqsList.length==0?Center(child: CircularProgressIndicator(),): FadedSlideAnimation(
        ListView.builder(
            itemCount: faqsProvider.FaqsList.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showAnswer = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: Text(
                        (index + 1).toString() +
                            '. ' +
                            faqsProvider.FaqsList[index].question,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 18),
                      ),
                    ),
                  ),
               showAnswer==index? AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.only(left: 34, right: 34, top: 4),
                    child: Text(faqsProvider.FaqsList[index].answer),
                  ):SizedBox(),
                  Divider(
                    thickness: 4,
                    color: Theme.of(context).backgroundColor,
                  ),
                ],
              );
            }),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
