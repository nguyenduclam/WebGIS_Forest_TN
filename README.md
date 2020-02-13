# WebGIS of Forest

## Note 1
+ Note 1.0: Đã upload dữ liệu lên Geoserver và view lên Web để nhìn tổng quan
<img src="img/Note_img/Note_1.png" width="50%">
+ <a href='https://nguyenduclam.github.io/'>Link Demo</a>

### Note 1.1: Quay lại ý tưởng Leaflet và Geoserver
+ Hoàn thành tương đương như R Shiny Leaflet
+ Sử dụng nhiều thư viện khác nhau hỗ trợ cho leaflet như: leaflet-searrch, leaflet-providers.js, leaflet-ajax, L.Control.ZoomMin
+ Chuyển đổi dữ liệu shp sang 2 dạng chính là json và js (biến chuỗi json thành biến trong javascript)
+ Áp dụng kỹ thuật $.getJSON để biên tập dữ liệu định lượng
+ Chưa bật tắt được các lớp $.getJSON
<img src="img/Note_img/Note_1_1.png" width="50%">

### Note 1.2: Thêm Bar Chart và bật tắt các lớp
+ Đã bật tắt được các lớp $.getJSON
+ Thay đổi thư viện L.Control.ZoomMin thành leaflet.zoomhome
+ Không sử dụng dữ liệu js, chỉ còn sử dụng json hoặc geoJSON
+ Thêm Bar Chart bằng thư viện leaflet.mincharts (có hỗ trợ cả bên R)
<img src="img/Note_img/Note_1_2.png" width="50%">

### Note 1.2: Thêm Popup cho Chart
+ Thêm và style lại Popup - dựa theo mẫu của R
<img src="img/Note_img/Note_1_3.png" width="50%">
<h3>Vấn đề mới</h3>
<h4>Cách 1</h4>
+ Nên dynamic legend: bật lớp nào thì chỉ cần hiện legend lớp đó
+ Nếu bật lớp khác thì tự động tắt lớp vừa bật
<h4>Cách 2</h4>
+ Cho kéo thả legend
+ Hoặc tự động fix legend nhỏ lại
<h4>Cách 3</h4>
Gộp cả 2 cách trên: vừa cho phép dynamic, vừa cho phép kéo thả
<img src="img/Note_img/Note_1_3.png" width="50%">

## Note 2
+ Note 2: Geoserver không hỗ trợ xuất điểm có thứ tự
<img src="img/Note_img/Note_2.png" width="50%">

## Note 3
+ Note 3: Chuyển sang R Shiny Leaflet
<img src="img/Note_img/Note_3.png" width="50%">

## Note 4
+ Note 4:
    + Làm việc trên R Shiny Leaflet 
    + Custom Icon Legend - khả năng tự động hóa thấp
    + Tương đối hạn chê khi viết javascript, có hình ảnh phải chèn chuỗi String dạng Base 64
<img src="img/Note_img/Note_4.png" width="50%">

## Note 5
+ Note 5:
    + Làm việc trên R Shiny Leaflet - thêm package leaflet extract
    + Custom Icon Legend - cao hơn Note 4
    + Thêm Layer Base Map Control
    + Loại bỏ button, thêm search bar và reset layout map
    + Không cần thông qua javascript
    + Hình ảnh vẫn chưa khắc phục (phải chuyển quan base 64)
<img src="img/Note_img/Note_5.png" width="50%">

## Note 6
+ Note 6:
    + Thêm Chart cho bộ dữ liệu
    + Không thể bật tắt Chart (do LayerGroup không hỗ trợ)
<img src="img/Note_img/Note_6.png" width="50%">