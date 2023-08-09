class Sock {
  String status;
  List<SocketData> socket;

  Sock({required this.status, required this.socket});

  factory Sock.fromJson(Map<String, dynamic> json) {
    final itemList = (json['socket'] as List)
        .map((item) => SocketData.fromJson(item as List<dynamic>))
        .toList();

    return Sock(status: json['status'] as String, socket: itemList);
  }
}

class SocketData {
  int id;
  int quantidade;

  SocketData({required this.id, required this.quantidade});

  factory SocketData.fromJson(List<dynamic> json) {
    return SocketData(id: json[0] as int, quantidade: json[1] as int);
  }
}
