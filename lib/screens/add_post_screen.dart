import 'package:flutter/material.dart';
import 'package:pmsna1/database/database_helper.dart';
import 'package:pmsna1/models/post_model.dart';
import 'package:pmsna1/provider/flags_provider.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});

  DatabaseHelper database = DatabaseHelper();
  PostModel? objPosmodel;

  @override
  Widget build(BuildContext context) {
    
    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    final txtConPost = TextEditingController();
    if( ModalRoute.of(context)!.settings.arguments != null ){
      objPosmodel = ModalRoute.of(context)!.settings.arguments as PostModel;
      txtConPost.text = objPosmodel!.dscPost!;
    }

    return Scaffold(
    body: Center(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        height: 350,
        decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(color: Colors.black)
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            objPosmodel == null 
              ? const Text('Add Post :)') 
              : const Text('Update Post :)'),
            TextFormField(
              controller: txtConPost, 
              maxLines: 8,
            ),
            ElevatedButton(
              onPressed: (){

                if( objPosmodel == null ){
                  database.INSERT('tblPost',{
                    'dscPost' : txtConPost.text,
                    'datePost' : DateTime.now().toString()
                  }).then((value){

                    var msg = value > 0 
                      ? 'Registro insertado' 
                      : 'Ocurrió un error';

                    var snackBar = SnackBar(
                      content: Text(msg)
                    );

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  });
                }else{
                  database.UPDATE('tblPost',{
                    'idPost' : objPosmodel!.idPost,
                    'dscPost' : txtConPost.text,
                    'datePost' : DateTime.now().toString()
                  }).then((value){

                    var msg = value > 0 
                      ? 'Registro actualizado' 
                      : 'Ocurrió un error';

                    var snackBar = SnackBar(
                      content: Text(msg)
                    );

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  });
                }
                flag.setflagListPost();
              }, 
              child: Text('Save Post')
            )
          ],
        ),
      ),
    ),
    );
  }
}