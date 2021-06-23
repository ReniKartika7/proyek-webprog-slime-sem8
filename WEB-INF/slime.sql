-- Create DB
CREATE DATABASE IF NOT EXISTS slime;

USE slime;

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
VALUES ("Myojo Mapo Men: Mapo Tofu Cup Ramen (1 Cup)",
 35000,
 50,
 "https://drive.google.com/uc?export=view&id=1Z_rmIj_qy_vY76IfU-fCTpbYQ54jV-iY",
 1,
 "Mapo tofu is one of the most popular Chinese dishes in Japan, and a popular inspiration for all sorts of delicious fusion foods. This cup ramen's savory broth has scallions, ground pork, and tofu, which re-hydrate and marinate in the spicy broth that clings to the noodles."),
("Nissin Raoh: Rich Miso Ramen (1 Cup)",
 45000,
 30,
 "https://drive.google.com/uc?export=view&id=1Jn4cFy9N9-vixLW1vL6wEsOffWGPoeOd",
 1,
 "This flavorful ramen has a miso-based broth that is rich and cloudy, a splash of chili oil for an added kick, and yummy toppings like sweet corn, cabbage, scallions, sesame, and real ground pork! The thin straight noodles stay chewy longer than typical cup ramen noodles and carry the flavor of the soup with every bite."),
 ("Pokemon Noodle: Soy Sauce Flavor (1 Cup)",
 35000,
 50,
 "https://drive.google.com/uc?export=view&id=1eftBvozS4L2MW4634PQ-ccdmw9H7loX5",
 1,
 "This smaller ramen features popular Pokemon characters and is perfect for kids and adults alike. The delicious ramen has thin, wavy noodles in a soy sauce broth topped with corn and kawaii Pikachu kamaboko fish cake. As a bonus, each cup of ramen has a collectible character sticker, with 20 different characters can you catch them all?!"),
("Sugomen: Hakata Tonkotsu Ramen (1 Cup)",
 45000,
 25,
 "https://drive.google.com/uc?export=view&id=1RTkKsJgvMME64rHfMd2MFefp8o4OSr7e",
 1,
 "The Sugomen line of instant ramen is known for capturing the flavor of regional favorites in mere minutes. This ramen includes thin noodles, fried to ensure they stay perfectly chewy when cooked and multiple packets to achieve perfect flavoring, including a dehydrated slice of pork. The thick soup base and powder packets add the cloudy richness of traditional pork bone broth ramen, while the packet of green onions and sesame is a delicious garnish."),
("Nissin: European Cheese Curry Cup Noodle (1 Cup)",
 35000,
 30,
 "https://drive.google.com/uc?export=view&id=10YRpoTY9thx7AG6AucD3nRkVrAZqzi-P",
 1,
 "This European-inspired cup noodle can be made in just a few minutes! The beef curry broth is thick and rich, clinging to the noodles and flavoring them as they cook. You'll also find chopped mushrooms and carrots, ground beef, and melty mozzarella and cheddar cheeses."),
("Nissin Raoh: Shoyu Soy Sauce Ramen (1 Cup)",
 45000,
 40,
 "https://drive.google.com/uc?export=view&id=1DVyGfRWiQVuJ6vj4leJaJ0RgvxYtMdD6",
 1,
 "This umami-rich shoyu ramen is dripping with savory flavor! The soy sauce-based broth is dark and clear, and chicken and pork fat add richness. The sharpness of the scallions cuts through rich broth and keeps the flavors light and balanced. The thin straight noodles stay chewy longer, and the sliced pork topping is the salt final touch."),
("Samyang Hot Chicken Ramen Original Multipack (5 Pcs)",
 175000,
 30,
 "https://drive.google.com/uc?export=view&id=1TL65UT4gN5S-zZF0EjUGGqVWWj087L_t",
 1,
 "Samyang Hot Chicken Flavor Ramen or Buldak Bokkeum Ramyun, commonly known as the fire noodles, is a brand of ramen produced by Samyang Food in South Korea. Its incredibly spicy taste makes anyone so hard to finish it but because of this mouth-burning spiciness, it makes the spicy food lovers so addictive to it! It is simply perfect for anyone who loves spicy food! Try this if you dare!"),
