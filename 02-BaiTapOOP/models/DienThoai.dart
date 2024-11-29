class DienThoai {
  String _maDT;
  String _ten;
  String _hSX;
  double _giaNhap;
  double _giaBan;
  int _sLTK;
  bool _trangThai = true;

  DienThoai(this._maDT, this._ten, this._hSX, this._giaNhap, this._giaBan,
      this._sLTK, this._trangThai) {
    this._maDT = maDT;
    this._ten = ten;
    this._hSX = hSX;
    this._giaNhap = _giaNhap;
    this._giaBan = giaBan;
    this.sLTK = sLTK;
    this._trangThai = trangThai;
  }

  //Getter
  String get maDT => _maDT;
  String get ten => _ten;
  String get hSX => _hSX;
  double get giaNhap => _giaNhap;
  double get giaBan => _giaBan;
  int get sLTK => _sLTK;
  bool get trangThai => _trangThai;

  // Setter
  set maDT(String maDT) {
    //Kiem tra ma khong rong va dinh dang DT-XXX
    final regex = RegExp(r'^DT-\d{3}$');
    if (maDT.isNotEmpty && regex.hasMatch(maDT)) {
      _maDT = maDT;
    } else {
      throw Exception("Mã điện thoại không hợp lệ.");
    }
  }

  set ten(String ten) {
    if (ten.isNotEmpty) {
      _ten = ten;
    } else {
      throw Exception("Tên không được rỗng.");
    }
  }

  set hSX(String hSX) {
    if (hSX.isNotEmpty) {
      _hSX = hSX;
    } else {
      throw Exception("Hãng sản xuất không được rỗng.");
    }
  }

  set giaNhap(double giaNhap) {
    if (giaNhap > 0) {
      _giaNhap = giaNhap;
    } else {
      throw Exception("Giá nhập phải lớn hơn 0.");
    }
  }

  set giaBan(double giaBan) {
    if (giaBan > 0) {
      _giaBan = giaBan;
    } else {
      throw Exception("Giá bán phải lớn hơn giá nhập.");
    }
  }

  set sLTK(int sLTK) {
    if (sLTK >= 0) {
      _sLTK = sLTK;
    } else {
      throw Exception("Số lượng tồn kho phải >= 0.");
    }
  }

  set trangThai(bool trangThai) {
    _trangThai = trangThai;
  }

  // Phuong thuc tinh loi nhuan du kien
  double tinhLoiNhuanDuKien() {
    if (_giaBan > giaNhap) {
      return (_giaBan - _giaNhap) * _sLTK;
    } else {
      return 0;
    }
  }

  // Phuong thuc hien thi thong tin
  void hienThiThongTin() {
    print("--------------------------------------");
    print("---------Thông tin điện thoại---------");
    print(
        'Mã điện thoại: ${_maDT} | Tên Điện Thoại: ${_ten} | Hãng Sản Xuất: ${_hSX} | Giá Nhập: ${_giaNhap} | Giá Bán: ${_giaBan} | Số Lượng Tồn Kho: ${_sLTK} | Trạng Thái: ${KiemTraTrangThai}');
  }

  // Phuong thuc kiem tra co the ban khong (con hang va dang kinh doanh)
  String KiemTraTrangThai() {
    if (_trangThai) {
      return "Đang kinh doanh";
    } else {
      return "Còn hàng";
    }
  }
}