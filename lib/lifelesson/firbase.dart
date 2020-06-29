import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oneroof/data/post.dart';

import 'fetchdata.dart';
import 'signinform/Loginpage.dart';
import 'package:path/path.dart' as Path;

class home extends StatefulWidget {
  home() : super();

  final String title = "LifeLesson";
  @override
  homeState createState() => homeState();
}

class homeState extends State<home> {
  File _imageFile;
  String _uploadimageurl;
  bool isLoading = false;

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  validateFormAndSave() {
    print("Validating Form...");
    if (_key.currentState.validate()) {
      print("Validation Successful");
      _key.currentState.save();
      print('Name ');
      print('Age ');
    } else {
      print("Validation Error");
    }
  }

  void initState() {
    _gtuid();

    super.initState();
  }


  //
  bool showTextField = false;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  String collectionName = "Profile";
  bool isEditing = false;
  Post curUser;
String fetched_uid;

  homeState();
  Future<void> _gtuid() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    uidn = user.uid;

  }

  getUsers() {
    return Firestore.instance.collection(collectionName).snapshots();
  }
  String uidn;

  addUser() {
    Post user = Post(name: controller1.text,
       imageurl:_uploadimageurl,
      description: controller5.text,
      id:uidn
     );
    try {
      Firestore.instance.runTransaction(
            (Transaction transaction) async {
          await Firestore.instance
              .collection(collectionName)
              .document()
              .setData(user.toJson());
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  add() {

    if (isEditing) {
      // Update
      update(curUser, controller1.text,_uploadimageurl,controller5.text);
      setState(() {
        isEditing = false;
      });
    } else {
      addUser();
    }
    controller1.text = '';
    _imageFile=null;
    controller5.text='';
  }

  update(Post user,String newname,String newimage, String newdescription) {
    try {
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(user.reference, {'name':newname ,'imageurl':newimage,
       'lifelesson':newdescription});
      });
    } catch (e) {
      print(e.toString());
    }
  }

  delete(Post user) {
    print(user.id);
if( uidn == user.id) {
  Firestore.instance.runTransaction(
        (Transaction transaction) async {
      await transaction.delete(user.reference);
    },
  );
}
else{
  print('not a relevant user');
  return Dialog(
    child: Text('Not authorized user'),
  );
}
  }

  Widget buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.hasData) {
          print("Documents ${snapshot.data.documents.length}");
          return buildList(context, snapshot.data.documents);
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => buildListItem(context, data)).toList(),
    );
  }

  Widget buildListItem(BuildContext context, DocumentSnapshot data) {
//    final   user = User.fromSnapshot(data);
final user=Post.fromSnapshot(data);

    return Column(
      children: <Widget>[
        Padding(
          key: ValueKey(user.name),
          padding: EdgeInsets.all( 8.0),
          child: Container(
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap:(){
                  },
                  onDoubleTap:(){
                    setUpdateUI(user);
                  } ,
                  onLongPress: (){  delete(user);},
                  child: UserData(

                    Name: user.name,
                    description: user.description,
                    Image: user.imageurl,
                    id: user.id,

                  ),
                ),
                uidn == user.id?Container(
                  height: 50,
                  width: double.infinity,
                  child: ListTile(

                    leading: Icon(Icons.edit),
                    title: Text('Edit                                         Delete'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // delete
                        delete(user);
                      },
                    ),
                    onTap: () {
                      // update
                      setUpdateUI(user);
                    },
                  ),
                ):Container()
              ],
            ),
          ),
        ),
      ],
    );
  }

  setUpdateUI(Post user) {
    if (uidn == user.id) {
      controller1.text = user.name;
      setState(() {
        showTextField = true;
        isEditing = true;
        curUser = user;
      });
    }
    else{
      print('not authorized');
    }
  }

  button() {
    return Container(
      padding: const EdgeInsets.only(top: 50.0),
      width: double.infinity,
      alignment: Alignment.center,
      child: RaisedButton(
        onPressed: () {
          uploadFile();
          setState(() {
            showTextField = false;
          });
        },
        color: Color(0xFF2B65F9),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 8.0, vertical: 12.0),
          child: Text(
            'Add Lesson',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
teamdata()=>ListView(children:<Widget>[

  Stack(children: <Widget>[
//    Padding(
//    padding: const EdgeInsets.fromLTRB(0,90,0,0),
//    child: Image.network("https://cdn.dribbble.com/users/1068771/screenshots/8714646/media/ef9757747e1c7f4058cf70f8e259b37e.jpg"),
//  ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          'Give Your Life lesson to world ',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  Padding(
    padding: const EdgeInsets.fromLTRB(20.0,70,20,20),
    child: Container(
      width: double.infinity,
      //  height: ScreenUtil.getInstance().setHeight(520),
      decoration: BoxDecoration(
          color: Color.fromRGBO(255,250,250, 100),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _key,
          autovalidate: _validate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 15,
                  controller: controller1,
                  decoration: InputDecoration(
                    labelText: "Name", hintText: "Enter name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)
                  ),),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 120,
                  controller: controller5,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: "Life Lesson", hintText: "Less than 120 words",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),),
                ),
              ),
              _buildImage(),
              button_cap(),
              SizedBox(
                height: 10,
              ),
              button(),
            ],
          ),
        ),
      ),
    ),
  )],),



]);

    return Scaffold(
      // backgroundColor: Color(0xFFF9EFEB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Life Lessons By World",style: TextStyle(color: Colors.grey),),
        centerTitle: true,

        leading: IconButton(
            color: Colors.grey,
            icon: Icon(Icons.exit_to_app), onPressed: (){
          _signOut(context);
        }),
        actions: <Widget>[
          IconButton(
            splashColor: Colors.grey,
            icon: Icon(Icons.add_circle_outline,color: Colors.grey,),
            onPressed: () {
              setState(() {
                showTextField = !showTextField;
              });
            },
          ),
        ],
      ),
      body:
          PageView(
            children: <Widget>[
              //buildBody(context),
              showTextField?
              teamdata():  buildBody(context),

            ],
          )

    );
  }

  Widget _buildImage() {
    if (_imageFile != null) {
      return Image.file(_imageFile);
    } else {
      return Text('Choose an image to share your life lesson', style: TextStyle(fontSize: 18.0));
    }
  }

  button_cap() {
    return Container(
      padding: const EdgeInsets.only(top: 50.0),
      width: double.infinity,
      alignment: Alignment.center,
      child: RaisedButton(
        onPressed: () {
          captureImage(ImageSource.gallery);
        },
        color: Color(0xFF2B65F9),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 8.0, vertical: 12.0),
          child: Text(
            'Choose Image',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }



  Widget _buildActionButton({Key key, String text, Function onPressed}) {
    return Expanded(
      child: FlatButton(
          key: key,
          child: Text(text, style: TextStyle(fontSize: 20.0)),
          shape: RoundedRectangleBorder(),
          color: Colors.blueAccent,
          textColor: Colors.white,
          onPressed: onPressed),
    );
  }
  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final imageFile = await ImagePicker.pickImage(source: imageSource);
      setState(() {
        _imageFile = imageFile;
      });
    } catch (e) {
      print(e);
    }
  }
  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp1()),
      );
    } catch (e) {
      print(e);
    }
  }


  Future uploadFile() async {
    setState(() {
       isLoading = true;
    });
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(_imageFile.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_imageFile);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadimageurl = fileURL;
        isLoading = false;
        add();
      });
    });
  }



}