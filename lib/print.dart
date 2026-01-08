// import 'dart:convert' show utf8;
// import 'package:pos_order_basic/app/modules/products/models/product_model.dart';
// import 'package:pos_order_basic/app/routes/app_pages.dart';

// import 'package:flutter_bluetooth_basic/src/bluetooth_device.dart';
// import 'package:intl/intl.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
// import 'package:flutter/material.dart' hide Image;
// import 'package:oktoast/oktoast.dart';

// class BluetoothDeviceTmp {
//   String name;
//   String address;
//   int type;

//   BluetoothDeviceTmp(
//       {required this.name, required this.address, required this.type});

//   BluetoothDeviceTmp.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     address = json['address'];
//     type = json['type'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['address'] = this.address;
//     data['type'] = this.type;
//     return data;
//   }
// }

// class BluePrint extends StatefulWidget {
//   final List<ProductModel> urunler;
//   BluePrint({required Key key, required this.title, required this.urunler})
//       : super(key: key);
//   final String title;

//   @override
//   _BluePrintState createState() => _BluePrintState();
// }

// class _BluePrintState extends State<BluePrint> {
//   PrinterBluetoothManager printerManager = PrinterBluetoothManager();

//   List<PrinterBluetooth> _devices = [];

//   @override
//   void initState() {
//     super.initState();
//     //_startScanDevices();
//     _testPrint(urunler, _devices);
//     /*
//     printerManager.scanResults.listen((devices) async {
//       // print('UI: Devices found ${devices.length}');
//       setState(() {
//         _devices = devices;
//         _testPrint(urunler, devices);
//       });
//     });
//     */
//   }

//   void _getList(List<PrinterBluetooth> devices) {
//     for (var i = 0; i < widget.urunler.length; i++) {
//       print("Urun ${urunler[i].isim} Fiyat: ${urunler[i].fiyat}");
//     }

//     demoReceipt(PaperSize.mm58, widget.urunler);
//     // _testPrint(selectedDevice, widget.urunler);
//   }

//   void _startScanDevices() {
//     setState(() {
//       _devices = [];
//     });
//     printerManager.startScan(Duration(seconds: 4));
//   }

//   void _stopScanDevices() {
//     printerManager.stopScan();
//   }

//   Future<Ticket> demoReceipt(PaperSize paper, List<Urun> urunler0) async {
//     // Future<Ticket> demoReceipt(PaperSize paper,) async {

//     PrinterBluetooth _device;

//     /*
//     var prefs1 = await SharedPreferences.getInstance();
//     var btDevice = BluetoothDeviceTmp.fromJson(json.decode(prefs1.getString('printerBluetooth')));
//     _device = _devices.singleWhere((element) => (element.name == btDevice.name && element.address == btDevice.address));
//     var btDevice1 = BluetoothDeviceTmp();
//     btDevice.name = _device.name;
//     btDevice.address = _device.address;
//     btDevice.type = _device.type;
//     prefs1.setString('printerBluetooth', json.encode(btDevice1));
//     */

//     final Ticket ticket = Ticket(paper);

//     // Print image
//     //  final ByteData data = await rootBundle.load('assets/rabbit_black.jpg');
//     // final Uint8List bytes = data.buffer.asUint8List();
//     // final Image image = decodeImage(bytes);
//     // ticket.image(image);

//     //
//     //  ticket.text('CATWALK',
//     //

//     ticket.text('CATWALK',
//         styles: PosStyles(
//           align: PosAlign.center,
//           height: PosTextSize.size2,
//           width: PosTextSize.size2,
//         ),
//         linesAfter: 1);

//     //ticket.text('Inh. M. Narli', styles: PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
//     ticket.text('Inh. M. Narli', styles: PosStyles(align: PosAlign.center));
//     ticket.text('Osterstrasse 124', styles: PosStyles(align: PosAlign.center));
//     //ticket.text('Osterstrasse 124', styles: PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));

//     ticket.text('20255 Hamburg', styles: PosStyles(align: PosAlign.center));

//     ticket.text('',
//         styles: PosStyles(
//             align: PosAlign.center,
//             height: PosTextSize.size1,
//             width: PosTextSize.size2));

//     ticket.text('Tel: 040/86643830', styles: PosStyles(align: PosAlign.left));

//     ticket.text('Str.Nr.:43/647/01727',
//         styles: PosStyles(align: PosAlign.left), linesAfter: 1);

//     final now = DateTime.now();
//     final formatter = DateFormat('MM/dd/yyyy HH:mm');
//     final String timestamp = formatter.format(now);

//     ticket.text("REG $timestamp",
//         styles: PosStyles(align: PosAlign.left), linesAfter: 1);

//     ticket.hr();

