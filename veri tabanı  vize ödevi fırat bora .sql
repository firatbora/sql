BEGIN TRANSACTION
BEGIN TRY

CREATE TABLE kategoriler (
  id int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
  kategoriAd varchar(150) NOT NULL

);
CREATE TABLE odemeYontemleri (
  id int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
  yontemAd varchar(150) NOT NULL
);
CREATE TABLE siparisler (
  id int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
  odemeYontemId int NOT NULL,
  toplamTutar decimal(10,0) NOT NULL,
  
  FOREIGN KEY (odemeYontemId) REFERENCES odemeYontemleri(id)
);
CREATE TABLE siparisDetay (
  id int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
  siparisId int NOT NULL,
  uruntId int NOT NULL,
  urunMiktar int NOT NULL,

  FOREIGN KEY (siparisId) REFERENCES siparisler(id)
);




CREATE TABLE urunler (
  id int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
  urunAd varchar(500) NOT NULL,
  urunFiyat decimal(10,0) NOT NULL,
  urunKategoriId int NOT NULL,
  
  FOREIGN KEY (urunKategoriId) REFERENCES kategoriler(id)

);


INSERT INTO kategoriler (kategoriAd) VALUES
('Ana yemek'),
('Çorba'),
('Tatlý'),
('Ara yemek');

INSERT INTO urunler (urunAd, urunFiyat, urunKategoriId) VALUES
('Mercimek Çorbasý', 6, 2),
('Köfte', 15, 1),
('Pilav', 10, 1),
('Mantý', 12, 4),
('Künefe', 15, 3);


INSERT INTO odemeYontemleri (yontemAd) VALUES
('Nakit'),
('Kart'),
('Senet'),
('Taksit');




INSERT INTO siparisler (odemeYontemId, toplamTutar) VALUES
(1, 12),
(1, 123),
(1, 232),
(1, 12),
(1, 123),
(1, 232),
(1, 12),
(1, 123),
(1, 232),
(1, 12),
(1, 123),
(1, 232);

INSERT INTO siparisDetay(siparisId, uruntId, urunMiktar) VALUES
(1, 3, 1),
(2, 1, 2);

/*sorgu 1*/
select * from kategoriler;

/*sorgu 2*/
select urunAd as 'Yemek Adý', kategoriAd as 'Kategori Adý' from urunler u
inner join kategoriler k on k.id = u.urunKategoriId ;

/* sorgu 3 */
select urunAd, kategoriAd, urunMiktar from siparisler s
inner join siparisDetay sd on sd.siparisId = s.id
inner join urunler u on sd.uruntId = u.id
inner join kategoriler k on u.urunKategoriId = k.id;

/* sorgu 4 */

update kategoriler SET kategoriAd = 'Kekler' where id = 3

/* sorgu 5 */
insert into kategoriler (kategoriAd) values ('deneme');
select * from kategoriler;

delete from kategoriler where kategoriAd = 'deneme';
select * from kategoriler;
COMMIT
END TRY
BEGIN CATCH
ROLLBACK
END CATCH