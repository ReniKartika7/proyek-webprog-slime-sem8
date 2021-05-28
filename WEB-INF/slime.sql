-- Create DB
CREATE DATABASE IF NOT EXISTS slime 

USE slime

-- Create Table user
CREATE TABLE IF NOT EXISTS users (
    user_id INT(10) AUTO_INCREMENT NOT NULL,
    user_email VARCHAR(150) NOT NULL,
    user_name VARCHAR(50) NOT NULL,
    user_phone VARCHAR(20) NOT NULL,
    user_password VARCHAR(150) NOT NULL,
    user_gender VARCHAR(10) NOT NULL,
    is_admin TINYINT(1) NOT NULL,
    PRIMARY KEY(user_id)
);

-- Dummy data untuk user

INSERT INTO users (user_email, user_name, user_phone, user_password, user_gender, is_admin)
VALUES ('admin@slime.com', 'Admin', '0812345678', 'admin123', 'none', 1),
('reni@gmail.com', 'Reni Kartika', '08192912345', 'password123', 'female', 0),
('olel@gmail.com', 'Aurellia', '0823456432', 'password456', 'female', 0),
('jojo@gmail.com', 'Caecilia', '0843226584', 'password789', 'female', 0),
('regy@gmail.com', 'Regy M', '0894829102', 'hello12345', 'male', 0),
('arya@gmail.com', 'Arya K', '0819847232', 'hello67890', 'male', 0);


-- Create Table Address
CREATE TABLE IF NOT EXISTS `address` (
    address_id INT(10) AUTO_INCREMENT NOT NULL,
    user_id INT(10) NOT NULL,
    address_detail VARCHAR(255) NOT NULL,
    address_full_name VARCHAR(50) NOT NULL,
    address_phone_number VARCHAR(20) NOT NULL,
    address_province VARCHAR(150) NOT NULL,
    address_district VARCHAR(150) NOT NULL,
    address_subdistrict VARCHAR(150) NOT NULL,
    address_postal_code VARCHAR(10) NOT NULL,
    PRIMARY KEY (address_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Dummy data untuk address
INSERT INTO `address`(user_id, address_detail, address_full_name, address_phone_number, address_province, address_district, address_subdistrict, address_postal_code)
VALUES (2, 'Perumahan ABC Blok ZZ no 226', 'Reni Kartika', '08192912345', 'Kepulauan Bangka Belitung', 'Belitung Timur', 'Manggar', '33514'),
(2, 'Jalan Gatot Subroto No 226', 'Brandon', '0865372078', 'DKI Jakarta', 'Jakarta Barat', 'Kebon Jeruk', '11234');

-- Create Table SnackCategory
CREATE TABLE IF NOT EXISTS snack_category (
    snack_category_id INT(10) AUTO_INCREMENT NOT NULL,
    snack_category_name VARCHAR(50) NOT NULL,
    snack_category_cover_url VARCHAR(255) NOT NULL,
    PRIMARY KEY (snack_category_id)
);

-- Dummy data untuk SnackCategory
INSERT INTO snack_category (snack_category_name, snack_category_cover_url)
VALUES ('Noodle', 'https://drive.google.com/uc?export=view&id=1uvhwUVkwolbFbWsSTGTRMiNjk71i477W'),
('Chips', 'https://drive.google.com/uc?export=view&id=1hkj3CH9gacJXo6l9ckKtq93gnJXwEub0'),
('Chocho', 'https://drive.google.com/uc?export=view&id=1lzyNq4__3AysIZCg2QBQQ6F8a4EqGpPC'),
('Cheese', 'https://drive.google.com/uc?export=view&id=1bQurv0VgfEhn-O6Xizs26CwTN93P3wsn'),
('Beverage', 'https://drive.google.com/uc?export=view&id=1yU2UnbDre392Y22iynyWtKb9r_Z9Dh1d'),
('Other', 'https://drive.google.com/uc?export=view&id=1A-k-IchP0xHR10EHUjr_baMzXB9VODGq');


-- Create Table Snack
CREATE TABLE IF NOT EXISTS snacks (
    snack_id INT(10) AUTO_INCREMENT NOT NULL,
    snack_name VARCHAR(50) NOT NULL,
    snack_price INT(10) NOT NULL,
    snack_stock INT(10) NOT NULL,
    snack_cover_url VARCHAR(255) NOT NULL,
    snack_category_id INT(10) NOT NULL,
    snack_detail VARCHAR(450) NOT NULL,
    PRIMARY KEY (snack_id),
    FOREIGN KEY (snack_category_id) REFERENCES snack_category(snack_category_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Dummy data untuk Snack
INSERT INTO snacks (snack_name, snack_price, snack_stock, snack_cover_url, snack_category_id, snack_detail)
VALUES ('Myojo Mapo Men: Mapo Tofu Cup Ramen (1 Cup)', 35000, 50, 'https://drive.google.com/uc?export=view&id=1Z_rmIj_qy_vY76IfU-fCTpbYQ54jV-iY', 1, "Mapo tofu is one of the most popular Chinese dishes in Japan, and a popular inspiration for all sorts of delicious fusion foods. This cup ramen's savory broth has scallions, ground pork, and tofu, which re-hydrate and marinate in the spicy broth that clings to the noodles.");


-- Create table Cart
CREATE TABLE IF NOT EXISTS cart (
    cart_id INT(10) AUTO_INCREMENT NOT NULL,
    user_id INT(10) NOT NULL,
    snack_id INT(10) NOT NULL,
    quantity INT(10) NOT NULL,
    PRIMARY KEY (cart_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (snack_id) REFERENCES snacks(snack_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Dummy data untuk Cart
INSERT INTO cart (user_id, snack_id, quantity)
VALUES (2, 1, 2);


-- Create table TransactionHeader
CREATE TABLE IF NOT EXISTS transaction_header (
    transaction_id INT(10) AUTO_INCREMENT NOT NULL,
    user_id INT(10) NOT NULL,
    address_id INT(10) NOT NULL,
    transaction_date DATE NOT NULL,
    PRIMARY KEY (transaction_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (address_id) REFERENCES `address`(address_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Dummy data untuk TransactionHeader
INSERT INTO transaction_header (user_id, address_id, transaction_date)
VALUES (2, 1, '2020-06-30');



-- Create table TransactionDetail
CREATE TABLE IF NOT EXISTS transaction_detail (
    transaction_id INT(10) NOT NULL,
    snack_id INT(10) NOT NULL,
    quantity INT(10) NOT NULL,
    PRIMARY KEY (transaction_id, snack_id),
    FOREIGN KEY (transaction_id) REFERENCES transaction_header(transaction_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (snack_id) REFERENCES snacks(snack_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=MyIsam;

-- Dummy data untuk TransactionDetail
INSERT INTO transaction_detail (transaction_id, snack_id, quantity)
VALUES (1, 1, 3);