("Samyang Hot Chicken Ramen Carbonara Multipack (5 Pcs)",
 175000,
 30,
 "https://drive.google.com/uc?export=view&id=1ooqUa5_F6240f4_et3JxZtA_0PN6Am_m",
 1,
 "The compatibility of the deep and Cheesy cream sauce and the hot original Buldak sauce is outstanding! To commemorate the sales of Buldak brand 1 billion, 'Carbonara Buldak noodle' was released and has caused a boom! In addition to the soft creamy taste of spicy Buldak it did recreate the creamy pasta taste fits the taste of Koreans."),
("Suppa Mucho Chips: Plum (1 Bag)",
 25000,
 25,
 "https://drive.google.com/uc?export=view&id=17aqVlIa0xXvI3GEqL-qwpkFiq8xghWH_",
 2,
 "Koikeya's Suppa Mucho Chips are bursting with flavor. Like an ode to the Japanese plum (ume) tree, every bite carries the floral notes of plum blossoms, the sourness of umeboshi (pickled plum), and the earthiness of shiso (perilla leaves). Hands down, this Japan-exclusive snack is the most addicting potato chip we’ve ever tried."),
("Lotus Root Chips: Plum Flavor (1 Bag)",
 25000,
 30,
 "https://drive.google.com/uc?export=view&id=1a_29Pcbvxynb3jjLMEPPEzzh5yx0YsDl",
 2,
 "Each renkon (lotus root) has been lovingly fried and peppered with sour plum and salt flavoring. Lotus root in Japanese cuisine is known for how it so easily takes on the flavors of the dishes it is featured in and for health benefits like promoting digestion. Very often, lotus root can be found in tempura dishes and this chip will be a reminder for you to order some renkon next time you go out to eat some tempura!"),
("Potato Chips: Kansai Dashi Soy Sauce (1 Bag)",
 25000,
 40,
 "https://drive.google.com/uc?export=view&id=1dyWTM0SOLVmHvfrIG_Pa8AGDZbDs1iSD",
 2,
 "These thin and crispy Japanese potato chips are flavored with Kansai-style dashi broth and soy sauce—two ingredients that add lots of umami savoriness. Dashi from the Kansai region, which includes Kyoto, is known for its more mellow flavor. Can you taste the subtle notes of kombu and bonito?"),
("Potato Chips: Hokkaido Rich Butter (1 Bag)",
 25000,
 35,
 "https://drive.google.com/uc?export=view&id=1AZpECMvY82AoOl_x7H0xlywuVsTnGX8A",
 2,
 "Potato chips are good, but a baked potato chip? These crispy, crunchy chips from Japan will wow you with their rich baked potato flavor, which comes from the addition of real Hokkaido butter, known for its high quality."),
("Jaga Choco Potato Chips (12 Cups)",
 185000,
 20,
 "https://drive.google.com/uc?export=view&id=1PevZGS5d8IPmj3W8aGUnOOcz_AymHtIl",
 2,
 "Sweet and savory are always a winning combination! These potato chips are thick and crispy. They’re fried and covered in a layer of milk chocolate that pools in the ridges of each chip, so every bite has the perfect amount of chocolate. The contrast of crunchy and smooth, salty and sweet makes them difficult to put down."),
("Pure Potato Chips: Sesame Oil + Salt (1 Bag)",
 25000,
 50,
 "https://drive.google.com/uc?export=view&id=1PB4lENfKtnl6hW56BXjxzTbArZXjamhJ",
 2,
 "These may seem like your average potato chip, but they are far from it! The addition of sesame oil provides lingering umami notes, giving these chips their unique, one-of-a-kind flavor."),
("Potato Snack: Curry Flavor (20 Packs, 60 Pieces)",
 315000,
 25,
 "https://drive.google.com/uc?export=view&id=1soJJUHytnYyTY7NT5_zSYMXtGgiOzjok",
 2,
 "Not quite a chip, these crackers are potato-based, which we think makes them a perfect courier for their spicy and aromatic curry seasoning. After all, potatoes are an essential ingredient for Japanese curry! This snack is crispy and flaky, super-savory and full of Japanese curry flavor."),
