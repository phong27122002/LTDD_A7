class Phone {
  // Thuộc tính private
  String _id;
  String _name;
  double _price;
  int _stock;

  // Constructor
  Phone(this._id, this._name, this._price, this._stock);

  // Getter và setter với validation
  String get id => _id;

  String get name => _name;

  double get price => _price;

  set price(double value) {
    if (value < 0) {
      throw Exception("Giá không hợp lệ");
    }
    _price = value;
  }

  int get stock => _stock;

  set stock(int value) {
    if (value < 0) {
      throw Exception("Tồn kho không hợp lệ");
    }
    _stock = value;
  }

  // Cập nhật thông tin điện thoại
  void updateInfo(String name, double price) {
    if (name.isEmpty || price < 0) {
      throw Exception("Thông tin không hợp lệ");
    }
    _name = name;
    _price = price;
  }
}

class Invoice {
  String id;
  List<Phone> phones;
  double totalAmount;

  Invoice(this.id, this.phones) : totalAmount = _calculateTotal(phones);

  // Tính tổng tiền
  static double _calculateTotal(List<Phone> phones) {
    return phones.fold(0, (sum, phone) => sum + (phone.price * phone.stock));
  }
}

class Report {
  static void revenueByTime(List<Invoice> invoices) {
    double revenue = invoices.fold(
        0, (sum, invoice) => sum + invoice.totalAmount);
    print("Doanh thu: \$${revenue}");
  }

  static void bestSellingPhones(List<Phone> phones) {
    phones.sort((a, b) => b.stock.compareTo(a.stock));
    print("Top bán chạy:");
    phones.forEach((phone) {
      print("${phone.name}: ${phone.stock} chiếc");
    });
  }
}

void main() {
  // Thêm và quản lý thông tin điện thoại
  var phone1 = Phone("1", "iPhone", 1000, 5);
  var phone2 = Phone("2", "Samsung", 800, 10);

  // Cập nhật thông tin
  phone1.updateInfo("iPhone Pro", 1200);

  // Tạo hóa đơn
  var invoice = Invoice("INV001", [phone1, phone2]);

  // Thống kê báo cáo
  Report.revenueByTime([invoice]);
  Report.bestSellingPhones([phone1, phone2]);
}