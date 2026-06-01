import 'package:HAPPYPETS/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:HAPPYPETS/screens/social meadia.dart';

class Social extends StatefulWidget {
  const Social({super.key});

  @override
  State<Social> createState() => _SocialState();
}

class _SocialState extends State<Social> {
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 1; // Add this line to define the selected index

  final List<Map<String, dynamic>> _allPosts = [
    {
      'name': 'Gabbar',
      'image': 'assets/dog1.jpg',
      'caption': 'Enjoying a sunny day at the park! 🐕',
      'time': '2 hours ago',
      'likes': 120,
      'comments': 45,
      'isLiked': false,
    },
    {
      'name': 'Gabbar',
      'image': 'assets/dog2.jpg',
      'caption': 'Enjoying at beach 🏖️',
      'time': '5 hours ago',
      'likes': 89,
      'comments': 32,
      'isLiked': false,
    },
    {
      'name': 'Gabbar',
      'image': 'assets/dog3.jpg',
      'caption': 'Training for running 🏃‍♂️',
      'time': '8 hours ago',
      'likes': 156,
      'comments': 67,
      'isLiked': false,
    },
    {
      'name': 'Gabbar',
      'image': 'assets/dog4.jpeg',
      'caption': 'Chilling in the snow ❄️',
      'time': '12 hours ago',
      'likes': 134,
      'comments': 52,
      'isLiked': false,
    },
    {
      'name': 'Gabbar',
      'image': 'assets/dog5.jpeg',
      'caption': 'Happy Birthday! 🎂',
      'time': '1 day ago',
      'likes': 178,
      'comments': 63,
      'isLiked': false,
    },
    {
      'name': 'Gabbar',
      'image': 'assets/dog6.jpg',
      'caption': 'Birthday celebration continues! 🎉',
      'time': '1 day ago',
      'likes': 145,
      'comments': 48,
      'isLiked': false,
    },
    {
      'name': 'Gabbar',
      'image': 'assets/dog7.jpeg',
      'caption': 'In an angry mood today 😠',
      'time': '2 days ago',
      'likes': 167,
      'comments': 55,
      'isLiked': false,
    },
    {
      'name': 'Gabbar',
      'image': 'assets/dog8.jpeg',
      'caption': 'Gabbar as doctor, doing treatment of patient today 👨‍⚕️',
      'time': '2 days ago',
      'likes': 198,
      'comments': 71,
      'isLiked': false,
    },
  ];

  List<Map<String, dynamic>> _displayedPosts = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadInitialPosts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _loadInitialPosts() {
    setState(() {
      _displayedPosts = _allPosts.take(3).toList();
    });
  }