("Super Heart Chiple: Garlic (1 Bag)",
 25000,
 45,
 "https://drive.google.com/uc?export=view&id=1wXvuzX49289SntrfczU5TALMNvQLCmMv",
 2,
 "Don’t let the flames on the bag scare you off! These super light rice crackers are light on the spice, but heavy on the garlic. A dusting of paprika gives them their orange coloring and adds complexity to the powerful garlic flavor. These rice-based chips are thin and deep-fried for a bubbly, airy texture that is crisp on the outside but melts on the tongue."),
("Japanese Kit Kat: Otona no Amasa White (12 Pieces)",
 55000,
 35,
 "https://drive.google.com/uc?export=view&id=1zNtxQ3KybBVXSbyUiNNRH38XUiCHFHHD",
 3,
 "This Kit Kat is part of the Otona no Amasa 'Sweetness for Adults' line of Kit Kats, characterized by deeper flavors. For this flavor, white chocolate is the star of the show in all its creamy wonder. But you won't be able to miss the more chocolatey supporting roles: thin flecks of feuilletine add crispy texture, and there's a hidden layer of chocolate cream inside."),
("Matcha Chocolate Daifuku Mochi (13 Pieces)",
 30000,
 40,
 "https://drive.google.com/uc?export=view&id=1hVgDdBgmMpSz7_ZfddUY9ubfNifgMEFk",
 3,
 "This super soft mochi is a type of daifuku or stuffed mochi. Matcha powder is kneaded into the mochi dough, and wrapped around a silky white chocolate cream filling. Decadent and delicious!"),
("Mugikko Chocolate Barley Puffs (20 Packs)",
 155000,
 20,
 "https://drive.google.com/uc?export=view&id=1uy1fes3FG8Mu3bn-12YBE_uQx7gYsmc2",
 3,
 "Chocolate covered wheat isn’t something we see every day. Like puffed rice, puffed wheat has a nice fluffy bite to it and a hint of nuttiness from the roasting that nicely complements the dark chocolate coating. Savor them one at a time, or by the handful! However you choose to indulge, we’re sure you’ll enjoy this snack!"),
("Pocky: Almond Crush (2 Packs)",
 25000,
 50,
 "https://drive.google.com/uc?export=view&id=1J1xOOPbTz4hnYbRUKA6HouhAWz44w_o_",
 3,
 "Almond Crush Pocky is a timeless combination of smooth milk chocolate, crunchy almonds, and buttery biscuit. The crushed almonds are toasted to bring out their delicious nutty flavor, and a double layer of milk chocolate coats each stick."),
("Japanese Kit Kat: Hojicha Tea Otona No Amasa (13 Pieces)",
 125000,
 45,
 "https://drive.google.com/uc?export=view&id=1DKvL_CUQDCQbjDRQ_gQ90E8Ug-D04qsF",
 3,
 "Part of the Otona No Amasa or 'Sweetness for Adults' line of Kit Kats, this Kit Kat is less sweet than some other varieties. The white chocolate is infused with Hojicha flavor, and you can even see bits of the tea leaves mixed in! Hojicha is a roasted green tea. It has a nutty, almost caramelized flavor that is rich and flavorful."),
("Pocky: Zeitaku Almond Milk (10 Packs)",
 180000,
 35,
 "https://drive.google.com/uc?export=view&id=1vvHB4mfc0VvlbjNtzyCSu9lazpHU99wl",
 3,
 "Almond milk is more than something to add to your coffee or cereal. Glico has transformed it into a creamy, nutty chocolate coating for its latest luxury Pocky. A thick layer of almond milk chocolate coats the short almond biscuits, which have a more crumbly texture."),
("Pocky: Zeitaku Milk Chocolate (10 Packs)",
 180000,
 30,
 "https://drive.google.com/uc?export=view&id=1npA0vLNqBr6wqFER2uUuws6Ee_ZatFmT",
 3,
 "This Luxurious milk chocolate Pocky is a serious upgrade from the original chocolate flavor. The shorter biscuits feature cultured butter for added richness, and each stick boasts 3.8 times the amount of chocolate compared to typical Pocky. Chocolate lovers will melt over this premium Japanese Pocky!"),
