# DESIGN NOTES — Dashboard Kinerja Penjualan (PT Sinar Niaga Nusantara)

**Berkas:** `dashboard.html` (buka langsung di browser, tanpa instalasi atau internet) · `screenshot_1_ringkasan_direksi.png` · `screenshot_2_detail_region_jawa_timur.png`.

## Pengguna dan KPI
| Pengguna | Pertanyaan | Halaman |
|---|---|---|
| Direksi | Apakah perusahaan sehat, dan ke mana harus melihat? | Ringkasan Direksi |
| Manajer Penjualan Region | Bagaimana region saya dibanding tahun lalu dan region lain? | Detail Region |

**KPI: pendapatan bersih, laba kotor, dan margin laba kotor, selalu bersama-sama dan selalu dibanding FY2025.** Pendapatan tetap di paling kiri dan berukuran besar (permintaan Head of Sales), tetapi tidak sendirian: pendapatan FY2026 naik 13.2% sementara laba kotor turun 9.6%, sehingga pendapatan saja menyesatkan. Pendapatan bersih = penjualan selesai dikurangi retur; order batal tidak dihitung.

## Keputusan desain
- **Dua halaman, tiga KPI, tiga grafik** di halaman Direksi (tren bulanan, region, besar diskon) agar terbaca kurang dari lima menit tanpa panduan. Halaman region: tiga KPI, satu tren, dua tabel.
- **Filter:** channel (Semua/Online/Offline) di semua halaman; region di halaman detail. Setiap angka dibandingkan dengan FY2025, dan region dengan rata-rata region lain (tertera di kartu margin) serta tabel semua region.
- **Warna bermakna:** biru tua = FY2026, biru muda = FY2025, hijau/merah hanya untuk baik/buruk. Tidak ada pie chart atau grafik 3D. Mendukung mode terang dan gelap.
- **Total konsisten:** tabel perbandingan region memuat baris "Tidak diketahui" sehingga totalnya sama dengan halaman Direksi (Rp 29.6 miliar).

## Persiapan data dan asumsi
Sumber: data bersih dari Soal 1 (190 transaksi ganda, 32 data uji, 982 baris satuan ribuan, format tanggal dan label sudah diperbaiki). FY = 1 Sep–31 Agu. 8 baris Retail berukuran 100–400 unit dikecualikan (diduga salah input). Data berakhir 15 Sep 2026, jadi Sep 2026 tidak ditampilkan. Teks "Temuan utama" dihitung dari data yang sama dan tidak berubah saat filter diganti.

## Temuan yang terlihat langsung di dashboard
1. Pendapatan bersih naik 13.2% (Rp 26.1 → 29.6 miliar), tetapi laba kotor turun 9.6% (Rp 3.91 → 3.54 miliar); margin 15.0% → 12.0%.
2. Margin turun sejak Sep 2025 dan tidak pulih (garis merah pada tren bulanan). Penyebabnya diskon: margin -1.4% pada diskon 20% dan -18.4% pada 30%.
3. Pilih channel **Online**: pendapatan -0.55% tetapi laba kotor -55%. **Offline**: pendapatan +22%, laba kotor +15%.
4. Jawa Timur: margin terendah (8.4%, rata-rata region lain 12.8%) dan pendapatan naik 27.2% tetapi laba kotor turun 32.4%; Sulawesi tertinggi (14.8%).
5. Pertumbuhan melambat: Jun–Agu 2026 pendapatan -9.1% dibanding tahun lalu.

## Keterbatasan
Satu tahun pembanding saja; tidak ada rincian per produk; dashboard memakai data tetap (belum terhubung ke sumber otomatis). Tautan publik tidak disediakan; berkas HTML dapat dibuka tanpa login.
