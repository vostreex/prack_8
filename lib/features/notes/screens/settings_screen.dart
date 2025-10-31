import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: CachedNetworkImage(
                imageUrl: 'https://deep-review.com/wp-content/uploads/2019/03/7-settings-and-advices-for-android-users.png',
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
              ),
            ),
            title: const Text('Основные настройки'),
            onTap: () {
              // Handle tap
            },
          ),
          ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: CachedNetworkImage(
                imageUrl: 'https://resizer.mail.ru/p/75324337-fb15-555a-a2e7-398e5079b851/AQAKeQiw7SdEcxPVVu1Y2WcBwl8BJ_I17k3N29pNJpI4k49NGMiCdM2j5UR0sEjDfxWQALtjOA8CQjVShptW2t5mgug.jpg',
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
              ),
            ),
            title: const Text('Аккаунт'),
            onTap: () {
              // Handle tap
            },
          ),
          ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: CachedNetworkImage(
                imageUrl: 'https://media.lpgenerator.ru/uploads/2020/01/13/1.png',
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
              ),
            ),
            title: const Text('Уведомления'),
            onTap: () {
              // Handle tap
            },
          ),
          ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: CachedNetworkImage(
                imageUrl: 'https://play-lh.googleusercontent.com/ZOt-qVtT1XEI4tXl_VbxepWQJ-cVd9JlQYuXEVTGuCW67zTzaIKvvnDdWDyZ6jk5qiI=w526-h296-rw',
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
              ),
            ),
            title: const Text('Темный режим'),
            onTap: () {
              // Handle tap
            },
          ),
          ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: CachedNetworkImage(
                imageUrl: 'https://mkperevod.ru/Gallery/Image/4489kti_gl2ccr0gbaqf7rh_y.jpg',
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
              ),
            ),
            title: const Text('Язык'),
            onTap: () {
              // Handle tap
            },
          ),
        ],
      ),
    );
  }
}