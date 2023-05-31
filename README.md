# VNID Translation Project [1]

## Detail Game

**Info**

- Judul (JP) : 兄嫁は俺のモノを離さない ～未亡人若女将の誘惑～
- Judul (Romaji) : Aniyome wa Ore no Mono o Hanasanai ~Miboujin Wakaokami no Yuuwaku~
- Judul (EN) : My sister-in-law won’t let go of my c\*ck ~Seduced by a widowed proprietress~
- Judul (ID) : Adik iparku tidak mau melepaskan k\*nt\*l ku ~Tergoda oleh janda pemilik penginapan~
- Bahasa : Inggris
- Pengembang : Appetite
- Tanggal rilis : 2023-03-17
- Rating: 18+
- Versi: 1.00

https://vndb.org/v27248
https://vndb.org/r103483

**Sinopsis**

Aku telah kembali ke penginapan mata air panas tempatku dibesarkan untuk bantu-bantu selama musim panas. Setelah menyelesaikan pekerjaan, suatu hari aku berendam di pemandian terbuka dan tenggelam dalam pikiran. Saat itulah adik iparku Yukari masuk…

## Cara Penggunaan

> Patch ini tidak akan bekerja jika versi game kamu tidak sama dengan versi game ini!
> Lihat versi game ini di [Detail Game](#detail-game "Detail Game").

- Download file `data.xp3` dan `syscg.xp3` di [Releases](https://github.com/Visual-Novel-Indonesia/xxx/releases "Releases").
- Backup file `data.xp3` dan `syscg.xp3` di folder instalasi gamenya atau tinggal ubah namanya menjadi `data.xp3.bak`, `syscg.xp3.bak`.
- Taruh file yang sudah di download tadi ke folder instalasi game.
- Selesai! Happy Gaming :)

## Berkontribusi

Tertarik bergabung dengan [Visual Novel Indonesia (VNID)](https://github.com/Visual-Novel-Indonesia "Visual Novel Indonesia") dan ingin ikut meramaikan komunitas Visual Novel di Indonesia?

## Catatan (Developer Only)

Beberapa tweak yang harus dilakukan agar MOD nya bekerja dan catatan untuk memudahkan pengembangan ke depan.

- `data/script/release.ks` ada fungsi yang mengecek keaslian `data.xp3` dan `patch.xp3`:

  ```ks
  var fn =
  [
      System.exeName.substr( System.exePath.length ),		//	エンジン名
      'data.xp3',
      'patch.xp3'
  ];
  ```

  Untuk mengatasi _error_ file tidak sesuai dengan tanda tangan, kita tinggal hapus item _array_ nya.

  ```ks
  var fn = [];
  ```

- `data/script/util.ks` ada fungsi untuk mengecek tanda tangan/_signature_ (file .sig):

  ```ks
  function sigCheck2(fname, publickey)
  {
      if (!sigCheck(fname, publickey)) {
          System.inform('–¼‚ª–³Œø‚Å‚· : '+fname);
          kag.shutdown();
      }
  }
  ```

  Untuk mengabaikan pengecekan file `.sig`, kita tinggal komentari isi fungsinya:

  ```ks
  function sigCheck2(fname, publickey)
  {
      if (!sigCheck(fname, publickey)) {
      	  /*
          System.inform('–¼‚ª–³Œø‚Å‚· : '+fname);
          kag.shutdown();
          /*
      }
  }
  ```

- **Hanya folder `data`** (yang sudah di-ekstrak) saja yang bisa dijalankan langsung tanpa harus me-repack nya kembali ke `.xp3`, selain dari itu tidak akan di-execute dan bila file aslinya (contoh: `syscg.xp3`) tidak ada di game namun ada folder `syscg` nya (secara otomatis Kirikiri Adventure Game (KAG) engine akan secara otomatis memprioritaskan/mengeksekusi folder tersebut) maka akan mengakibatkan error.
