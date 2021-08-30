import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/Doctor/DoctorProvider.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Specification extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
  return _state();
  }
}
class _state extends State<Specification>{
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var doctorProvider=    Provider.of<DoctorProvider>(context, listen: true);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*.05,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: TextFormField(
              onTap: () {
                Navigator.pushNamed(context, PageRoutes.searchDoctors);
              },
              readOnly: true,
              decoration: InputDecoration(
                  hintText: locale.searchDoctors,
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Theme.of(context).backgroundColor,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none)),
            ),
          ),
          SizedBox(height: 15,),
          Expanded(
            child: ListView.builder(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width*.05,
              right: MediaQuery.of(context).size.width*.05,
            ),
           itemCount: doctorProvider.doctorSpeiaList.length,itemBuilder: (context,index){
              return GestureDetector(
                onTap: ()async{
                  await doctorProvider.getDoctorBySpecialist(doctorProvider.doctorSpeiaList[index].id);
                  Navigator.pushNamed(context, PageRoutes.listOfDoctorsPage);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38,width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Row(
                    children: [
                      Image.network(doctorProvider.doctorSpeiaList[index].icon,
                      width: MediaQuery.of(context).size.width*.2,
                      height: MediaQuery.of(context).size.height*.07,
                      ),
                      SizedBox(width: 10,),
                      Text(doctorProvider.doctorSpeiaList[index].name,style: Theme.of(context).textTheme.subtitle1,)
                    ],
                  ),
                ),
              );
            }),
          )

        ],
      ),
    );
  }
}