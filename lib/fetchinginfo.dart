import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class sheetbottom extends StatefulWidget {
  @override
  _sheetbottomState createState() => _sheetbottomState();
}

class _sheetbottomState extends State<sheetbottom> {
  String photourl;

  Future<dynamic> fetchData()async{
    final response=await http.get(Uri.parse('https://fakeface.rest/face/json'));
    try{
      if(response.statusCode==200){
        var value=convert.jsonDecode(response.body);
        photourl= value['image_url'];
        return photourl;
      }
    }catch(e){
      print(e);
    }

  }

  @override
  void initState()  {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: FloatingActionButton(
          child: Icon(Icons.contact_page_outlined),
          onPressed: () async{


            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                ),
                context: context,
                builder: (builder) {
                  return Container(
                    height: 250.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Search Contact',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 20),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(

                              cursorColor: Colors.purple,
                              autocorrect: true,
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.book_sharp,color: Colors.purple,),
                                hintText: 'Select Number',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.purple),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.purple),
                                ),
                              ),
                            ),
                          ),
                          Row(

                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: CircleAvatar (
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(photourl),
                                ),
                              ),
                              SizedBox(width: 20,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sumanth Verma',
                                    style: TextStyle(
                                      fontSize:20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    '1234567890',
                                    textAlign: TextAlign.start,
                                  )
                                ],
                              ),


                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}