import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wikusamakasir_ukk/landingpage.dart';
import 'package:wikusamakasir_ukk/order_model.dart';
import 'package:wikusamakasir_ukk/order_service.dart';
import 'package:wikusamakasir_ukk/pesanan.dart';
import 'package:wikusamakasir_ukk/riwayatpesanan.dart';

class DashboardKasir2 extends StatefulWidget {
  DashboardKasir2({super.key});

  @override
  _DashboardKasir2State createState() => _DashboardKasir2State();
}

class _DashboardKasir2State extends State<DashboardKasir2> {
  String selectedCategory = 'Semua'; // Variabel untuk kategori yang dipilih
  final List<OrderItem> cartItems = []; // Daftar item di keranjang
  final orderService = OrderService(); // Inisialisasi OrderService

  final List<Map<String, String>> mockCardData = [
    {
      'title': 'Cappuccino',
      'subTitle': 'With Steamed Milk',
      'imagePath': 'assets/cappucino.png',
      'price': '14000',
      'starValue': '4.5',
      'category': 'Minuman', // Menambahkan kategori
    },
    {
      'title': 'Double Beef Burger',
      'subTitle': 'With egg and cheese',
      'imagePath': 'assets/burger.png',
      'price': '14000',
      'starValue': '4.8',
      'category': 'Snack', // Menambahkan kategori
    },
    {
      'title': 'Cinnamon Roll',
      'subTitle': 'With Vanilla Ice Cream',
      'imagePath': 'assets/cinnamon.png',
      'price': '10000',
      'starValue': '4.7',
      'category': 'Snack', // Menambahkan kategori
    },
    {
      'title': 'Kopi Gula Aren',
      'subTitle': 'No Milk',
      'imagePath': 'assets/gulaaren.png',
      'price': '12000',
      'starValue': '4.6',
      'category': 'Minuman', // Menambahkan kategori
    },
    {
      'title': 'Matcha Latte',
      'subTitle': 'With Steamed Milk',
      'imagePath': 'assets/matcha.png',
      'price': '18000',
      'starValue': '4.4',
      'category': 'Minuman', // Menambahkan kategori
    },
    {
      'title': 'Karamel Macchiato',
      'subTitle': 'With Steamed Milk',
      'imagePath': 'assets/macchiato.png',
      'price': '15000',
      'starValue': '4.2',
      'category': 'Minuman', // Menambahkan kategori
    },
  ];

  // Getter untuk mengembalikan data yang difilter
  List<Map<String, String>> get filteredData {
    if (selectedCategory == 'Semua') {
      return mockCardData;
    } else {
      return mockCardData
          .where((item) => item['category']!.toLowerCase() == selectedCategory.toLowerCase())
          .toList();
    }
  }

  // Menambahkan item ke keranjang
  void addToCart(Map<String, dynamic> item) {
  setState(() {
    OrderItem newItem = OrderItem.fromMap(item); // Converts the map to an OrderItem
    cartItems.add(newItem); // Add to the cart
    orderService.addItemToCart(newItem); // Add to OrderService
  });
}

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFF8EFE7),
      ),
    );

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8EFE7),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24.0, top: 4, bottom: 4),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                color: Colors.black,
                iconSize: 30,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PesananPage(cartItems: orderService.getCartItems()),
                    ),
                  );
                },

              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.brown,
                ),
                child: Text(
                  'Menu',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: Text(
                  'Riwayat Pesanan',
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RiwayatPesananScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(
                  'Profil',
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: Text(
                  'Keluar',
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LandingPage()),
                  );
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
            const SizedBox(height: 3),
              Text(
                'Selamat Pagi \nWilliam 👋',
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const TextSearchField(),
              SizedBox(
                height: 60,
                child: TabBar(
                  isScrollable: false,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Color(0xff52555a),
                  indicatorPadding: const EdgeInsets.all(1),
                  dragStartBehavior: DragStartBehavior.down,
                  tabs: ['Semua', 'Minuman', 'Snack'].map((e) {
                    final isSelected = e == selectedCategory;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = e;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.brown : Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: Colors.brown,
                              width: isSelected ? 0 : 1,
                            ),
                          ),
                          child: Tab(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              child: Text(
                                e,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.brown,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                    childAspectRatio: 0.5,
                  ),
                  itemCount: filteredData.length,
                  itemBuilder: (BuildContext context, int index) {
                    final cardData = filteredData[index];
                    return CardItem(
                      title: cardData['title']!,
                      subTitle: cardData['subTitle']!,
                      imagePath: cardData['imagePath']!,
                      price: cardData['price']!,
                      starValue: cardData['starValue']!,
                      onAddToCart: () {
                        addToCart(cardData);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextSearchField extends StatelessWidget {
  const TextSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 16),
      child: TextField(
        style: const TextStyle(color: Colors.white70),
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 25, right: 18),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          focusColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          hintText: 'Cari Menu',
          hintStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imagePath;
  final String price;
  final String starValue;
  final VoidCallback onAddToCart;

  const CardItem({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.imagePath,
    required this.price,
    required this.starValue,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42, // Adjust width properly
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.elliptical(25, 25)),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 120, // Adjust height to a reasonable value
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath), // Display image from assets
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.elliptical(25, 25),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 8, sigmaX: 8),
                    child: Container(
                      height: 25,
                      width: 50, // Adjust width properly
                      decoration: const BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 15,
                          ),
                          Text(
                            starValue,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Text(
            subTitle,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black38,
            ),
          ),
          const SizedBox(height: 9),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\Rp. $price',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Center(
            child: ElevatedButton(
              onPressed: onAddToCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown, // Warna tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Add to Cart',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
