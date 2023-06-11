import 'package:flutter/material.dart';


    BottomNavigationBar buildBottomNavigationBar(int selectedIndex, void Function(int) onItemTapped) {
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('lib/assets/home_icon.png')),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('lib/assets/doa_icon.png')),
        label: 'Doa',
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('lib/assets/sound_icon.png')),
        label: 'Listening',
      ),
    ],
    currentIndex: selectedIndex,
    onTap: onItemTapped,
  );
}