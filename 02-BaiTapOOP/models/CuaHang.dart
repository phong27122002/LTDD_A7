import 'DienThoai.dart';
import 'HoaDon.dart';

class Cuahang {
  String _tenCuaHang;
  String _diaChi;
  List<DienThoai> _dsDienthoai = [];
  List<HoaDon> _dsHoaDon = [];

  //Constructor
  Cuahang(this._tenCuaHang, this._diaChi);

  // Getter
  String get tenCuaHang => _tenCuaHang;
  String get diaChi => _diaChi;
  List<DienThoai> get dsDienThoai => _dsDienthoai;
  List<HoaDon> get dsHoaDon => _dsHoaDon;

  // Thêm điện thoại mới
  void themDienThoaiMoi(DienThoai dt) {
    _dsDienthoai.add(dt);
  }

  // Cập nhật thông tin điện thoại
  void capNhatDienThoai(String maDT, DienThoai dienThoaiMoi) {
    print("---------Cập nhật thông tin ---------");
    for (int i = 0; i < _dsDienthoai.length; i++) {
      if (_dsDienthoai[i].maDT == maDT) {
        _dsDienthoai[i] = dienThoaiMoi;
        return;
      }
    }
    print("Không tìm thấy điện thoại với mã $maDT");
  }

  // Ngừng kinh doanh điện thoại
  void ngungKinhDoanhDienThoai(String maDT) {
    for (int i = 0; i < _dsDienthoai.length; i++) {
      if (_dsDienthoai[i].maDT == maDT) {
        _dsDienthoai[i].trangThai = false;
        return;
      }
    }
    print("Không tìm thấy điện thoại với mã $maDT");
  }

  // Tìm kiếm điện thoại (theo mã, tên, hãng)
  List<DienThoai> timKiemDienThoai({String? maDT, String? ten, String? hSX}) {
    return _dsDienthoai.where((dt) {
      bool match = true;

      if (maDT != null && !dt.maDT.contains(maDT)) match = false;
      if (ten != null && !dt.ten.contains(ten)) match = false;
      if (hSX != null && !dt.hSX.contains(hSX)) match = false;

      return match;
    }).toList();
  }

  // Hiển thị danh sách điện thoại
  void hienThiDanhSachDienThoai() {
    print("--------------------------------------");
    print("---------Thông tin điện thoại---------");
    for (var dt in _dsDienthoai) {
      print(
          'Mã điện thoại: ${dt.maDT} | Tên Điện Thoại: ${dt.ten} | Hãng Sản Xuất: ${dt.hSX} | Giá Nhập: ${dt.giaNhap} | Giá Bán: ${dt.giaBan} | Số Lượng Tồn Kho: ${dt.sLTK} | Trạng Thái: ${dt.KiemTraTrangThai()}');
    }
    print("--------------------------------------");
  }

  // Tạo hóa đơn mới
  void themHoaDon(HoaDon hoaDon) {
    _dsHoaDon.add(hoaDon);
    // Cập nhật tồn kho
    for (var dt in _dsDienthoai) {
      if (dt.maDT == hoaDon.dienThoai.maDT) {
        dt.sLTK -= hoaDon.soLuongMua;
      }
    }
    print("Hóa đơn ${hoaDon.maHD} đã được tạo thành công.");
  }

  // Tìm kiếm hóa đơn (theo mã, ngày, khách hàng)
  List<HoaDon> timKiemHoaDon({String? maHD, DateTime? ngayBan, String? tenKH}) {
    return _dsHoaDon.where((hd) {
      bool match = true;
      if (maHD != null && !hd.maHD.contains(maHD)) match = false;
      if (ngayBan != null && hd.ngayBan != ngayBan) match = false;
      if (tenKH != null && !hd.tenKH.contains(tenKH)) match = false;
      return match;
    }).toList();
  }

  // Hiển thị danh sách hóa đơn
  void hienThiDanhSachHoaDon() {
    print("--------------------------------------");
    print("---------Danh sách hóa đơn-----------");
    for (var hd in _dsHoaDon) {
      hd.hienThiThongTin();
    }
    print("--------------------------------------");
  }

  // Tính tổng doanh thu theo khoảng thời gian
  double tongDoanhThu(DateTime startDate, DateTime endDate) {
    double tongTien = 0;
    for (var hd in _dsHoaDon) {
      if (hd.ngayBan.isAfter(startDate) && hd.ngayBan.isBefore(endDate)) {
        tongTien += hd.tinhTongTien();
      }
    }
    return tongTien;
  }

  // Tính tổng lợi nhuận theo khoảng thời gian
  double tongLoiNhuan(DateTime startDate, DateTime endDate) {
    double loiNhuan = 0;
    for (var hd in _dsHoaDon) {
      if (hd.ngayBan.isAfter(startDate) && hd.ngayBan.isBefore(endDate)) {
        loiNhuan += hd.tinhLoiNhuan();
      }
    }
    return loiNhuan;
  }

  // Thống kê top điện thoại bán chạy
  void thongKeTopDienThoaiBanChay() {
    Map<String, int> soLuongBan = {};
    for (var hd in _dsHoaDon) {
      if (soLuongBan.containsKey(hd.dienThoai.maDT)) {
        soLuongBan[hd.dienThoai.maDT] =
            soLuongBan[hd.dienThoai.maDT]! + hd.soLuongMua;
      } else {
        soLuongBan[hd.dienThoai.maDT] = hd.soLuongMua;
      }
    }
    // Sắp xếp theo số lượng bán
    var sortedList = soLuongBan.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    print("Top điện thoại bán chạy:");
    for (var entry in sortedList) {
      print('Mã điện thoại: ${entry.key} | Số lượng bán: ${entry.value}');
    }
  }

  // Thống kê tồn kho
  void thongKeTonKho() {
    print("Tồn kho của các điện thoại:");
    for (var dt in _dsDienthoai) {
      print('Mã điện thoại: ${dt.maDT} | Tồn kho: ${dt.sLTK}');
    }
  }
}