  Future<void> _loadMorePosts() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    setState(() {
      final remainingPosts = _allPosts.length - _displayedPosts.length;
      final nextPosts = remainingPosts > 3 ? 3 : remainingPosts;

      if (nextPosts > 0) {
        _displayedPosts.addAll(
          _allPosts.getRange(_displayedPosts.length, _displayedPosts.length + nextPosts),
        );
      }

      _isLoading = false;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      _loadMorePosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Social Media',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _displayedPosts.length + 1,
        itemBuilder: (context, index) {
          if (index < _displayedPosts.length) {
            return _buildPostCard(index, _displayedPosts[index]);
          } else if (_displayedPosts.length < _allPosts.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            if (index != _selectedIndex) {  // Only navigate if selecting a different tab
              setState(() {
                _selectedIndex = index;
              });
              
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                  break;
                case 3:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                  break;
                // Removed case 4 since we're already on Social screen
              }
            }
          },
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          selectedFontSize: MediaQuery.of(context).size.width * 0.035,
          unselectedFontSize: MediaQuery.of(context).size.width * 0.03,
          iconSize: MediaQuery.of(context).size.width * 0.07,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home,
                color: Colors.black,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search,
                color: Colors.black,),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.upload_file,
                color: Colors.black,),
              label: 'Upload',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.design_services,
                color: Colors.black,),
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle,
                color: Colors.black,),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> _comments = [
    {'username': 'John', 'comment': 'Such a cute dog! 🐕', 'time': '1h ago'},
    {'username': 'Sarah', 'comment': 'Adorable! ❤️', 'time': '2h ago'},
    {'username': 'Mike', 'comment': 'Looking good!', 'time': '3h ago'},
    {'username': 'Emma', 'comment': 'What a lovely picture! 😍', 'time': '4h ago'},
    {'username': 'David', 'comment': 'Great shot!', 'time': '5h ago'},
    {'username': 'Lisa', 'comment': 'This made my day! 🌟', 'time': '6h ago'},
    {'username': 'Alex', 'comment': 'Beautiful moment captured', 'time': '7h ago'},
    {'username': 'Sophie', 'comment': 'So precious! 💖', 'time': '8h ago'},
    {'username': 'James', 'comment': 'Fantastic photo!', 'time': '9h ago'},
    {'username': 'Olivia', 'comment': 'Love this! 🐾', 'time': '10h ago'},
    {'username': 'Daniel', 'comment': 'Amazing shot!', 'time': '11h ago'},
    {'username': 'Mia', 'comment': 'This is so sweet! 🥰', 'time': '12h ago'},
    {'username': 'William', 'comment': 'Perfect timing!', 'time': '13h ago'},
    {'username': 'Ava', 'comment': 'Absolutely adorable! ✨', 'time': '14h ago'},
    {'username': 'Lucas', 'comment': 'Great composition!', 'time': '15h ago'},
    {'username': 'Isabella', 'comment': 'This is everything! 💫', 'time': '16h ago'},
    {'username': 'Henry', 'comment': 'Wonderful capture!', 'time': '17h ago'},
    {'username': 'Sophia', 'comment': 'So much joy in this photo! 🌈', 'time': '18h ago'},
    {'username': 'Jack', 'comment': 'Brilliant shot!', 'time': '19h ago'},
    {'username': 'Emily', 'comment': 'This is pure happiness! 💝', 'time': '20h ago'}
  ];

  void _showCommentDialog(BuildContext context, int postIndex) {
    final TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              title: const Text('Comments'),
              content: Container(
                width: double.maxFinite,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          ..._comments.map((comment) => _buildCommentItem(
                                comment['username'] as String,
                                comment['comment'] as String,
                                comment['time'] as String,
                              )),
                          const Divider(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: commentController,
                      decoration: const InputDecoration(
                        hintText: 'Add a comment...',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (commentController.text.isNotEmpty) {
                      setDialogState(() {
                        _comments.insert(0, {
                          'username': 'User',
                          'comment': commentController.text,
                          'time': 'Just now'
                        });
                      });
                      setState(() {
                        _displayedPosts[postIndex]['comments']++;
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Post'),
                ),
              ],
            );
          },
        );
      },
    ).then((_) => commentController.dispose());
  }

  Widget _buildCommentItem(String username, String comment, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 16,
            child: Icon(Icons.person, size: 20),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(comment),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(int index, Map<String, dynamic> post) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        bool isLiked = post['isLiked'];
        int likes = post['likes'];

        return Card(
          margin: const EdgeInsets.all(8.0),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(post['image']),
                ),
                title: Text(
                  post['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(post['time']),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(post['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  post['caption'],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : null,
                          ),
                          onPressed: () {
                            setState(() {
                              post['isLiked'] = !isLiked;
                            });
                            setState(() {
                              _displayedPosts[index]['isLiked'] = post['isLiked'];
                            });
                          },
                        ),
                        Text('${isLiked ? likes + 1 : likes}'),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.comment_outlined),
                          onPressed: () => _showCommentDialog(context, post['comments']),
                        ),
                        Text('${post['comments']}'),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.share_outlined),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