//     for (var i = 0; i < urunler0.length; i++) {
//       print("Urun ${urunler0[i].isim} Fiyat: ${urunler0[i].fiyat}");
//       ticket.row([
//         PosColumn(
//             text: urunler0[i].miktar.toString(),
//             width: 1,
//             styles: PosStyles(align: PosAlign.left)),
//         PosColumn(
//             text: urunler0[i].isim,
//             width: 5,
//             styles: PosStyles(align: PosAlign.left)),
//         PosColumn(
//             text: " EUR ", width: 1, styles: PosStyles(align: PosAlign.right)),
//         PosColumn(
//             text: display(urunler0[i].fiyat),
//             width: 5,
//             styles: PosStyles(align: PosAlign.right)),
//       ]);
//     }
//     double toplam = 0.00;
//     for (var i = 0; i < urunler0.length; i++) {
//       print("Urun ${urunler0[i].isim} Fiyat: ${urunler0[i].fiyat}");
//       toplam += urunler0[i].fiyat;
//     }

//     ticket.hr();

//     double mwst = (toplam * 0.19);

//     double umsatz = toplam - mwst;

//     ticket.row([
//       PosColumn(
//           text: 'UMSATZ 19% ',
//           width: 7,
//           styles: PosStyles(
//             align: PosAlign.left,
//             height: PosTextSize.size1,
//             width: PosTextSize.size1,
//           )),

//       PosColumn(
//           text: "EUR ",
//           width: 2,
//           styles: PosStyles(
//             align: PosAlign.center,
//             height: PosTextSize.size1,
//             width: PosTextSize.size1,
//           )),

//       // int euro = 0xa4;

//       PosColumn(
//           text: display(umsatz),
//           width: 3,
//           styles: PosStyles(
//             align: PosAlign.right,
//             height: PosTextSize.size1,
//             width: PosTextSize.size1,
//           )),
//     ]);

//     ticket.row([
//       PosColumn(
//           text: 'MWST   19% ',
//           width: 7,
//           styles: PosStyles(
//             align: PosAlign.left,
//             height: PosTextSize.size1,
//             width: PosTextSize.size1,
//           )),

//       PosColumn(
//           text: "EUR ",
//           width: 2,
//           styles: PosStyles(
//             align: PosAlign.center,
//             height: PosTextSize.size1,
//             width: PosTextSize.size1,
//           )),

//       // int euro = 0xa4;

//       PosColumn(
//           text: display(mwst),
//           width: 3,
//           styles: PosStyles(
//             align: PosAlign.right,
//             height: PosTextSize.size1,
//             width: PosTextSize.size1,
//           )),
//     ]);

//     ticket.row([
//       PosColumn(
//           text: 'TOTAL ',
//           width: 7,
//           styles: PosStyles(
//             align: PosAlign.left,
//             height: PosTextSize.size1,
//             width: PosTextSize.size1,
//           )),

//       PosColumn(
//           text: "EUR ",
//           width: 2,
//           styles: PosStyles(
//             align: PosAlign.center,
//             height: PosTextSize.size1,
//             width: PosTextSize.size1,
//           )),

//       // int euro = 0xa4;
//       PosColumn(
//           text: display(toplam),
//           width: 3,
//           styles: PosStyles(
//             align: PosAlign.right,
//             height: PosTextSize.size1,
//             width: PosTextSize.size1,
//           )),
//     ]);

//     ticket.row([
//       PosColumn(
//           text: 'BAR ',
//           width: 7,
//           styles: PosStyles(
//             align: PosAlign.left,
//             height: PosTextSize.size1,
//             width: PosTextSize.size1,
//           )),

//       PosColumn(
//           text: "EUR ",
//           width: 2,
//           styles: PosStyles(
//             align: PosAlign.center,
//             height: PosTextSize.size1,
//             width: PosTextSize.size1,
//           )),

//       // int euro = 0xa4;
//       PosColumn(
//           text: display(toplam),
//           width: 3,
//           styles: PosStyles(
//             align: PosAlign.right,
//             height: PosTextSize.size1,
//             width: PosTextSize.size1,
//           )),
//     ]);

//     ticket.hr(ch: '=', linesAfter: 1);

//     ticket.feed(1);
//     ticket.text('Umtausch innerhalb ',
//         styles: PosStyles(
//             align: PosAlign.center,
//             width: PosTextSize.size1,
//             fontType: PosFontType.fontA));
//     ticket.text('von 14 Tagen gegen ',
//         styles: PosStyles(
//             align: PosAlign.center,
//             width: PosTextSize.size1,
//             fontType: PosFontType.fontA));
//     ticket.text('Ware oder Gutschein',
//         styles: PosStyles(
//             align: PosAlign.center,
//             width: PosTextSize.size1,
//             fontType: PosFontType.fontA));

