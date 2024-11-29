class DienThoai {
  String ma;
  String ten;
  String hang;
  double gia;
  int soLuongTon;

  DienThoai(this.ma, this.ten, this.hang, this.gia, this.soLuongTon);

  void capNhatThongTin({
    String? ten,
    String? hang,
    double? gia,
    int? soLuongTon,
  }) {
    if (ten != null) this.ten = ten;
    if (hang != null) this.hang = hang;
    if (gia != null) this.gia = gia;
    if (soLuongTon != null) this.soLuongTon = soLuongTon;
  }
}

class HoaDon {
  String ma;
  DateTime ngay;
  String khachHang;
  List<Map<DienThoai, int>> danhSachDienThoai;
  double tongTien;

  HoaDon(this.ma, this.ngay, this.khachHang, this.danhSachDienThoai, this.tongTien);
}

class CuaHang {
  String _tenCuaHang;
  String _diaChi;
  List<DienThoai> _danhSachDienThoai = [];
  List<HoaDon> _danhSachHoaDon = [];

  CuaHang(this._tenCuaHang, this._diaChi);

  // Thêm điện thoại mới
  void themDienThoai(DienThoai dienThoai) {
    _danhSachDienThoai.add(dienThoai);
  }

  // Cập nhật thông tin điện thoại
  void capNhatDienThoai(String ma, {
    String? ten,
    String? hang,
    double? gia,
    int? soLuongTon,
  }) {
    var dienThoai = _danhSachDienThoai.firstWhere((dt) => dt.ma == ma, orElse: () => throw Exception("Không tìm thấy điện thoại."));
    dienThoai.capNhatThongTin(ten: ten, hang: hang, gia: gia, soLuongTon: soLuongTon);
  }

  // Ngừng kinh doanh điện thoại
  void ngungKinhDoanhDienThoai(String ma) {
    _danhSachDienThoai.removeWhere((dt) => dt.ma == ma);
  }

  // Tìm kiếm điện thoại
  List<DienThoai> timKiemDienThoai({String? ma, String? ten, String? hang}) {
    return _danhSachDienThoai.where((dt) {
      return (ma == null || dt.ma.contains(ma)) &&
          (ten == null || dt.ten.contains(ten)) &&
          (hang == null || dt.hang.contains(hang));
    }).toList();
  }

  // Hiển thị danh sách điện thoại
  void hienThiDanhSachDienThoai() {
    for (var dt in _danhSachDienThoai) {
      print("Mã: ${dt.ma}, Tên: ${dt.ten}, Hãng: ${dt.hang}, Giá: ${dt.gia}, Số lượng tồn: ${dt.soLuongTon}");
    }
  }

  // Tạo hóa đơn mới
  void taoHoaDon(HoaDon hoaDon) {
    for (var item in hoaDon.danhSachDienThoai) {
      var dienThoai = item.keys.first;
      var soLuong = item.values.first;
      if (dienThoai.soLuongTon < soLuong) {
        throw Exception("Không đủ tồn kho.");
      }
      dienThoai.soLuongTon -= soLuong;
    }
    _danhSachHoaDon.add(hoaDon);
  }

  // Tìm kiếm hóa đơn
  List<HoaDon> timKiemHoaDon({String? ma, DateTime? ngay, String? khachHang}) {
    return _danhSachHoaDon.where((hd) {
      return (ma == null || hd.ma.contains(ma)) &&
          (ngay == null || hd.ngay == ngay) &&
          (khachHang == null || hd.khachHang.contains(khachHang));
    }).toList();
  }

  // Hiển thị danh sách hóa đơn
  void hienThiDanhSachHoaDon() {
    for (var hd in _danhSachHoaDon) {print("Mã hóa đơn: ${hd.ma}, Ngày: ${hd.ngay}, Khách hàng: ${hd.khachHang}, Tổng tiền: ${hd.tongTien}");
    }
  }

  // Tính tổng doanh thu theo khoảng thời gian
  double tinhTongDoanhThu(DateTime batDau, DateTime ketThuc) {
    return _danhSachHoaDon.where((hd) => hd.ngay.isAfter(batDau) && hd.ngay.isBefore(ketThuc))
        .fold(0, (sum, hd) => sum + hd.tongTien);
  }

  // Thống kê top điện thoại bán chạy
  List<DienThoai> thongKeTopBanChay() {
    var mapBanChay = <DienThoai, int>{};
    for (var hoaDon in _danhSachHoaDon) {
      for (var item in hoaDon.danhSachDienThoai) {
        var dienThoai = item.keys.first;
        var soLuong = item.values.first;
        mapBanChay[dienThoai] = (mapBanChay[dienThoai] ?? 0) + soLuong;
      }
    }
    var sortedDienThoai = mapBanChay.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sortedDienThoai.map((entry) => entry.key).toList();
  }
}