("Shiroi Koibito White + Black (24 Pieces)",
 350000,
 20,
 "https://drive.google.com/uc?export=view&id=1wZ7Y9AWwgfp46GK1wLFqUl4F39Dh7kOo",
 3,
 "Indisputably the most famous Hokkaido snack, Shiroi Koibito is the perfect harmony of langue de chat and chocolate filling. This month we’re featuring both the white chocolate filling and the milk chocolate, each sandwiched by delicate butter cookies."),
("Funwari Meijin Mochi Puffs: Hokkaido Cheese",
 30000,
 25,
 "https://drive.google.com/uc?export=view&id=1K9qVwk37LjCQ8qo3pdbG56gwjJJJgp6h",
 4,
 "Echigo Seika uses mochi made from pounded 100% Japanese mochigome rice and a secret process to transform it into the crisp and airy texture of this cloud-like confection. The puffs are then finished with a dusting of kinako powder made by roasting soybeans grown in Hokkaido. This snack's delicate texture and sweet, nutty flavor make it wildly addicting."),
("Salt and Camembert Cheese Cracker",
 10000,
 25,
 "https://drive.google.com/uc?export=view&id=1s7PqIpOV9f2dQGujlEVNp5Vua1-N9cuu",
 4,
 "The most popular and classic product of Tokyo Milk Cheese Factory. Salt & Camembert Cookies are made with fresh Hokkaido milk and Guérande salt from France, which stuffed with camembert cheese chocolate."),
("Mini Baked Cheesecake (12 Pieces)",
 250000,
 30,
 "https://drive.google.com/uc?export=view&id=1K8jXmy9M6olrLWW0ihPnZ1BGSJ43SxJZ",
 4,
 "Who could say no to bite-sized cheesecake? Not us! This delightful cake has a layer of cheesy cream made with rich camembert between two fluffy cheesecake layers, and is rich, moist, and everything cheesecake should be!"),
("Salty Butter + Camembert Cheese Cookie (12 Pieces)",
 100000,
 10,
 "https://drive.google.com/uc?export=view&id=1Lf4MPLhoCTiLKTWEDW9dxLUbFKoFVUmM",
 4,
 "While still on the sweet side, this sandwich cookie has a sharp flavor from the camembert filling and the salted butter used in the cookie that adds a refreshing savoriness. Camembert is a popular flavor for cookies in Japan, as its flavor pairs well with sweets. This cookie is great with tea, but would also go well with a cheese platter."),
("Tokyo Banana Cheesecake (4 pieces)",
 120000,
 50,
 "https://drive.google.com/uc?export=view&id=1QXguTmVuThQ5BPSYO1VgT7WqM9GJaJIt",
 4,
 "Moist & Milky A doubly delicious cheesecake.Baked to perfection, with a delicate aroma that hints at the banana confiture enclosed within. Light and fluffy sponge cake with a banana custard cream filling.Light and fluffy sponge cake with a banana custard cream filling.Light and fluffy sponge cake with a banana custard cream filling."),
("Lemon and Cream Cheese Cracker",
 10000,
 35,
 "https://drive.google.com/uc?export=view&id=1GyMoPscoo96XLD6P80A-mwj87tfdrSiI",
 4,
 "Moist & Milky A doubly delicious cheesecake.Baked to perfection, with a delicate aroma that hints at the banana confiture enclosed within. Light and fluffy sponge cake with a banana custard cream filling.Light and fluffy sponge cake with a banana custard cream filling.Light and fluffy sponge cake with a banana custard cream filling."),
("Honey and Gorgonzola Cheese Cracker",
 10000,
 25,
 "https://drive.google.com/uc?export=view&id=1X-3IUYnMoIek6CX8QhEkHwyyeVa_CRS2",
 4,
 "This is artisanal maker Tokyo Milk Cheese Factory's bestselling snack for women in Japan! Tokyo Milk Cheese Factory insists on high-quality ingredients for all of their snacks. This Honey and Gorgonzola Langue de Chat has biscuits made with milk from Biei, Hokkaido(a heritage village!), granulated sugar Hokkaido, and is infused with Spanish rosemary honey."),
