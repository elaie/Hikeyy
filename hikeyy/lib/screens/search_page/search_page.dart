import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FirebaseAuth auth= FirebaseAuth.instance;
  String name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Card(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search'
            ),
            onChanged: (val){
              setState(() {
                name=val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context,snapshots){
          if(snapshots.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return ListView.builder(itemCount: snapshots.data!.docs.length,
              itemBuilder: (context,index){
            var data= snapshots.data!.docs[index].data() as Map<String,dynamic>;
            if(data['Email']==auth.currentUser!.email){
              return Container();
            }
            if(name==''){
              return ListTile(
                title: Text(data['UserName']),
                leading: CircleAvatar(backgroundImage: data['pfpUrl']!=' '?NetworkImage(data['pfpUrl']):AssetImage('assets/images/profile.png') as ImageProvider,),
              );
            }

              if(data['UserName'].toString().toLowerCase().startsWith(name.toString().toLowerCase())){
                return ListTile(
                  title: Text(data['UserName']),
                  leading: CircleAvatar(backgroundImage: data['pfpUrl']!=' '?NetworkImage(data['pfpUrl']):AssetImage('assets/images/profile.png') as ImageProvider,),
                );
              }
              return Container();
              }
          );
        },
      ),
    );
  }
}
