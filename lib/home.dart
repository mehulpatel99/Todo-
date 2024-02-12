
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/Database/model.dart';
import 'package:todo/Database/service.dart';
import 'package:todo/edit_screen.dart';


class menu extends StatefulWidget {
  const menu({super.key});

  @override
  State<menu> createState() => _menuState();
}
TextEditingController noteCon = TextEditingController();

class _menuState extends State<menu> {

  late List<Models> _userList = <Models>[];
  List _filteredUserList = [];
  var _userServices = UserService();

  String? keyword = "";

// Dataget from model-----------------------------------
  void getdata() async{
    var userdata= await _userServices.readData();

    userdata.forEach((rowdata){
        var _models =Models();
        _models.id=rowdata['id'];
        _models.Note = rowdata['Note'];

        setState(() {          
              _userList.add(_models);
        });
    });
    print("=====>>>> userList $_userList");
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("------->>> CALLING FIRST STATE");

    getdata();

    print("=====>>>>Outside userList $_userList");    
  }

 
// Textfield search method--------------------------------
void mysearch(String? keydata) {

  setState(() {
    keyword = keydata;
  });
    setState(() {
      if (keyword!.isEmpty) {
        
        print(_userList);
        _filteredUserList = List.from(_userList);
      } else {
        _filteredUserList = _userList
            .where((user) =>
                user.Note!.toLowerCase().contains(keyword!.toLowerCase()))
            .toList();
            print(_filteredUserList);
      }
    });
  }



// void mysearch(String keydata)async{
//   if(keydata.isEmpty){
//     _filteredUserList = List.from(_userList);
//   }else{
//     _filteredUserList = _userList.where((element) => element.Note!.toLowerCase().contains(keydata!.toLowerCase())).toList();
//   }
// }

  //switch mehtod----------------------------------------
   bool switchvalue = false;
  void changeswitch(bool value) {
    if (switchvalue == true) {
      setState(() {
        switchvalue = false;
      Get.changeTheme(ThemeData.dark());
      });
    } else {
      setState(() {
        switchvalue = true;
        Get.changeTheme(ThemeData.light());
       
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    // final todosList = ToDo.todolist();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading:  Switch(value: switchvalue, onChanged: changeswitch),
        
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.person,
              color: Colors.black,
              size: 30,
            ),
            // SizedBox(width: 350,),
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVA_HrQLjkHiJ2Ag5RGuwbFeDKRLfldnDasw&usqp=CAU'),
            )
          ],
        ),

      ),

      drawer: Drawer(child: ListView(children: [SizedBox(height: 100,),AboutListTile(
        applicationName: 'Todo',
        applicationVersion: '12.4',
        applicationIcon: Icon(Icons.note),
        child: Text('About Todo',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),

      ),
      SizedBox(height: 20,),
      Lottie.network('https://lottie.host/f61611c8-5cf4-40bf-86de-cddab06a4c47/psgFHhb8yu.json'),
      ],)),
      body: Stack(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              searchbox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'All ToDos',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
         Padding(
           padding: const EdgeInsets.only(top: 140,bottom: 80),
           child: ListView.builder(
            itemCount: keyword!.length==0 ?  _userList.length  : _filteredUserList.length,
           itemBuilder: (context,index){
             return Padding(
               padding: const EdgeInsets.only(top: 10),
               child: Container(
                 // margin: EdgeInsets.only(bottom: 20),
                 child: ListTile(
                     tileColor: Colors.white,
                     onTap: () {
               
                       // ontodochange(todo);
               
                     },
                     contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                     shape:
                     RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                     // leading: IconButton(onPressed: (){},icon: Icon(Icons.add),),
                     leading:  Text('${_userList[index].id}'),
               
                     title: keyword!.length == 0 ?
                     Text(
                       '${_userList[index].Note}',
                       style: TextStyle(
                         fontSize: 16,
                         color: Colors.black,

                       ),
                     )
                     :
                      Text(
                       '${_filteredUserList[index].Note}',
                       style: TextStyle(
                         fontSize: 16,
                         color: Colors.black,

                       ),
                     ),



                     // subtitle: Text('mehul'),
                     trailing: Wrap(
                       children:[
                         Container(
                           height: 35,
                           width: 35,
                           padding: EdgeInsets.all(0),
                           margin: EdgeInsets.symmetric(vertical: 4),
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(5), color: Colors.green),
               
                           child:  IconButton(onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>MyEdit(models:_userList[index])));
                         }, icon: Icon(Icons.edit)),),
               
                          SizedBox(width: 10,),
                         Container(
                           height: 35,
                           width: 35,
                           padding: EdgeInsets.all(0),
                           margin: EdgeInsets.symmetric(vertical: 4),
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(5), color: Colors.red),
                           child: IconButton(
                             onPressed: () {
                               setState(() {
                                 var _models=Models();
                                 var _service=UserService();
                                 setState(() {
                                   _models.id = _userList[index].id;
                                 });
                                 var result= _service.deleteData(_models);
                               });
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>menu()));
                             },
                             icon: Icon(
                               Icons.delete,
                               color: Colors.white,
                             ),
                             iconSize: 18,
                           )),]
                     )),
               ),
             );
           }
                   ),
         ),
     
      
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0)
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: noteCon,
                    decoration: InputDecoration(
                        hintText: 'Add new todo item',
                        border: InputBorder.none)),
              )),
              Container(
                margin: EdgeInsets.only(bottom: 20, right: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(60, 60), elevation: 10),
                    onPressed: () {

                      setState(() {
                        var _models = Models();
                        var _service = UserService();
                        _models.Note=noteCon.text;
                        var result = _service.savedata(_models);
                        print('succesfully sent');
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>menu()));
                      setState(() {
                        noteCon.clear();
                      });
                    },
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 40),
                    )),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 625),
          child: Lottie.network('https://lottie.host/b410efa5-f74d-4b6f-87d0-c3f02503f413/DpzbTpMA6k.json',height: 130,width: 60),
        ),
      ]),
    
     
    );
  }

Widget searchbox() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15),
    child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          // width: 300,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: TextField(
            onChanged: (value) {
              mysearch(value);
            },
              decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 20,
                  ))),
        ),
      ],
    ),
  );

  
}
}