("Hot Kid Want Want Senbei Cheese Flavour 108gr",
 25000,
 25,
 "https://drive.google.com/uc?export=view&id=1vmYdZ3HSzl2md12tw3ougsHDKH1U5pOE",
 4,
 "Taiwanese food brand Want Want’s Hot-Kid Fried Senbei is Japanese style rice crackers in 155g packets. Senbei rice crackers come in different shapes, appearances, sizes and flavours including sweet and savoury."),
("Sakura Matcha (20 g)",
 100000,
 20,
 "https://drive.google.com/uc?export=view&id=1OPVGLwPKrixvoo3OCKRm5TttMHleYac9",
 5, "This drink is great for matcha lovers looking to try something new. Sakuraba (cherry blossom leaf) powder is mixed with Japanese matcha for a faintly floral aroma. Sakura leaves have a wonderful cherry blossom flavor and the green color blends naturally with the matcha powder. Transport yourself beneath the sakura trees with this delicious spring drink."),
("Sweet Sakura Tea (4 Sachets)",
 75000,
 20,
 "https://drive.google.com/uc?export=view&id=1orCwmlJ-tdjcGfFWvqnTLeYxsU8VsGxD",
 5, "Sweet Sakura Tea is a beautiful Japanese herbal tea that blooms in the water. Lots of effort went into developing this tea to preserve the beauty and flavor of the sakura. The flowers can only be harvested once a year, right before they bloom to ensure they have the strongest scent. Sweet Sakura Tea is a beautiful Japanese herbal tea that blooms in the water. Lots of effort went into developing this tea to preserve the beauty and flavor of the sakura. The flowers can only be harvested once a year, right before they bloom to ensure they have the strongest scent."),
("Uji Matcha Au Lait (5 Sticks)",
 130000,
 10,
 "https://drive.google.com/uc?export=view&id=1Saz11tWVfaHGLFmgOfYCk6sdSFFj4ZVG",
 5, "Traditional matcha from Uji, Kyoto is known by tea aficionados as some of the richest green tea in the world. This matcha has a modern twist to make a creamy cup of matcha au lait instantly!"),
("Hoshino Hojicha Latte (7 Sticks)",
 150000,
 15,
 "https://drive.google.com/uc?export=view&id=1tsAU-sllbrYviO3P0ZhYqn-QyjOkgRZc",
 5, "A shift from the more commonly known hojicha, we bring to you Hoshino Hojicha Latte, an instant latte that can be enjoyed both hot or cold. An ideal progression for hojicha due to its nutty, caramel flavor, grab a cup to enjoy and keep you warm this winter!"),
("Banana Milk",
 35000,
 50,
 "https://drive.google.com/uc?export=view&id=1AOmM0cxtk7uKf7X-LrgxV9R1jLLhUTYh",
 5, "Binggrae's Banana-flavored milk is national's favorite No.1 selling Banana milk brand in Korea. Binggrae gives the taste full of nutrients while tasting like authentic banana."),
("88th Night Green Tea (10 Tea Bags)",
 135000,
 30,
 "https://drive.google.com/uc?export=view&id=1i2ffRsMBMFdBuFkSM6NUDZzzcwiHsavV",
 5, "88th Night Greet Tea gets its name from its traditional date of harvest: 88 nights after the Japanese Lunar New Year. This poetic tradition signals the start of the tea harvest, and so 88th Night tea is always classified as ichibancha, or first-flush. It is typically hand-picked with great care and has a fresh, vegetal flavor with a sweet aroma."),
("Ginger and Yuzu Herbal Tea (10 Sticks)",
 95000,
 40,
 "https://drive.google.com/uc?export=view&id=1RZwEAZO0dVPRHNAvgyIBy1ig0hG_Ex4e",
 5, "Warming ginger and refreshing yuzu make a wonderful summer beverage. This herbal powder is enjoyable in an instant. We recommend enjoying this one cold on a hot summer day, but it would also be great hot if it’s chilly where you are."),
("Sencha Tea (1 Bag)",
 12000,
 50,
 "https://drive.google.com/uc?export=view&id=1IqCWe1KpMUoWVBRLJTxFimtxoDZKiIh_",
 5, "Sencha is a traditional steamed green tea of Japan and beloved for the fresh taste it carries. It’s the perfect choice to enjoy with all foods, sweet or savory."),