//     // Print QR Code from image
//     // try {
//     //   const String qrData = 'example.com';
//     //   const double qrSize = 200;
//     //   final uiImg = await QrPainter(
//     //     data: qrData,
//     //     version: QrVersions.auto,
//     //     gapless: false,
//     //   ).toImageData(qrSize);
//     //   final dir = await getTemporaryDirectory();
//     //   final pathName = '${dir.path}/qr_tmp.png';
//     //   final qrFile = File(pathName);
//     //   final imgFile = await qrFile.writeAsBytes(uiImg.buffer.asUint8List());
//     //   final img = decodeImage(imgFile.readAsBytesSync());

//     //   ticket.image(img);
//     // } catch (e) {
//     //   print(e);
//     // }

//     // Print QR Code using native function
//     // ticket.qrcode('example.com');

//     ticket.feed(2);
//     ticket.cut();
//     return ticket;
//   }

//   Future<Ticket> testTicket(PaperSize paper) async {
//     final Ticket ticket = Ticket(paper);

//     ticket.text(
//         'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
//     ticket.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
//         styles: PosStyles(codeTable: PosCodeTable.westEur));
//     ticket.text('Special 2: blåbærgrød',
//         styles: PosStyles(codeTable: PosCodeTable.westEur));

//     ticket.text('Bold text', styles: PosStyles(bold: true));
//     ticket.text('Reverse text', styles: PosStyles(reverse: true));
//     ticket.text('Underlined text',
//         styles: PosStyles(underline: true), linesAfter: 1);
//     ticket.text('Align left', styles: PosStyles(align: PosAlign.left));
//     ticket.text('Align center', styles: PosStyles(align: PosAlign.center));
//     ticket.text('Align right',
//         styles: PosStyles(align: PosAlign.right), linesAfter: 1);

//     ticket.row([
//       PosColumn(
//         text: 'col3',
//         width: 3,
//         styles: PosStyles(align: PosAlign.center, underline: true),
//       ),
//       PosColumn(
//         text: 'col6',
//         width: 6,
//         styles: PosStyles(align: PosAlign.center, underline: true),
//       ),
//       PosColumn(
//         text: 'col3',
//         width: 3,
//         styles: PosStyles(align: PosAlign.center, underline: true),
//       ),
//     ]);

//     ticket.text('Text size 200%',
//         styles: PosStyles(
//           height: PosTextSize.size2,
//           width: PosTextSize.size2,
//         ));

//     // Print image
//     // final ByteData data = await rootBundle.load('assets/logo.png');
//     //final Uint8List bytes = data.buffer.asUint8List();
//     //final Image image = decodeImage(bytes);
//     //ticket.image(image);
//     // Print image using alternative commands
//     // ticket.imageRaster(image);
//     // ticket.imageRaster(image, imageFn: PosImageFn.graphics);

//     // Print barcode
//     final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
//     ticket.barcode(Barcode.upcA(barData));

//     // Print mixed (chinese + latin) text. Only for printers supporting Kanji mode
//     // ticket.text(
//     //   'hello ! 中文字 # world @ éphémère &',
//     //   styles: PosStyles(codeTable: PosCodeTable.westEur),
//     //   containsChinese: true,
//     // );

//     ticket.feed(2);

//     ticket.cut();
//     return ticket;
//   }

//   void _testPrint(List<Urun> urunler1, List<PrinterBluetooth> _devices) async {
//     // void _testPrint(PrinterBluetooth printer) async {
//     PrinterBluetooth _device;

//     //_device = _devices.singleWhere(
//     //        (element) => (element.name == btDevice.name && element.address == btDevice.address));

//     var bluetoothDevice = BluetoothDevice();
//     bluetoothDevice.name = "BlueTooth Printer";

//     //bluetoothDevice.address = "0F:02:18:B2:02:F3"; //Defile Hamburger Meile
//     //bluetoothDevice.address = "0F:02:18:B0:10:1B"; //Catwalk Am Brodanbank
//     bluetoothDevice.address = "0F:02:18:A2:9A:B9"; //New Look Oster Str
//     bluetoothDevice.connected = true;
//     _device = PrinterBluetooth(bluetoothDevice);

//     print(_device);
//     printerManager.selectPrinter(_device);

//     // TODO Don't forget to choose printer's paper

//     const PaperSize paper = PaperSize.mm58;

//     // TEST PRINT
//     // final PosPrintResult res =
//     // await printerManager.printTicket(await testTicket(paper));

//     // DEMO RECEIPT
//     final PosPrintResult res =
//         await printerManager.printTicket(await demoReceipt(paper, urunler1));
//     //await printerManager.printTicket(await demoReceipt(paper));
//     print(res.msg);
//     setState(() {
//       urunler1.clear();
//     });
//     if (res.msg == "Success") {
//       //ExtendedNavigator.root.popAndPush(Routes.myApp);

//     } else {
//       OKToast(
//         child: Text("Yazdirma Hatasi Servisi Arayin"),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//             child: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(),
//           Text("Yazdirma Yapiliyor"),
//         ],
//       ),
//     )));
//   }
// }
