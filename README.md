# ✨Gits Logtime✨
_Tools untuk mempermudah logtime kalian_

Tools ini otomatis menambahkan logtime ke akun clockify kalian ketika kalian melakukan push ke repository ✨

## Cara Instalasi
1. Unduh file aplikasi `*.zip` versi terbaru sesuai sistem operasi kalian, pada page release https://github.com/gitsindonesia/gits-logtime/releases 
![Page Release](/doc/release.png)
2. extract file `*.zip`
3. ingat - ingat tempat extract file tersebut (misal di `D:/folder` atau `~/folder`)

### Jika kamu pake MAC:
4. buka terminal pada folder hasil extract tadi
5. run command `chmod +x gits-logtime`
6. tambahkan PATH `gits-logtime` pada variable device
7. jika melakukan command pada `gits-logtime` gagal, coba cek pada setting/privacy & security dan allow `gits-logtime`
![Warning](/doc/mac1.png)
![Allow Anyway](/doc/mac2.png)

### Jika kamu pake Windows:
4. tambahkan PATH folder hasil extract tadi ke environment variable
![Environment Variable](/doc/env.png)
5. buka command prompt
6. coba run command `gits-logtime` jika muncul tulisan `Get it simple command...` berarti sudah bisa digunakan
![Success command](/doc/cmd.png)

---
## Cara Penggunaan
1. Buka terminal / command prompt di folder project yang akan kamu otomatisasi logtime nya
2. run command `gits-logtime init`
3. input **API Key clockify**. API Key bisa didapatkan dengan cara :
    1. buka menu `profile setting` yang ada di pojok kanan atas di web clockify

    ![Profile Setting](/doc/profile-setting.png)
    
    2. pada bagian paling bawah copy **API Key** nya

    ![Api Key](/doc/api-key-clockify.png)
4. input nama workspace clockify
5. input nama project clockify
6. input konfigurasi penyimpanan **start time nya**, apakah ketika **checkout branch** atau **last commit**
7. konfirmasi konfigurasi yang telah di input
8. jika berhasil maka akan ada tulisan `Config gits logtime & git hooks file created for this repository`
![Config Gits Logtime](/doc/all-config.png)