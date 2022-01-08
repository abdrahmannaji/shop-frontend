import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobailshop/UI/chat/chatscreen.dart';
import 'package:mobailshop/mainaccont.dart';

import 'package:mobailshop/provider/database.dart';
import 'package:mobailshop/provider/get_shop_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSearching = false;
  late String myName, myProfilePic, myEmail;
  Stream<QuerySnapshot>? chatRoomsStream;
  Stream<QuerySnapshot>? usersStream;
  TextEditingController searchUsernameEditingController =
      TextEditingController();

  // getMyInfoFromSharedPreference() async {
  //   // myName = await SharedPreferenceHelper().getDisplayName();
  //   // myProfilePic = await SharedPreferenceHelper().getUserProfileUrl();
  //   // myUserName = await SharedPreferenceHelper().getUserName();
  //   // myEmail = await SharedPreferenceHelper().getUserEmail();
  //   setState(() {});
  // }

  getChatRoomIdByUsernames(String a, String b) {
    print(a);
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  onSearchBtnClick() async {
    setState(() {
      isSearching = true;
    });

    usersStream = await DatabaseMethods()
        .getUserByUserName(searchUsernameEditingController.text);

    setState(() {});
  }

  Widget chatRoomsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatRoomsStream,
      builder: (context, snapshot) {
        // print("ww${snapshot.hasData}");

        if (snapshot.data == null) return CircularProgressIndicator();
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  print(snapshot.data?.docs.length);
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return ChatRoomListTile(ds["lastMessage"], ds.id, shopname);
                })
            : Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.amber,
                ),
              );
      },
    );
  }

  Widget searchListUserTile(
      {required String profileUrl, name, username, email}) {
    return GestureDetector(
      onTap: () {
        print(shopname);
        print(username);
        var chatRoomId = getChatRoomIdByUsernames(shopname, username);
        print(shopname);
        Map<String, dynamic> chatRoomInfoMap = {
          "users": [shopname, username]
        };
        DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(username, name)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(
                "http://172.16.0.6:3001/uploads/avatars/$profileUrl",
                height: 40,
                width: 40,
              ),
            ),
            SizedBox(width: 12),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(username), Text(name)])
          ],
        ),
      ),
    );
  }

  Widget searchUsersList() {
    return StreamBuilder<QuerySnapshot>(
      stream: usersStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data?.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return searchListUserTile(
                      profileUrl: ds["logo"],
                      name: ds["address"],
                      username: ds["nameShop"]);
                },
              )
            : Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.limeAccent,
                ),
              );
      },
    );
  }

  getChatRooms() async {
    DatabaseMethods().getChatRooms(shopname).then((snapshots) {
      setState(() {
        chatRoomsStream = snapshots;
        print("we got the data + ${chatRoomsStream.toString()} this is name  ");
      });
    });
  }

  // getChatRooms() async {
  //   chatRoomsStream = await DatabaseMethods().getChatRooms();
  //   setState(() {});
  // }

  // onScreenLoaded() async {
  //   // await getMyInfoFromSharedPreference();

  // }

  @override
  void initState() {
    getChatRooms().whenComplete(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                isSearching
                    ? GestureDetector(
                        onTap: () {
                          isSearching = false;
                          searchUsernameEditingController.text = "";
                          setState(() {});
                        },
                        child: Padding(
                            padding: EdgeInsets.only(right: 12),
                            child: Icon(Icons.arrow_back)),
                      )
                    : Container(),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: searchUsernameEditingController,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: "username"),
                        )),
                        GestureDetector(
                            onTap: () {
                              if (searchUsernameEditingController.text != "") {
                                onSearchBtnClick();
                              }
                            },
                            child: Icon(Icons.search))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            isSearching ? searchUsersList() : chatRoomsList()
          ],
        ),
      ),
    );
  }
}

class ChatRoomListTile extends StatefulWidget {
  final String lastMessage, chatRoomId, myUsername;
  ChatRoomListTile(this.lastMessage, this.chatRoomId, this.myUsername);

  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  String profilePicUrl = "", name = "", username = "";
  Stream? querySnapshot;
  getThisUserInfo() async {
    username =
        widget.chatRoomId.replaceAll(widget.myUsername, "").replaceAll("_", "");

    DatabaseMethods().getUserByUserName(username).then((snapshots) {
      setState(() {
        querySnapshot = snapshots;
        print("we got the data + ${snapshots.toString()} this is name  ");
      });
    });
  }

  @override
  void initState() {
    getThisUserInfo().whenComplete(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: querySnapshot,
        builder: (context, AsyncSnapshot snapshot) {
          print("ma${snapshot.hasData}");

          //  snapshot.data.docs[0]["imgUrl"]
          if (snapshot.data == null) return CircularProgressIndicator();
          return snapshot.hasData
              ?
              //  ListView.builder(
              //     itemCount: snapshot.data.docs.length,
              //     shrinkWrap: true,
              //     itemBuilder: (context, index) {
              //       print(snapshot.data.docs.length);
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                snapshot.data.docs[0]["nameShop"],
                                snapshot.data.docs[0]["address"])));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            "http://172.16.0.6:3001/uploads/avatars/${snapshot.data.docs[0]["logo"]}",
                            height: 40,
                            width: 40,
                          ),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${snapshot.data.docs[0]["nameShop"]}",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 3),
                            Container(
                              width: 300,
                              child: Text(
                                widget.lastMessage,
                                // maxLines: 1,
                                textWidthBasis: TextWidthBasis.longestLine,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              // })
              : Center(
                  child:
                      CircularProgressIndicator(backgroundColor: Colors.black),
                );
        });
  }
}
