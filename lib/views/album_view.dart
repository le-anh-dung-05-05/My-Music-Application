import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spotify_application/widgets/album_card.dart';

class AlbumView extends StatefulWidget {
  final ImageProvider image;

  const AlbumView({required Key key, required this.image}) : super(key: key);
  @override
  _AlbumViewState createState() => _AlbumViewState();
}

bool _isTap = false;
bool _isPressed = false;

enum SelectItems { itemOne, itemTwo, itemThree }

class _AlbumViewState extends State<AlbumView> {
  late ScrollController scrollController;
  double imageSize = 0;
  double initialSize = 240;
  double containerHeight = 500;
  double containerinitalHeight = 500;
  double imageOpacity = 1;
  bool showTopBar = false;

  @override
  void initState() {
    imageSize = initialSize;
    scrollController = ScrollController()
      ..addListener(() {
        imageSize = initialSize - scrollController.offset;
        if (imageSize < 0) {
          imageSize = 0;
        }
        containerHeight = containerinitalHeight - scrollController.offset;
        if (containerHeight < 0) {
          containerHeight = 0;
        }
        imageOpacity = imageSize / initialSize;
        if (scrollController.offset > 224) {
          showTopBar = true;
        } else {
          showTopBar = false;
        }
        // print(scrollController.offset);
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SelectItems selectItems;
    final cardSize = MediaQuery.of(context).size.width / 2 - 32;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: containerHeight,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              color: Colors.pink,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: imageOpacity.clamp(0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.5),
                            offset: Offset(0, 20),
                            blurRadius: 32,
                            spreadRadius: 16,
                          )
                        ],
                      ),
                      child: Image(
                        image: widget.image,
                        width: imageSize,
                        height: imageSize,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                controller: scrollController,
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0),
                            Colors.black.withOpacity(0),
                            Colors.black.withOpacity(1),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Column(
                          children: [
                            SizedBox(height: initialSize + 32),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Image(
                                        image: AssetImage('assets/logo.png'),
                                        width: 32,
                                        height: 32,
                                      ),
                                      SizedBox(width: 8),
                                      Text("Spotify")
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "1,888,132 likes 5h 3m",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  SizedBox(height: 16),
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                setState(
                                                    () => _isTap = !_isTap);
                                              },
                                              child: Icon(Icons.favorite_sharp,
                                                  // color: Colors.redAccent,
                                                  color: (_isTap)
                                                      ? Colors.red
                                                      : Colors.white)),
                                          // PopupMenuButton<SelectItems>(
                                          //   initialValue: selectItems,
                                          //   onSelected: (SelectItems item){
                                          //     setState(() {
                                          //       selectItems=item;
                                          //     });
                                          //   },
                                          //   itemBuilder: (BuildContext context) => <PopupMenuEntry<SelectItems>>[
                                          //       const PopupMenuItem<SelectItems>(
                                          //         value: SelectItems.itemOne,
                                          //         child: Text('Item 1'),
                                          //       ),
                                          //       const PopupMenuItem<SelectItems>(
                                          //         value: SelectItems.itemTwo,
                                          //         child: Text('Item 2'),
                                          //       ),
                                          //       const PopupMenuItem<SelectItems>(
                                          //         value: SelectItems.itemThree,
                                          //         child: Text('Item 3'),
                                          //       ),
                                          //   ],
                                          // )
                                          MenuAnchor(
                                            builder: (BuildContext context,
                                                MenuController controller,
                                                Widget? child) {
                                              return IconButton(
                                                onPressed: () {
                                                  if (controller.isOpen) {
                                                    controller.close();
                                                  } else {
                                                    controller.open();
                                                  }
                                                },
                                                icon: const Icon(
                                                    Icons.more_horiz),
                                              );
                                            },
                                            menuChildren:
                                                List<MenuItemButton>.generate(
                                              3,
                                              (int index) => MenuItemButton(
                                                onPressed: () => setState(() =>
                                                    selectItems = SelectItems
                                                        .values[index]),
                                                child:
                                                    Text('Item ${index + 1}'),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      color: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"),
                          SizedBox(height: 32),
                          Text(
                            "You might also like",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AlbumCard(
                                  size: cardSize,
                                  label: "Get Turnt",
                                  image: AssetImage("assets/album3.jpg"),
                                  onTap: null,
                                ),
                                AlbumCard(
                                  size: cardSize,
                                  label: "Get Turnt",
                                  image: AssetImage("assets/album5.jpg"),
                                  onTap: null,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AlbumCard(
                                  size: cardSize,
                                  label: "Get Turnt",
                                  image: AssetImage("assets/album6.jpg"),
                                  onTap: null,
                                ),
                                AlbumCard(
                                  size: cardSize,
                                  label: "Get Turnt",
                                  image: AssetImage("assets/album9.jpg"),
                                  onTap: null,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AlbumCard(
                                  size: cardSize,
                                  label: "Get Turnt",
                                  image: AssetImage("assets/album10.jpg"),
                                  onTap: null,
                                ),
                                AlbumCard(
                                  size: cardSize,
                                  label: "Get Turnt",
                                  image: AssetImage("assets/album4.jpg"),
                                  onTap: null,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // App bar
            Positioned(
                child: Container(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 10),
                color: showTopBar
                    ? Color(0xFFC61855).withOpacity(1)
                    : Color(0xFFC61855).withOpacity(0),
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: SafeArea(
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              size: 38,
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 250),
                          opacity: showTopBar ? 1 : 0,
                          child: Text(
                            "Ophelia",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 80 -
                              containerHeight.clamp(120.0, double.infinity),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() => _isPressed = !_isPressed);
                                  },
                                  alignment: Alignment.center,
                                  icon: (_isPressed == true) ? Icon(
                                    Icons.play_arrow,
                                    size: 40,
                                    color: Color.fromARGB(255, 242, 244, 243),
                                  ) : Icon(
                                    Icons.pause,
                                    size: 40,
                                    color: Color.fromARGB(255, 242, 244, 243),
                                ),
                              ),
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  Icons.shuffle,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
