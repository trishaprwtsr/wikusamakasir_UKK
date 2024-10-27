import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'tambahmenu.dart';
import 'menu_model.dart';
import 'menu_service.dart';
import 'editmenu.dart';

class KelolaMenu extends StatefulWidget {
  const KelolaMenu({Key? key}) : super(key: key);

  @override
  _KelolaMenuState createState() => _KelolaMenuState();
}

class _KelolaMenuState extends State<KelolaMenu> {
  final MenuService _menuService = MenuService();
  late Stream<List<MenuModel>> _menuStream;

  @override
  void initState() {
    super.initState();
    _menuStream = _menuService.getAllMenus(); // Get menu data from Firebase
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8EFE7), 
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8EFE7), 
        title: Text(
          "Data Minuman & Makanan",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ), 
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: "Cari nama barang",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // List of menu items from Firebase
            Expanded(
              child: StreamBuilder<List<MenuModel>>(
                stream: _menuStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Error fetching menu data"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No menu items available"));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        MenuModel menu = snapshot.data![index];
                        return buildMenuCard(
                          context,
                          menu,
                        );
                      },
                    );
                  }
                },
              ),
            ),

            // Add product button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.add, color: Colors.white),
                label: Text(
                  'Tambah produk',
                  style: GoogleFonts.poppins(
                    color: Colors.white, 
                    fontSize: 16, 
                  ),
                ),
                onPressed: () {
                  // Navigate to the "tambahmenu" screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TambahMenuPage(),
                    ),
                  ).then((value) {
                    setState(() {
                      _menuStream = _menuService.getAllMenus(); 
                    });
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build each menu card
  Widget buildMenuCard(BuildContext context, MenuModel menu) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network( 
            menu.imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          menu.name,
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        subtitle: Text(
          menu.code,
          style: GoogleFonts.poppins(fontSize: 14), 
        ),
        trailing: Text(
          "Rp. ${menu.salePrice}",
          style: GoogleFonts.poppins(fontSize: 12),
        ),
        onTap: () {
          // Navigate to edit page with selected menu
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditMenuPage(menu: menu),
            ),
          ).then((value) {
            setState(() {
              _menuStream = _menuService.getAllMenus(); 
            });
          });
        },
      ),
    );
  }
}
