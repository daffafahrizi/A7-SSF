
# EcoBin: Transforming the Way We Dispose

 In this modern day world, the current day-to-day waste disposal systems heavily rely on manual operation, requiring individuals to physically open the trash bin lid, whether using their hands or their feet. This process not only consumes time, but also creates inconvenience and gives a suboptimal user experience, leading to discomfort and dissatisfaction. The manual operation required to open the bin lid can be cumbersome and unhygienic. Moreover, individuals may hesitate to dispose of waste properly if they perceive the process as inconvenient or unpleasant. Therefore, there is a need for a more comfortable and user-friendly waste disposal system.
 
 
 The Eco Bin is an innovative and environmentally friendly automated trash bin system. It is powered by a HC-SR04 distance sensor and an Arduino microcontroller, enabling automation and enhances the user experience. 
 
 When a person approaches the bin, the distance sensor will detect their presence and send a signal to the Arduino. The Arduino will then activate a servo motor, automatically opening the bin lid. This automation eliminates the need for manual operation, significantly improving the efficiency and convenience of waste disposal. In addition to the automated operation, the Eco Bin will include a manual button for opening the bin lid, providing users with flexibility and efficiency in disposing trash.

# Hardware and Tools Requirements
* Arduino microcontroller
* HC-SR04 distance sensor
* Servo motor
* LED indicator
* Trash bin
* Jumper wires
* Power source

# Hardware Design and Implementation
placeholder

# Software Implementation 
Selama produksi, kami menggunakan aplikasi arduino untuk melakukan pemrograman dan upload ke mikrokontroler Arduino Uno yang kami gunakan dalam proyek kami. Untuk menggunakan program assembly, dibutuhkan aplikasi Arduino yang dapat diinstall melalui link berikut: https://www.arduino.cc/en/software. 

Dalam kode ini digunakan beberapa subroutine untuk mengendalikan sensor ultrasonic HCSR-04, Servo SG90, Button dan Delay. Kode di awal mendefinisikan offset SFR dan mengimpor file avr/io.h yang berisi deklarasi register mikrokontroler AVR. Fungsi **main** adalah fungsi utama program yang akan dijalankan secara berulang. Di dalamnya, terdapat pemanggilan fungsi **HC_SR04_sensor** dan **RJMP** untuk kembali ke **main**. Fungsi **HC_SR04_sensor** adalah fungsi yang melakukan pengukuran menggunakan sensor HC-SR04. Di dalam fungsi **HC_SR04_sensor**, terdapat instruksi-instruksi yang mengatur pin I/O pada mikrokontroler untuk menghubungkan dengan sensor HC-SR04. Setelah pengaturan pin selesai, dilakukan pengiriman pulsa sinyal tinggi selama 10 mikrodetik ke sensor HC-SR04. Setelah itu, fungsi **echo_PW** dipanggil untuk menghitung lebar pulsa yang diterima dari sensor HC-SR04. Setelah mendapatkan lebar pulse, dilakukan konversi dan tampilan data menggunakan fungsi byte2decimal. Terakhir, dilakukan penundaan (delay) dalam beberapa milidetik menggunakan fungsi delay_ms.

Selain itu, terdapat juga subrutin-subrutin tambahan seperti subrutin untuk penundaan menggunakan timer dan subrutin untuk penundaan dalam milidetik. Kode ini memiliki tujuan untuk mengendalikan sensor HC-SR04 dan berinteraksi dengan LED dan servo berdasarkan hasil pengukuran sensor jarak tersebut.

# Test Results and Performance Evaluation
Setelah dilakukan pengetesan, program mampu melakukan pengukuran jarak dengan baik. Program bereksi apabila mendeteksi objek dalam jarak kurang dari 15cm dengan memberikan indikator visual lewat lampu LED dan membuka tutup tempat sampah menggunakan servo. Dalam proses produk

# Conclusion and Future Work
placeholder

# Creators
* Aldrian Raffi Wicaksono	
* Daffa Anis Fahrizi 
* Rakha Argya Zahran
* M. Farrel Athaillah N.
