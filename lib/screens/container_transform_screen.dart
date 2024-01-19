import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class ContainerTransformScreen extends StatefulWidget {
  const ContainerTransformScreen({super.key});

  @override
  State<ContainerTransformScreen> createState() =>
      _ContainerTransformScreenState();
}

class _ContainerTransformScreenState extends State<ContainerTransformScreen> {
  bool _isGrid = false;

  void _toggleGrid() {
    setState(() {
      _isGrid = !_isGrid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Container Transform'),
        actions: [
          IconButton(
            icon: Icon(Icons.grid_4x4),
            onPressed: _toggleGrid,
          )
        ],
      ),
      body: _isGrid
          ? GridView.builder(
              itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1 / 1.5,
              ),
              itemBuilder: (context, index) => OpenContainer(
                closedBuilder: (context, action) {
                  return Column(
                    children: [
                      Image.asset("assets/covers/${(index % 5) + 1}.jpeg"),
                      Text('Cosmos soundtrack'),
                      Text(
                        'Alan Silvestri',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      )
                    ],
                  );
                },
                openBuilder: (BuildContext context,
                    void Function({Object? returnValue}) action) {
                  return DetailScreen(
                    image: index % 5 + 1,
                  );
                },
              ),
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                return OpenContainer(
                  closedElevation: 0,
                  openElevation: 0,
                  transitionDuration: Duration(
                    milliseconds: 500,
                  ),
                  closedBuilder: (
                    BuildContext context,
                    void Function() action,
                  ) {
                    return ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/covers/${index % 5 + 1}.jpeg"),
                          ),
                        ),
                      ),
                      title: Text('Cosmos soundtrack'),
                      subtitle: Text('Alan Silvestri'),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                      ),
                    );
                  },
                  openBuilder: (BuildContext context,
                      void Function({Object? returnValue}) action) {
                    return DetailScreen(
                      image: index % 5 + 1,
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 20,
                );
              },
              itemCount: 20,
            ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final int image;

  const DetailScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cosmos soundtrack'),
      ),
      body: Column(
        children: [
          Image.asset("assets/covers/${image}.jpeg"),
        ],
      ),
    );
  }
}