("Natural Yeast Bread: Hokkaido Cream",
 45000,
 40,
 "https://drive.google.com/uc?export=view&id=1WPIULeCUYJaa-awv-9J-TBr0QZyVhUP7",
 6, "Open up this bag to the smell of freshly-baked sweet cream bread. The moment you tear into this bread, you’ll find yourself diving face-first to get the fullest experience of the abundant softness. Deliciously fluffy, this snack is layered with cream from the Tokachi district of Hokkaido."),
("Koganeimo Golden Sweet Potato Cake",
 30000,
 30,
 "https://drive.google.com/uc?export=view&id=1vsM1S3LWV_OpF0AJN5KA3VpBKBbuL6FN",
 6, "As you open the package, let the buttery sweet aroma of sweet potato greet you. It’s made with the Naruto Kintoki sweet potato, which has bright purple skin and golden interior and is known for its rich natural flavor. The natural sweetness of this sweet potato cake is deliciously complemented by hints of cinnamon and rum."),
("Shinshu Apple Rabbit Manju (20 Pieces)",
 200000,
 20,
 "https://drive.google.com/uc?export=view&id=1h8c0Har-Hcg2Rb7vMi8ofLaYN9EAGukR",
 6, "This cute manju is filled with Shinshu apple flavored white bean paste. Tasty flavorful, and bunny-shaped, what's not to love? The Shinshu region, now known as Nagano Prefecture, is famous for its apples. Shinshu apples are sweet and juicy, great for infusing natural apple flavor."),
("Amaou Strawberry Kirara Sandwich Cookie (18 Pieces)",
 230000,
 12,
 "https://drive.google.com/uc?export=view&id=1HQslpk79YlmF9Pe1DwRaKM8yBjLnPnQx",
 6, "Two crisp, pink strawberry cookies sandwich a lush layer of fluffy strawberry cream that has crunchy corn flakes and bits of freeze-dried Amaou strawberries. Amaou strawberries are known as the 'king of sweet' and are grown exclusively in Kyushu."),
("Kyoto Matcha Waffle Sandwich (12 Pieces)"	,
 100000,
 10,
 "https://drive.google.com/uc?export=view&id=1Zfwfss0HHZZMl_73PsA2SYTvQVKxqw9a",
 6, "The best kind of cookie is the one baked into the shape of a waffle—and who doesn’t need more waffles in their lives? More than just the perfect waffle, the outside cookie is crisp and perfectly golden, while between the two layers is a smooth white chocolate and matcha cream, with matcha from Kyoto."),
("Seaweed Tempura: Setouchi Sudachi Citrus Flavor (1 Bag)",
 45000,
 30,
 "https://drive.google.com/uc?export=view&id=1RilAkFvSEAaPbfK2yUewq2CUEJYW_B8E",
 6, "Elevating the humble seaweed to a snack that packs a punch with the tart taste of the sudachi citrus fruit, these addictive seaweed sheets are battered, fried, and flavored to create a crisp and tangy snack. The sudachi fruit is a small green citrus native to Japan that is frequently used as a flavoring in place of lemon or lime."),
("Takoyaki Tei Corn Puffs (1 Bag)",
 35000,
 35,
 "https://drive.google.com/uc?export=view&id=1-iPE5Warj8tjot90Ba31kVsnPRGwJzQZ",
 6, "Takoyaki is a classic Japanese street food made by pan-frying batter in a specially-shaped pan to form little fried balls with tako (octopus) in the center. It’s often topped with a variety of flavorful toppings. These light corn puffs are the perfect balance of sweet and savory umami-rich flavor."),
("Candied Yuzu Peel (1 Bag)",
 20000,
 30,
 "https://drive.google.com/uc?export=view&id=1t2j9y7sb9GAKPORi2XhianrQlFqpDK7j",
 6, "While recently growing in popularity around the world, yuzu has been a favorite in Japan for centuries. It’s rarely eaten alone, so this treat is that much more special for elevating our precious yuzu into something fantastically chewy and tart! Don’t worry if you think these candied peels might be too sour since the candying process brings out the yuzu’s natural sweetness.");


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


