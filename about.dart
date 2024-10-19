import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  // Function to launch a URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About this App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'This app is created by:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Linwel Colmo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'See me on GitHub: ',
              style: TextStyle(fontSize: 18),
            ),
            GestureDetector(
              onTap: () => _launchURL('https://github.com/leanwell'),
              child: Text(
                '@leanwell',
                style: TextStyle(fontSize: 18, color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Follow me on Instagram: ',
              style: TextStyle(fontSize: 18),
            ),
            GestureDetector(
              onTap: () => _launchURL('https://instagram.com/leanwell_'),
              child: Text(
                '@leanwell_',
                style: TextStyle(fontSize: 18, color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
