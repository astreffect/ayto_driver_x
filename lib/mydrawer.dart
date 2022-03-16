import 'package:flutter/material.dart';
import 'package:ayto_driver_x/brand_colors.dart';
import 'package:ayto_driver_x/tabs/mydivider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            Container(
                height: 160,
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color: BrandColors.button,
                  ),
                  child: Row(
                    children: [
                      Image.network('https://picsum.photos/250?image=9',
                        height: 60,width: 60,),
                      const SizedBox(width: 15,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Name",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          Text("View Profile",)

                        ],
                      )

                    ],

                  ),
                )
            ),
            const MyDivider(),
            const SizedBox(height: 10,),
            const ListTile(
              leading:  Icon(Icons.face_outlined),
              title: Text("Account",style: TextStyle(fontSize: 16),),
            ),
            const ListTile(
              leading:  Icon(Icons.credit_card),
              title: Text("Earning",style: TextStyle(fontSize: 16),),
            ),
            const ListTile(
              leading: Icon(Icons.star),
              title: Text("Rating",style: TextStyle(fontSize: 16),),
            ) ,

            const ListTile(
              leading: Icon(Icons.contact_support),
              title: Text("Support",style: TextStyle(fontSize: 16),),
            ) ,
            const ListTile(
              leading:  Icon(Icons.info_outline),
              title: Text("About",style: TextStyle(fontSize: 16),),
            ),
            const ListTile(
              leading:  Icon(Icons.logout),
              title: Text("Log Out",style: TextStyle(fontSize: 16),),
            )
          ],
        )
    );
  }
}