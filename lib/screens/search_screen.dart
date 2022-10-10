
import 'package:flutter/material.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String cityName='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/loading.jpeg'), fit: BoxFit.fill)),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  onChanged: (input){
                    cityName=input;
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'Type City name here...',
                    hintStyle: TextStyle(
                      color: Colors.grey
                    )
                  ) ,
                  textAlign: TextAlign.center,

                ),
              ),
              TextButton(
                  onPressed: (){
                    Navigator.pop(context,cityName);

                  },
                  child: const Text(
                    'Get Weather'
                  )
              )
            ],
          )
      ),
    );
  }
}
