import 'package:flutter/material.dart';

class ProjectTile extends StatefulWidget {
  final String name;
  final String category;
  final String primaryLanguage;
  final String imageUrl;

  const ProjectTile({
    Key? key,
    required this.name,
    required this.category,
    required this.primaryLanguage,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _ProjectTileState createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias, // Add this to make sure images are clipped to the card shape
      elevation: 4, // Adjust for desired shadow depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners for the card
      ),
      child: InkWell(
        onHover: (value) {
          setState(() {
            isHover = value;
          });
        },
        onTap: () {
          // Handle tile tap if necessary
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()..scale(isHover ? 1.03 : 1.0), // Slight scale up on hover
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Ensure contents fill the card width
            children: [
              Expanded( // Make sure image takes all available space, keeping the text at the bottom
                flex: 3,
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Padding( // Add padding for the text content inside the card
                padding: const EdgeInsets.all(8.0),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: isHover
                      ? TextButton(
                          onPressed: () {
                            // Handle "Show More" tap
                          },
                          child: const Column(children: [
                            Text('Show Details', style: TextStyle(color: Colors.black87)),
                            Padding(padding: EdgeInsets.only(bottom: 10))
                          ])
                        )
                      : Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Ensures text aligns to the start
                            children: [
                              Text(widget.name, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                              Text(widget.category, style: const TextStyle(color: Colors.grey)),
                              Text(widget.primaryLanguage, style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
