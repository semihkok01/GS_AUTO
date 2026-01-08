class BluetoothDeviceTmp {
  String? name;
  String? address;
  int? type;

  BluetoothDeviceTmp(
      {required this.name, required this.address, required this.type});

  BluetoothDeviceTmp.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['type'] = this.type;
    return data;
  }
}
