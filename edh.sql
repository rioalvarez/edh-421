-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versi server:                 8.4.3 - MySQL Community Server - GPL
-- OS Server:                    Win64
-- HeidiSQL Versi:               12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Membuang struktur basisdata untuk kaido_kit
CREATE DATABASE IF NOT EXISTS `kaido_kit` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `kaido_kit`;

-- membuang struktur untuk table kaido_kit.articles
CREATE TABLE IF NOT EXISTS `articles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `author_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `published_at` timestamp NULL DEFAULT NULL,
  `featured_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `views` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `category_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `articles_slug_unique` (`slug`),
  KEY `articles_user_id_foreign` (`user_id`),
  KEY `articles_category_id_foreign` (`category_id`),
  KEY `articles_status_index` (`status`),
  KEY `articles_published_at_index` (`published_at`),
  KEY `articles_views_index` (`views`),
  KEY `articles_status_published_at_index` (`status`,`published_at`),
  CONSTRAINT `articles_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `articles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.articles: ~3 rows (lebih kurang)
DELETE FROM `articles`;
INSERT INTO `articles` (`id`, `user_id`, `title`, `slug`, `author_name`, `content`, `category`, `status`, `published_at`, `featured_image`, `views`, `created_at`, `updated_at`, `category_id`) VALUES
	(1, NULL, 'Repellendus velit ducimus quae sed sit impedit officia.', 'repellendus-velit-ducimus-quae-sed-sit-impedit-officia', 'Miss Cayla Simonis', 'Modi qui necessitatibus qui similique et qui excepturi. Doloribus similique iste modi dolore ut nulla. Animi voluptatibus asperiores adipisci. Nam aut optio quis ex ad.\n\nQuasi aut quae optio ea ut aliquam fuga. Hic quia architecto officia quo.\n\nHarum quaerat impedit ut laborum itaque quo aut. Veritatis nemo dicta officia sed. Autem voluptatum quo necessitatibus eveniet asperiores laudantium dolorem. Voluptatum sequi repellat atque.\n\nExercitationem veniam et deserunt iure accusamus numquam. Sit earum praesentium dignissimos ut omnis quas quia rerum. Voluptate doloremque magni magnam commodi dolores.', 'tutorial', 'published', '2025-08-19 06:07:42', NULL, 749, '2026-01-06 20:23:51', '2026-01-07 21:46:15', NULL),
	(2, NULL, 'Architecto quo ratione dicta vitae.', 'architecto-quo-ratione-dicta-vitae', 'Alva Gaylord II', 'Unde quae dolores aut aut quia omnis. Est dolores et voluptates odio. Non pariatur neque consectetur architecto. Cupiditate distinctio perspiciatis quasi totam repellendus voluptas.\n\nNon numquam eos modi sed. Vero nesciunt possimus qui aut iste facilis necessitatibus. Sed quod doloremque itaque tempora velit.\n\nEt atque molestiae optio in et officia. Quia quis nihil distinctio recusandae. Sed quam natus iste sit. Nostrum cum et est molestiae voluptas impedit corporis.\n\nNostrum hic distinctio sunt quisquam et voluptatem et. Omnis veritatis voluptatem ducimus quam excepturi soluta nesciunt. Facere vel non rem voluptatem ad ut omnis.\n\nVoluptas sed reprehenderit voluptatem rerum cupiditate maxime ipsa. Rem perspiciatis ut odit vero. Maxime sed qui voluptas quia nihil iste est. Quas et inventore similique.\n\nEt reprehenderit ea culpa numquam molestias est. Sed earum odit ut aliquid quas laborum dolore. Dolor possimus ullam veniam sed maxime.', 'troubleshooting', 'published', '2025-08-20 22:38:26', NULL, 894, '2026-01-06 20:23:51', '2026-01-07 21:45:31', NULL),
	(3, 11, 'Autem et culpa aliquam exercitationem et.', 'autem-et-culpa-aliquam-exercitationem-et', 'Ms. Anabel Bernhard PhD', 'Eos vero et iusto et. Quasi exercitationem sunt qui quia quae minima. A omnis fugiat incidunt necessitatibus. Ab optio eum beatae culpa libero asperiores incidunt laborum.\n\nAut aut quam qui nisi. Qui nulla qui vel nostrum fugit. Culpa atque quo voluptatem tenetur.\n\nEx ipsa porro impedit quidem. Iste ut et omnis aperiam qui et dolores natus. Non porro voluptatem est officiis quidem excepturi nostrum voluptate.\n\nId illo laborum earum id pariatur. Ipsa ut qui quae assumenda nam quos. A fugit quia quia quibusdam perspiciatis.\n\nIusto et quae beatae labore quo quae cupiditate quod. Necessitatibus nihil omnis hic eos assumenda. Sed aut dolores quas a ea.\n\nNon hic labore maxime occaecati omnis eligendi ea. Repudiandae hic molestias ea adipisci.\n\nEius quis ex deserunt vitae aliquam sunt deleniti. Sunt saepe eos qui. Doloremque ipsum neque error modi rerum numquam dolore.\n\nNostrum blanditiis ea impedit. Eos veritatis facere perspiciatis velit et voluptatem. Et deleniti quae nemo et. Vel et perferendis repellendus facere.', 'tutorial', 'published', '2025-03-25 07:47:52', NULL, 510, '2026-01-06 20:23:51', '2026-01-06 20:23:51', NULL),
	(4, NULL, 'Cupiditate id laboriosam delectus aliquid repellendus sit.', 'cupiditate-id-laboriosam-delectus-aliquid-repellendus-sit', 'Florian Fritsch', 'Ut excepturi aut recusandae et. Ipsam excepturi est numquam consectetur sit. Officia qui qui minus.\n\nIncidunt numquam impedit tempora ea. Rerum rerum pariatur minus nesciunt occaecati. Ut eum sequi explicabo rem ipsum est ea est. Qui voluptatem ut eum voluptas.\n\nHarum est asperiores et earum tenetur qui molestias. Ut explicabo aut tempore asperiores suscipit. In ratione quo vel error vero enim quia quae.', 'troubleshooting', 'published', '2025-05-27 06:35:10', NULL, 869, '2026-01-06 20:23:51', '2026-01-06 20:23:51', NULL),
	(5, NULL, 'Maxime consequatur maxime ut error.', 'maxime-consequatur-maxime-ut-error', 'Lexus Watsica', 'Est iste laborum ipsa doloribus nostrum quisquam inventore. Ratione veniam et repellendus quisquam. Facere quo nulla in tenetur commodi eligendi cumque impedit.\n\nDeserunt velit sed quod et. Tempora unde alias reprehenderit consectetur. Soluta quisquam est asperiores itaque nobis. Laborum maiores sit placeat nulla quos unde quibusdam suscipit.\n\nOptio rerum asperiores commodi adipisci eligendi quasi. Non et iste quos accusantium rerum ullam iste minima. Veniam nobis est natus. Totam possimus ducimus reprehenderit non est tempore aut.\n\nAnimi sunt quae quibusdam qui omnis veniam aliquid. Quas quis eos tenetur eum non tempora. Ipsum et sit nihil qui repellat saepe nesciunt. Corrupti illo facere eius voluptatem eaque.\n\nDicta nam eveniet nihil omnis earum nisi. Eos voluptas non eligendi quo velit ut non aliquid. Atque quis nam corrupti sit.\n\nExplicabo quia qui voluptates ut veniam. Laborum quibusdam voluptatum libero odio et. Porro velit ratione aut quia. Et iure aliquid cupiditate animi eos.\n\nUt quasi repellat reiciendis autem cumque autem nostrum ullam. Eaque veritatis blanditiis veritatis voluptatem. Provident architecto est incidunt recusandae ullam. Sit natus quaerat consectetur nihil.\n\nVoluptatem voluptatem ea voluptate maxime. Odio nisi dicta itaque iste. Repellat exercitationem et doloribus ipsum ullam hic et.', 'tutorial', 'published', '2025-05-31 06:25:28', NULL, 770, '2026-01-06 20:23:51', '2026-01-06 20:23:51', NULL),
	(6, NULL, 'Recusandae aut sapiente.', 'recusandae-aut-sapiente', 'Beatrice Grant', 'Ea eveniet eos provident reprehenderit. Sed ad omnis et earum sunt odit. A dolorem odio nobis labore et alias. Error aut ipsam aut non et.\n\nOmnis sequi dignissimos iste qui vero. Vel labore numquam non quia soluta maxime. Consequatur maxime eum porro necessitatibus natus. Eum reiciendis non sint sunt qui corporis.\n\nId cupiditate magnam iste cumque. Eos dolorum facere eveniet. Distinctio praesentium incidunt ea tenetur veritatis cupiditate dolorem.\n\nTempora dicta perspiciatis aut tenetur itaque quo dolor. Laudantium sed repellat id rerum esse voluptatum.\n\nRerum a sunt ipsa quidem dolores nemo voluptas. Sed sint voluptates et. Fugit harum accusamus sapiente explicabo minus tempore possimus. Suscipit similique dolor enim similique.', 'tutorial', 'draft', NULL, NULL, 584, '2026-01-06 20:23:51', '2026-01-06 20:23:51', NULL),
	(7, NULL, 'Architecto id pariatur.', 'architecto-id-pariatur', 'Miss Lauren Kohler', 'Cupiditate fugit consequatur voluptatem voluptates sed cupiditate vel. Praesentium sint commodi exercitationem nemo. Eum occaecati dolor blanditiis omnis quam. Qui omnis rem iusto magni consequuntur.\n\nLaboriosam nihil voluptatibus omnis ullam vitae cum autem. Qui voluptas dolorem optio ut autem nihil sit.\n\nEum alias autem atque nisi quas aliquam. Explicabo assumenda consectetur nemo doloremque. Delectus officia autem omnis et earum eligendi.\n\nOmnis itaque odit est enim. Magnam nostrum animi autem et dolorem consectetur eveniet. Reprehenderit dolore aliquam accusantium quia a maiores fugiat ut.\n\nNihil laudantium expedita eum. Amet explicabo perferendis consequatur. Impedit cum consectetur omnis. Omnis incidunt impedit quo animi deserunt quo delectus.\n\nUt ea est corporis modi est placeat culpa. Qui et qui voluptas eveniet officiis. Veniam magnam id distinctio sit.\n\nEius dolorem voluptate ratione est repellat sunt expedita. Minus fugiat dignissimos eaque modi aspernatur libero et. Doloremque veniam placeat veritatis error. Harum quas reiciendis sunt neque.\n\nOmnis nesciunt odit voluptatibus vitae et vel. Ut a doloremque sunt ratione. Temporibus sed repudiandae accusantium.', 'news', 'draft', NULL, NULL, 840, '2026-01-06 20:23:51', '2026-01-06 20:23:51', NULL),
	(8, NULL, 'Sit voluptatem rerum maxime est.', 'sit-voluptatem-rerum-maxime-est', 'Eduardo Schowalter', 'Quaerat aut assumenda quis omnis quia. Adipisci eaque doloremque doloremque id dolores est. Ad dolores sunt voluptatum rerum. Ut similique quidem ut sit tempora.\n\nCulpa eius qui velit veniam voluptatem. Eaque dolore deserunt cumque rerum. Voluptatem voluptate illum et magni autem saepe. Veniam sapiente voluptatem pariatur sequi.\n\nDignissimos consectetur quam deserunt itaque qui facere excepturi. Quis quisquam tempore cupiditate corrupti in et. Cupiditate nam rerum eos quia et id. Sapiente nemo et a est hic quasi quas voluptas.\n\nPerferendis et unde porro. Iste et eum voluptas ut aut. Id fugiat amet porro facilis voluptas ut.\n\nRepellat dolorem ipsum omnis dolorem quo. Rem laborum quo id totam eveniet. Consequatur illo explicabo sit maiores corrupti.\n\nEt et vel quae. Iste vero quo suscipit praesentium quaerat voluptate dolor. Ad voluptas ipsa distinctio et est quia.', 'tips-tricks', 'draft', NULL, NULL, 65, '2026-01-06 20:23:51', '2026-01-06 20:23:51', NULL),
	(9, NULL, 'Hic facere delectus molestiae et suscipit et dolorum.', 'hic-facere-delectus-molestiae-et-suscipit-et-dolorum', 'Araceli Koepp', 'Quos impedit fuga nulla sunt. Repudiandae est id maiores voluptas non aut. Corporis numquam praesentium quasi deserunt. Sapiente fugiat atque repudiandae placeat vel quia sit.\n\nMollitia odit incidunt nihil odit beatae ut perspiciatis. Asperiores vero itaque ducimus a unde autem minus. Incidunt animi tempora repellendus doloribus aspernatur.\n\nNon suscipit vero sunt beatae quis sint dignissimos. Voluptatem labore rem enim itaque neque quaerat nemo non. Consequatur quos autem cum aut quia voluptatem facere. Fuga qui qui dignissimos quia accusantium. Voluptas impedit beatae deserunt eum sed.\n\nVoluptate incidunt in repellat minus ea. Quam expedita labore sint qui. Et et dolor sed. Maxime natus eaque atque adipisci.\n\nMinima consequatur est et aliquam numquam in non. Minima quod eaque et necessitatibus consequuntur est. Voluptates omnis rem minus voluptatem nesciunt perspiciatis omnis. Commodi expedita blanditiis eos aperiam.\n\nRatione accusamus aut iure et. Minus iusto sunt nobis nesciunt tempora. Ut ipsum qui illo esse quae architecto. Ad aut sint totam voluptatem non tempora.', 'tutorial', 'archived', '2025-12-17 22:26:40', NULL, 405, '2026-01-06 20:23:51', '2026-01-06 20:23:51', NULL),
	(10, NULL, 'Possimus velit error sequi et perspiciatis suscipit omnis a voluptate.', 'possimus-velit-error-sequi-et-perspiciatis-suscipit-omnis-a-voluptate', 'Waylon O\'Keefe', 'Nesciunt ex omnis error eligendi repellat suscipit voluptas. Explicabo ad quos illo voluptatum. Atque fuga provident excepturi sit id consequatur eligendi. Id doloremque fugiat maiores corporis est nemo qui adipisci.\n\nVel porro quia maxime eaque. Nihil rem nostrum non vitae earum et dolores. Animi ut est voluptatem.\n\nNatus nobis ut vero est sapiente saepe. Nesciunt et tempora necessitatibus esse veritatis. Nesciunt adipisci nulla necessitatibus recusandae dolor nesciunt aut. Repellat est ipsa minus eum ab.\n\nEst nam aut unde assumenda excepturi. Consequuntur ullam et qui id voluptas est. Consequuntur officiis sunt quibusdam eum excepturi quia animi non. Fugiat aut est doloremque tempore.\n\nNecessitatibus quae nemo quos numquam perferendis voluptatem inventore possimus. Cumque quia quibusdam voluptatem iure ut. Perferendis qui qui rem dolores ut veritatis eveniet.\n\nSed recusandae blanditiis rerum dolorum sunt similique quam. Harum perspiciatis debitis ut praesentium velit quaerat non aut. Quia nam doloremque aut voluptates et ut laborum quia.', 'news', 'archived', '2025-12-23 20:37:46', NULL, 82, '2026-01-06 20:23:51', '2026-01-06 20:23:51', NULL);

-- membuang struktur untuk table kaido_kit.breezy_sessions
CREATE TABLE IF NOT EXISTS `breezy_sessions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `authenticatable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `authenticatable_id` bigint unsigned NOT NULL,
  `panel_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guard` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `expires_at` timestamp NULL DEFAULT NULL,
  `two_factor_secret` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `two_factor_recovery_codes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `breezy_sessions_authenticatable_type_authenticatable_id_index` (`authenticatable_type`,`authenticatable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.breezy_sessions: ~0 rows (lebih kurang)
DELETE FROM `breezy_sessions`;

-- membuang struktur untuk table kaido_kit.cache
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.cache: ~5 rows (lebih kurang)
DELETE FROM `cache`;
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
	('17ba0791499db908433b80f37c5fbc89b870084b', 'i:1;', 1767847725),
	('17ba0791499db908433b80f37c5fbc89b870084b:timer', 'i:1767847725;', 1767847725),
	('livewire-rate-limiter:59d6ad626907b5a0341aba51c3754cd265bffec5', 'i:1;', 1768718620),
	('livewire-rate-limiter:59d6ad626907b5a0341aba51c3754cd265bffec5:timer', 'i:1768718620;', 1768718620),
	('spatie.permission.cache', 'a:3:{s:5:"alias";a:4:{s:1:"a";s:2:"id";s:1:"b";s:4:"name";s:1:"c";s:10:"guard_name";s:1:"r";s:5:"roles";}s:11:"permissions";a:102:{i:0;a:4:{s:1:"a";i:1;s:1:"b";s:12:"view_article";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:1;a:4:{s:1:"a";i:2;s:1:"b";s:16:"view_any_article";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:2;a:4:{s:1:"a";i:3;s:1:"b";s:14:"create_article";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:3;a:4:{s:1:"a";i:4;s:1:"b";s:14:"update_article";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:4;a:4:{s:1:"a";i:5;s:1:"b";s:15:"restore_article";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:5;a:4:{s:1:"a";i:6;s:1:"b";s:19:"restore_any_article";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:6;a:4:{s:1:"a";i:7;s:1:"b";s:17:"replicate_article";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:7;a:4:{s:1:"a";i:8;s:1:"b";s:15:"reorder_article";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:8;a:4:{s:1:"a";i:9;s:1:"b";s:14:"delete_article";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:9;a:4:{s:1:"a";i:10;s:1:"b";s:18:"delete_any_article";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:10;a:4:{s:1:"a";i:11;s:1:"b";s:20:"force_delete_article";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:11;a:4:{s:1:"a";i:12;s:1:"b";s:24:"force_delete_any_article";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:12;a:4:{s:1:"a";i:13;s:1:"b";s:22:"article:create_article";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:13;a:4:{s:1:"a";i:14;s:1:"b";s:22:"article:update_article";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:14;a:4:{s:1:"a";i:15;s:1:"b";s:22:"article:delete_article";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:15;a:4:{s:1:"a";i:16;s:1:"b";s:26:"article:pagination_article";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:16;a:4:{s:1:"a";i:17;s:1:"b";s:22:"article:detail_article";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:17;a:4:{s:1:"a";i:18;s:1:"b";s:13:"view_category";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:18;a:4:{s:1:"a";i:19;s:1:"b";s:17:"view_any_category";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:19;a:4:{s:1:"a";i:20;s:1:"b";s:15:"create_category";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:20;a:4:{s:1:"a";i:21;s:1:"b";s:15:"update_category";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:21;a:4:{s:1:"a";i:22;s:1:"b";s:16:"restore_category";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:22;a:4:{s:1:"a";i:23;s:1:"b";s:20:"restore_any_category";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:23;a:4:{s:1:"a";i:24;s:1:"b";s:18:"replicate_category";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:24;a:4:{s:1:"a";i:25;s:1:"b";s:16:"reorder_category";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:25;a:4:{s:1:"a";i:26;s:1:"b";s:15:"delete_category";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:26;a:4:{s:1:"a";i:27;s:1:"b";s:19:"delete_any_category";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:27;a:4:{s:1:"a";i:28;s:1:"b";s:21:"force_delete_category";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:28;a:4:{s:1:"a";i:29;s:1:"b";s:25:"force_delete_any_category";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:29;a:4:{s:1:"a";i:30;s:1:"b";s:11:"view_device";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:30;a:4:{s:1:"a";i:31;s:1:"b";s:15:"view_any_device";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:31;a:4:{s:1:"a";i:32;s:1:"b";s:13:"create_device";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:32;a:4:{s:1:"a";i:33;s:1:"b";s:13:"update_device";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:33;a:4:{s:1:"a";i:34;s:1:"b";s:13:"delete_device";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:34;a:4:{s:1:"a";i:35;s:1:"b";s:17:"delete_any_device";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:35;a:4:{s:1:"a";i:36;s:1:"b";s:22:"view_device::attribute";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:36;a:4:{s:1:"a";i:37;s:1:"b";s:26:"view_any_device::attribute";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:37;a:4:{s:1:"a";i:38;s:1:"b";s:24:"create_device::attribute";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:38;a:4:{s:1:"a";i:39;s:1:"b";s:24:"update_device::attribute";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:39;a:4:{s:1:"a";i:40;s:1:"b";s:24:"delete_device::attribute";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:40;a:4:{s:1:"a";i:41;s:1:"b";s:28:"delete_any_device::attribute";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:41;a:4:{s:1:"a";i:42;s:1:"b";s:9:"view_role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:42;a:4:{s:1:"a";i:43;s:1:"b";s:13:"view_any_role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:43;a:4:{s:1:"a";i:44;s:1:"b";s:11:"create_role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:44;a:4:{s:1:"a";i:45;s:1:"b";s:11:"update_role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:45;a:4:{s:1:"a";i:46;s:1:"b";s:11:"delete_role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:46;a:4:{s:1:"a";i:47;s:1:"b";s:15:"delete_any_role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:47;a:4:{s:1:"a";i:48;s:1:"b";s:11:"view_ticket";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:48;a:4:{s:1:"a";i:49;s:1:"b";s:15:"view_any_ticket";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:49;a:4:{s:1:"a";i:50;s:1:"b";s:13:"create_ticket";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:50;a:4:{s:1:"a";i:51;s:1:"b";s:13:"update_ticket";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:51;a:4:{s:1:"a";i:52;s:1:"b";s:13:"delete_ticket";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:52;a:4:{s:1:"a";i:53;s:1:"b";s:17:"delete_any_ticket";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:53;a:4:{s:1:"a";i:54;s:1:"b";s:13:"assign_ticket";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:54;a:4:{s:1:"a";i:55;s:1:"b";s:14:"resolve_ticket";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:55;a:4:{s:1:"a";i:56;s:1:"b";s:10:"view_token";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:56;a:4:{s:1:"a";i:57;s:1:"b";s:14:"view_any_token";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:57;a:4:{s:1:"a";i:58;s:1:"b";s:12:"create_token";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:58;a:4:{s:1:"a";i:59;s:1:"b";s:12:"update_token";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:59;a:4:{s:1:"a";i:60;s:1:"b";s:13:"restore_token";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:60;a:4:{s:1:"a";i:61;s:1:"b";s:17:"restore_any_token";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:61;a:4:{s:1:"a";i:62;s:1:"b";s:15:"replicate_token";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:62;a:4:{s:1:"a";i:63;s:1:"b";s:13:"reorder_token";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:63;a:4:{s:1:"a";i:64;s:1:"b";s:12:"delete_token";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:64;a:4:{s:1:"a";i:65;s:1:"b";s:16:"delete_any_token";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:65;a:4:{s:1:"a";i:66;s:1:"b";s:18:"force_delete_token";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:66;a:4:{s:1:"a";i:67;s:1:"b";s:22:"force_delete_any_token";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:67;a:4:{s:1:"a";i:68;s:1:"b";s:9:"view_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:68;a:4:{s:1:"a";i:69;s:1:"b";s:13:"view_any_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:69;a:4:{s:1:"a";i:70;s:1:"b";s:11:"create_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:70;a:4:{s:1:"a";i:71;s:1:"b";s:11:"update_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:71;a:4:{s:1:"a";i:72;s:1:"b";s:12:"restore_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:72;a:4:{s:1:"a";i:73;s:1:"b";s:16:"restore_any_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:73;a:4:{s:1:"a";i:74;s:1:"b";s:14:"replicate_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:74;a:4:{s:1:"a";i:75;s:1:"b";s:12:"reorder_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:75;a:4:{s:1:"a";i:76;s:1:"b";s:11:"delete_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:76;a:4:{s:1:"a";i:77;s:1:"b";s:15:"delete_any_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:77;a:4:{s:1:"a";i:78;s:1:"b";s:17:"force_delete_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:78;a:4:{s:1:"a";i:79;s:1:"b";s:21:"force_delete_any_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:79;a:4:{s:1:"a";i:80;s:1:"b";s:12:"view_vehicle";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:80;a:4:{s:1:"a";i:81;s:1:"b";s:16:"view_any_vehicle";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:81;a:4:{s:1:"a";i:82;s:1:"b";s:14:"create_vehicle";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:82;a:4:{s:1:"a";i:83;s:1:"b";s:14:"update_vehicle";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:83;a:4:{s:1:"a";i:84;s:1:"b";s:14:"delete_vehicle";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:84;a:4:{s:1:"a";i:85;s:1:"b";s:18:"delete_any_vehicle";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:85;a:4:{s:1:"a";i:86;s:1:"b";s:21:"view_vehicle::booking";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:86;a:4:{s:1:"a";i:87;s:1:"b";s:25:"view_any_vehicle::booking";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:87;a:4:{s:1:"a";i:88;s:1:"b";s:23:"create_vehicle::booking";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:88;a:4:{s:1:"a";i:89;s:1:"b";s:23:"update_vehicle::booking";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:89;a:4:{s:1:"a";i:90;s:1:"b";s:23:"delete_vehicle::booking";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:90;a:4:{s:1:"a";i:91;s:1:"b";s:27:"delete_any_vehicle::booking";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:91;a:4:{s:1:"a";i:92;s:1:"b";s:23:"return_vehicle::booking";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:92;a:4:{s:1:"a";i:93;s:1:"b";s:18:"page_ManageSetting";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:93;a:4:{s:1:"a";i:94;s:1:"b";s:20:"page_VehicleCalendar";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:94;a:4:{s:1:"a";i:95;s:1:"b";s:11:"page_Themes";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:95;a:4:{s:1:"a";i:96;s:1:"b";s:18:"page_MyProfilePage";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:96;a:4:{s:1:"a";i:97;s:1:"b";s:26:"widget_VehicleBookingStats";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:97;a:4:{s:1:"a";i:98;s:1:"b";s:34:"widget_VehicleAvailabilityCalendar";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:98;a:4:{s:1:"a";i:99;s:1:"b";s:23:"widget_MyActiveBookings";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:99;a:4:{s:1:"a";i:100;s:1:"b";s:24:"widget_DeviceStatsWidget";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:100;a:4:{s:1:"a";i:101;s:1:"b";s:24:"widget_TicketStatsWidget";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:101;a:4:{s:1:"a";i:102;s:1:"b";s:26:"widget_RecentTicketsWidget";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}}s:5:"roles";a:2:{i:0;a:3:{s:1:"a";i:1;s:1:"b";s:11:"super_admin";s:1:"c";s:3:"web";}i:1;a:3:{s:1:"a";i:2;s:1:"b";s:6:"Member";s:1:"c";s:3:"web";}}}', 1768804960);

-- membuang struktur untuk table kaido_kit.cache_locks
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.cache_locks: ~0 rows (lebih kurang)
DELETE FROM `cache_locks`;

-- membuang struktur untuk table kaido_kit.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.categories: ~0 rows (lebih kurang)
DELETE FROM `categories`;

-- membuang struktur untuk table kaido_kit.contacts
CREATE TABLE IF NOT EXISTS `contacts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.contacts: ~10 rows (lebih kurang)
DELETE FROM `contacts`;
INSERT INTO `contacts` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'Dr. Oswald Kozey', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(2, 'Mrs. Chanel Harber', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(3, 'Dan Hill', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(4, 'Vilma Schultz', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(5, 'Moshe Cartwright IV', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(6, 'Lindsay Kulas II', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(7, 'Claudie Kihn', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(8, 'Geovanny Pacocha', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(9, 'Merritt Armstrong', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(10, 'Miss Estel Doyle DDS', '2026-01-06 20:23:51', '2026-01-06 20:23:51');

-- membuang struktur untuk table kaido_kit.devices
CREATE TABLE IF NOT EXISTS `devices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `type` enum('laptop','desktop','all-in-one','workstation') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'desktop',
  `hostname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mac_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `os_version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `processor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ram` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `storage_type` enum('SSD','HDD','NVMe','Hybrid') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `storage_capacity` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `warranty_expiry` date DEFAULT NULL,
  `condition` enum('excellent','good','fair','poor','broken') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'good',
  `status` enum('active','inactive','maintenance','retired') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `asset_tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `devices_serial_number_unique` (`serial_number`),
  UNIQUE KEY `devices_asset_tag_unique` (`asset_tag`),
  KEY `devices_user_id_foreign` (`user_id`),
  KEY `devices_status_index` (`status`),
  KEY `devices_condition_index` (`condition`),
  KEY `devices_type_index` (`type`),
  KEY `devices_location_index` (`location`),
  CONSTRAINT `devices_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.devices: ~2 rows (lebih kurang)
DELETE FROM `devices`;
INSERT INTO `devices` (`id`, `user_id`, `type`, `hostname`, `ip_address`, `mac_address`, `os`, `os_version`, `processor`, `ram`, `storage_type`, `storage_capacity`, `brand`, `model`, `serial_number`, `purchase_date`, `warranty_expiry`, `condition`, `status`, `notes`, `location`, `asset_tag`, `created_at`, `updated_at`) VALUES
	(1, 11, 'desktop', 'PC150421PKD99', '10.9.1.203', NULL, 'Windows', 'Windows 11', NULL, NULL, 'SSD', NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, NULL),
	(2, NULL, 'desktop', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, NULL);

-- membuang struktur untuk table kaido_kit.device_attributes
CREATE TABLE IF NOT EXISTS `device_attributes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('text','number','select','boolean','date','textarea') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text',
  `options` json DEFAULT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `device_attributes_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.device_attributes: ~0 rows (lebih kurang)
DELETE FROM `device_attributes`;

-- membuang struktur untuk table kaido_kit.device_attribute_values
CREATE TABLE IF NOT EXISTS `device_attribute_values` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `device_id` bigint unsigned NOT NULL,
  `device_attribute_id` bigint unsigned NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `device_attribute_values_device_id_device_attribute_id_unique` (`device_id`,`device_attribute_id`),
  KEY `device_attribute_values_device_attribute_id_foreign` (`device_attribute_id`),
  KEY `device_attribute_values_device_id_device_attribute_id_index` (`device_id`,`device_attribute_id`),
  CONSTRAINT `device_attribute_values_device_attribute_id_foreign` FOREIGN KEY (`device_attribute_id`) REFERENCES `device_attributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `device_attribute_values_device_id_foreign` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.device_attribute_values: ~0 rows (lebih kurang)
DELETE FROM `device_attribute_values`;

-- membuang struktur untuk table kaido_kit.exports
CREATE TABLE IF NOT EXISTS `exports` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `completed_at` timestamp NULL DEFAULT NULL,
  `file_disk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exporter` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `processed_rows` int unsigned NOT NULL DEFAULT '0',
  `total_rows` int unsigned NOT NULL,
  `successful_rows` int unsigned NOT NULL DEFAULT '0',
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `exports_user_id_foreign` (`user_id`),
  CONSTRAINT `exports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.exports: ~0 rows (lebih kurang)
DELETE FROM `exports`;

-- membuang struktur untuk table kaido_kit.failed_import_rows
CREATE TABLE IF NOT EXISTS `failed_import_rows` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `data` json NOT NULL,
  `import_id` bigint unsigned NOT NULL,
  `validation_error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `failed_import_rows_import_id_foreign` (`import_id`),
  CONSTRAINT `failed_import_rows_import_id_foreign` FOREIGN KEY (`import_id`) REFERENCES `imports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.failed_import_rows: ~0 rows (lebih kurang)
DELETE FROM `failed_import_rows`;

-- membuang struktur untuk table kaido_kit.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.failed_jobs: ~0 rows (lebih kurang)
DELETE FROM `failed_jobs`;

-- membuang struktur untuk table kaido_kit.imports
CREATE TABLE IF NOT EXISTS `imports` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `completed_at` timestamp NULL DEFAULT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `importer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `processed_rows` int unsigned NOT NULL DEFAULT '0',
  `total_rows` int unsigned NOT NULL,
  `successful_rows` int unsigned NOT NULL DEFAULT '0',
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `imports_user_id_foreign` (`user_id`),
  CONSTRAINT `imports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.imports: ~0 rows (lebih kurang)
DELETE FROM `imports`;
INSERT INTO `imports` (`id`, `completed_at`, `file_name`, `file_path`, `importer`, `processed_rows`, `total_rows`, `successful_rows`, `user_id`, `created_at`, `updated_at`) VALUES
	(1, '2026-01-06 20:43:24', 'import_users.csv', 'A:\\proyek_magang\\proyek_magang\\storage\\app/private\\livewire-tmp/pNIUKexms46PYvQtYOrRqZcCN0J8Ub-metaaW1wb3J0X3VzZXJzLmNzdg==-.csv', 'App\\Filament\\Imports\\UserImporter', 113, 113, 113, 11, '2026-01-06 20:42:55', '2026-01-06 20:43:24');

-- membuang struktur untuk table kaido_kit.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.jobs: ~0 rows (lebih kurang)
DELETE FROM `jobs`;

-- membuang struktur untuk table kaido_kit.job_batches
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.job_batches: ~0 rows (lebih kurang)
DELETE FROM `job_batches`;
INSERT INTO `job_batches` (`id`, `name`, `total_jobs`, `pending_jobs`, `failed_jobs`, `failed_job_ids`, `options`, `cancelled_at`, `created_at`, `finished_at`) VALUES
	('a0c6cf0b-66b8-4b20-91c9-c8089ce4bee1', '', 2, 0, 0, '[]', 'a:2:{s:13:"allowFailures";b:1;s:7:"finally";a:1:{i:0;O:47:"Laravel\\SerializableClosure\\SerializableClosure":1:{s:12:"serializable";O:46:"Laravel\\SerializableClosure\\Serializers\\Signed":2:{s:12:"serializable";s:3563:"O:46:"Laravel\\SerializableClosure\\Serializers\\Native":5:{s:3:"use";a:4:{s:9:"columnMap";a:5:{s:4:"name";s:4:"name";s:3:"nip";s:3:"nip";s:12:"phone_number";s:12:"phone_number";s:5:"email";s:5:"email";s:8:"password";s:8:"password";}s:6:"import";O:45:"Illuminate\\Contracts\\Database\\ModelIdentifier":5:{s:5:"class";s:38:"Filament\\Actions\\Imports\\Models\\Import";s:2:"id";i:1;s:9:"relations";a:0:{}s:10:"connection";s:5:"mysql";s:15:"collectionClass";N;}s:13:"jobConnection";N;s:7:"options";a:0:{}}s:8:"function";s:2925:"function () use ($columnMap, $import, $jobConnection, $options) {\n                    $import->touch(\'completed_at\');\n\n                    event(new \\Filament\\Actions\\Imports\\Events\\ImportCompleted($import, $columnMap, $options));\n\n                    if (! $import->user instanceof \\Illuminate\\Contracts\\Auth\\Authenticatable) {\n                        return;\n                    }\n\n                    $failedRowsCount = $import->getFailedRowsCount();\n\n                    \\Filament\\Notifications\\Notification::make()\n                        ->title($import->importer::getCompletedNotificationTitle($import))\n                        ->body($import->importer::getCompletedNotificationBody($import))\n                        ->when(\n                            ! $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->success(),\n                        )\n                        ->when(\n                            $failedRowsCount && ($failedRowsCount < $import->total_rows),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->warning(),\n                        )\n                        ->when(\n                            $failedRowsCount === $import->total_rows,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->danger(),\n                        )\n                        ->when(\n                            $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->actions([\n                                \\Filament\\Notifications\\Actions\\Action::make(\'downloadFailedRowsCsv\')\n                                    ->label(trans_choice(\'filament-actions::import.notifications.completed.actions.download_failed_rows_csv.label\', $failedRowsCount, [\n                                        \'count\' => \\Illuminate\\Support\\Number::format($failedRowsCount),\n                                    ]))\n                                    ->color(\'danger\')\n                                    ->url(route(\'filament.imports.failed-rows.download\', [\'import\' => $import], absolute: false), shouldOpenInNewTab: true)\n                                    ->markAsRead(),\n                            ]),\n                        )\n                        ->when(\n                            ($jobConnection === \'sync\') ||\n                                (blank($jobConnection) && (config(\'queue.default\') === \'sync\')),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification\n                                ->persistent()\n                                ->send(),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->sendToDatabase($import->user, isEventDispatched: true),\n                        );\n                }";s:5:"scope";s:36:"Filament\\Tables\\Actions\\ImportAction";s:4:"this";N;s:4:"self";s:32:"0000000000000b470000000000000000";}";s:4:"hash";s:44:"XqpTg5Urk1UMiHhZ2fq5+KXYhlt9cl4LQ3+fUSgUZXA=";}}}}', NULL, 1767757376, 1767757404);

-- membuang struktur untuk table kaido_kit.media
CREATE TABLE IF NOT EXISTS `media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  `uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `collection_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `conversions_disk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` bigint unsigned NOT NULL,
  `manipulations` json NOT NULL,
  `custom_properties` json NOT NULL,
  `generated_conversions` json NOT NULL,
  `responsive_images` json NOT NULL,
  `order_column` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `media_uuid_unique` (`uuid`),
  KEY `media_model_type_model_id_index` (`model_type`,`model_id`),
  KEY `media_order_column_index` (`order_column`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.media: ~0 rows (lebih kurang)
DELETE FROM `media`;

-- membuang struktur untuk table kaido_kit.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.migrations: ~28 rows (lebih kurang)
DELETE FROM `migrations`;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '0001_01_01_000000_create_users_table', 1),
	(2, '0001_01_01_000001_create_cache_table', 1),
	(3, '0001_01_01_000002_create_jobs_table', 1),
	(4, '2022_12_14_083707_create_settings_table', 1),
	(5, '2024_12_04_025120_create_media_table', 1),
	(6, '2024_12_04_041953_create_breezy_sessions_table', 1),
	(7, '2025_01_01_120813_create_books_table', 1),
	(8, '2025_01_02_064819_create_permission_tables', 1),
	(9, '2025_01_03_114929_create_personal_access_tokens_table', 1),
	(10, '2025_01_04_125650_create_posts_table', 1),
	(11, '2025_01_08_152510_create_kaido_settings', 1),
	(12, '2025_01_08_233142_create_socialite_users_table', 1),
	(13, '2025_01_12_031340_create_notifications_table', 1),
	(14, '2025_01_12_031357_create_imports_table', 1),
	(15, '2025_01_12_031358_create_exports_table', 1),
	(16, '2025_01_12_031359_create_failed_import_rows_table', 1),
	(17, '2025_01_12_091355_create_contacts_table', 1),
	(18, '2026_01_04_000001_transform_books_to_articles', 1),
	(19, '2026_01_04_092628_create_devices_table', 1),
	(20, '2026_01_04_092629_create_device_attributes_table', 1),
	(21, '2026_01_05_081413_create_tickets_table', 1),
	(22, '2026_01_05_081513_create_ticket_responses_table', 1),
	(23, '2026_01_05_083705_create_ticket_attachments_table', 1),
	(24, '2026_01_06_015834_create_vehicles_table', 1),
	(25, '2026_01_06_015915_create_vehicle_bookings_table', 1),
	(26, '2026_01_06_085409_create_categories_table', 1),
	(27, '2026_01_06_085415_add_category_id_to_articles_table', 1),
	(28, '2026_01_08_052805_add_is_external_device_to_tickets_table', 2),
	(29, '2026_01_18_042126_add_performance_indexes', 3),
	(30, '2026_01_18_114618_add_more_performance_indexes', 4);

-- membuang struktur untuk table kaido_kit.model_has_permissions
CREATE TABLE IF NOT EXISTS `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.model_has_permissions: ~0 rows (lebih kurang)
DELETE FROM `model_has_permissions`;

-- membuang struktur untuk table kaido_kit.model_has_roles
CREATE TABLE IF NOT EXISTS `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.model_has_roles: ~2 rows (lebih kurang)
DELETE FROM `model_has_roles`;
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
	(1, 'App\\Models\\User', 11),
	(2, 'App\\Models\\User', 81);

-- membuang struktur untuk table kaido_kit.notifications
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint unsigned NOT NULL,
  `data` json NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.notifications: ~2 rows (lebih kurang)
DELETE FROM `notifications`;
INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
	('41d2d928-faaf-4f2e-90cf-0526118cd609', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 24, '{"body": "Tiket TKT-20260118-0001 status berubah menjadi: Diproses", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Tiket Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/admin/tickets/5", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "warning"}', NULL, '2026-01-18 05:05:01', '2026-01-18 05:05:01'),
	('42e82bfc-078d-4ebd-89d1-131c6541c293', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 39, '{"body": "Peminjaman KDO-20260108-0002 untuk Mitsubishi Xpander (Matic) (D 1123 T) telah disetujui", "icon": "heroicon-o-check-circle", "view": "filament-notifications::notification", "color": null, "title": "Peminjaman KDO Disetujui", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/vehicle-bookings/2", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Detail", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "success"}', NULL, '2026-01-07 21:57:01', '2026-01-07 21:57:01'),
	('6cc8cdd3-32b1-4cd7-9fa1-fd9f1596c836', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 39, '{"body": "Peminjaman KDO-20260108-0002 status berubah menjadi: Selesai", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Peminjaman KDO Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/vehicle-bookings/2", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Detail", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "success"}', NULL, '2026-01-07 22:00:05', '2026-01-07 22:00:05'),
	('cc8d172c-3146-4f77-84df-d56487b5519f', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 28, '{"body": "Tiket TKT-20260118-0001 status berubah menjadi: Diproses", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Tiket Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/tickets/4", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "warning"}', NULL, '2026-01-17 23:34:17', '2026-01-17 23:34:17');

-- membuang struktur untuk table kaido_kit.password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `nip` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'NIP sebagai identifier',
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`nip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.password_reset_tokens: ~0 rows (lebih kurang)
DELETE FROM `password_reset_tokens`;

-- membuang struktur untuk table kaido_kit.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.permissions: ~102 rows (lebih kurang)
DELETE FROM `permissions`;
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'view_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(2, 'view_any_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(3, 'create_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(4, 'update_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(5, 'restore_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(6, 'restore_any_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(7, 'replicate_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(8, 'reorder_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(9, 'delete_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(10, 'delete_any_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(11, 'force_delete_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(12, 'force_delete_any_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(13, 'article:create_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(14, 'article:update_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(15, 'article:delete_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(16, 'article:pagination_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(17, 'article:detail_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(18, 'view_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(19, 'view_any_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(20, 'create_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(21, 'update_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(22, 'restore_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(23, 'restore_any_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(24, 'replicate_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(25, 'reorder_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(26, 'delete_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(27, 'delete_any_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(28, 'force_delete_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(29, 'force_delete_any_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(30, 'view_device', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(31, 'view_any_device', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(32, 'create_device', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(33, 'update_device', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(34, 'delete_device', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(35, 'delete_any_device', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(36, 'view_device::attribute', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(37, 'view_any_device::attribute', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(38, 'create_device::attribute', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(39, 'update_device::attribute', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(40, 'delete_device::attribute', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(41, 'delete_any_device::attribute', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(42, 'view_role', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(43, 'view_any_role', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(44, 'create_role', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(45, 'update_role', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(46, 'delete_role', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(47, 'delete_any_role', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(48, 'view_ticket', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(49, 'view_any_ticket', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(50, 'create_ticket', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(51, 'update_ticket', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(52, 'delete_ticket', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(53, 'delete_any_ticket', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(54, 'assign_ticket', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(55, 'resolve_ticket', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(56, 'view_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(57, 'view_any_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(58, 'create_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(59, 'update_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(60, 'restore_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(61, 'restore_any_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(62, 'replicate_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(63, 'reorder_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(64, 'delete_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(65, 'delete_any_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(66, 'force_delete_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(67, 'force_delete_any_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(68, 'view_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(69, 'view_any_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(70, 'create_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(71, 'update_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(72, 'restore_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(73, 'restore_any_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(74, 'replicate_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(75, 'reorder_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(76, 'delete_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(77, 'delete_any_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(78, 'force_delete_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(79, 'force_delete_any_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(80, 'view_vehicle', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(81, 'view_any_vehicle', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(82, 'create_vehicle', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(83, 'update_vehicle', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(84, 'delete_vehicle', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(85, 'delete_any_vehicle', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(86, 'view_vehicle::booking', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(87, 'view_any_vehicle::booking', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(88, 'create_vehicle::booking', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(89, 'update_vehicle::booking', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(90, 'delete_vehicle::booking', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(91, 'delete_any_vehicle::booking', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(92, 'return_vehicle::booking', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(93, 'page_ManageSetting', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(94, 'page_VehicleCalendar', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(95, 'page_Themes', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(96, 'page_MyProfilePage', 'web', '2026-01-06 20:24:49', '2026-01-06 20:24:49'),
	(97, 'widget_VehicleBookingStats', 'web', '2026-01-06 20:24:49', '2026-01-06 20:24:49'),
	(98, 'widget_VehicleAvailabilityCalendar', 'web', '2026-01-06 20:24:49', '2026-01-06 20:24:49'),
	(99, 'widget_MyActiveBookings', 'web', '2026-01-06 20:24:49', '2026-01-06 20:24:49'),
	(100, 'widget_DeviceStatsWidget', 'web', '2026-01-06 20:24:49', '2026-01-06 20:24:49'),
	(101, 'widget_TicketStatsWidget', 'web', '2026-01-06 20:24:49', '2026-01-06 20:24:49'),
	(102, 'widget_RecentTicketsWidget', 'web', '2026-01-06 20:24:49', '2026-01-06 20:24:49');

-- membuang struktur untuk table kaido_kit.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.personal_access_tokens: ~0 rows (lebih kurang)
DELETE FROM `personal_access_tokens`;

-- membuang struktur untuk table kaido_kit.posts
CREATE TABLE IF NOT EXISTS `posts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.posts: ~10 rows (lebih kurang)
DELETE FROM `posts`;
INSERT INTO `posts` (`id`, `title`, `content`, `created_at`, `updated_at`) VALUES
	(1, 'Suscipit voluptate id illum modi porro ipsa.', 'Saepe quo dolores et voluptatem voluptatem eos repellendus. Quia est perspiciatis sed. Quidem earum harum assumenda harum voluptatem. Harum soluta ut alias odit.', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(2, 'Accusamus est cupiditate debitis sed.', 'Voluptatem quam sint vel deserunt. Eius vel veniam perferendis laborum. Expedita voluptas autem vel et. Assumenda sapiente autem et ut culpa aut doloremque doloremque.', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(3, 'Perferendis eos necessitatibus consequatur quasi.', 'Minus dolorum saepe neque quasi quas ipsam natus. Quia sint molestiae repellendus vel magnam vel. Aspernatur incidunt nesciunt odio veritatis ullam non rerum. Dolorum recusandae totam rerum.', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(4, 'Quo qui praesentium quae neque qui voluptate.', 'Autem voluptas dignissimos totam harum. Non numquam deserunt dolor dolorem unde. Qui cupiditate sint laboriosam nemo possimus. Aliquid quo quam et veritatis officiis.', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(5, 'Error vel aut dolorum eveniet consequatur porro voluptas blanditiis.', 'Repellendus consequatur sit voluptas. In dicta et optio non et. In error necessitatibus odio ut.', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(6, 'Temporibus rem sequi quis eos voluptate dignissimos libero.', 'Quasi sit rerum ut est error impedit nostrum quis. Veritatis eius qui et aliquid minima et. Sint accusantium quia nulla. In corrupti excepturi dolores dolorem.', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(7, 'Vitae ut beatae ut.', 'Ratione debitis consequatur doloribus illo fugiat. Tempora eaque dignissimos voluptas. Aut excepturi similique sit quo. Eligendi consequuntur impedit voluptatem.', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(8, 'Dolores adipisci accusamus non excepturi eum.', 'Quasi nulla magni odio aliquid quidem quia eos voluptate. Cum optio nobis quod facilis. Quam et est cupiditate veritatis.', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(9, 'Laborum cum provident velit ipsum rerum esse deserunt.', 'Ipsum amet harum qui labore sunt. Ducimus harum qui quis. Quis inventore voluptates qui et voluptas maxime. Debitis consequatur saepe natus deleniti aspernatur eos.', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(10, 'Ea odio ut atque blanditiis omnis.', 'Alias ab autem aspernatur et placeat consequuntur rem. Voluptatem tempore in inventore nulla porro officia. Pariatur quasi totam omnis expedita sed.', '2026-01-06 20:23:51', '2026-01-06 20:23:51');

-- membuang struktur untuk table kaido_kit.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.roles: ~2 rows (lebih kurang)
DELETE FROM `roles`;
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'super_admin', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(2, 'Member', 'web', '2026-01-06 20:48:04', '2026-01-06 20:48:04');

-- membuang struktur untuk table kaido_kit.role_has_permissions
CREATE TABLE IF NOT EXISTS `role_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.role_has_permissions: ~113 rows (lebih kurang)
DELETE FROM `role_has_permissions`;
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
	(1, 1),
	(2, 1),
	(3, 1),
	(4, 1),
	(5, 1),
	(6, 1),
	(7, 1),
	(8, 1),
	(9, 1),
	(10, 1),
	(11, 1),
	(12, 1),
	(13, 1),
	(14, 1),
	(15, 1),
	(16, 1),
	(17, 1),
	(18, 1),
	(19, 1),
	(20, 1),
	(21, 1),
	(22, 1),
	(23, 1),
	(24, 1),
	(25, 1),
	(26, 1),
	(27, 1),
	(28, 1),
	(29, 1),
	(30, 1),
	(31, 1),
	(32, 1),
	(33, 1),
	(34, 1),
	(35, 1),
	(36, 1),
	(37, 1),
	(38, 1),
	(39, 1),
	(40, 1),
	(41, 1),
	(42, 1),
	(43, 1),
	(44, 1),
	(45, 1),
	(46, 1),
	(47, 1),
	(48, 1),
	(49, 1),
	(50, 1),
	(51, 1),
	(52, 1),
	(53, 1),
	(54, 1),
	(55, 1),
	(56, 1),
	(57, 1),
	(58, 1),
	(59, 1),
	(60, 1),
	(61, 1),
	(62, 1),
	(63, 1),
	(64, 1),
	(65, 1),
	(66, 1),
	(67, 1),
	(68, 1),
	(69, 1),
	(70, 1),
	(71, 1),
	(72, 1),
	(73, 1),
	(74, 1),
	(75, 1),
	(76, 1),
	(77, 1),
	(78, 1),
	(79, 1),
	(80, 1),
	(81, 1),
	(82, 1),
	(83, 1),
	(84, 1),
	(85, 1),
	(86, 1),
	(87, 1),
	(88, 1),
	(89, 1),
	(90, 1),
	(91, 1),
	(92, 1),
	(93, 1),
	(94, 1),
	(95, 1),
	(96, 1),
	(97, 1),
	(98, 1),
	(99, 1),
	(100, 1),
	(101, 1),
	(102, 1),
	(1, 2),
	(2, 2),
	(3, 2),
	(30, 2),
	(31, 2),
	(48, 2),
	(49, 2),
	(50, 2),
	(86, 2),
	(87, 2),
	(88, 2);

-- membuang struktur untuk table kaido_kit.sessions
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.sessions: ~0 rows (lebih kurang)
DELETE FROM `sessions`;
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
	('gaUGv0ZCa9SB1J6wLR5ZI0DnXKkJfAJpsFWORNaS', 11, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiMWJldWNnSDhMZ3hBOFhic2w1NUxadjNmc2hCdzlCZU12V0NQeG91SiI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjI5OiJodHRwOi8vbG9jYWxob3N0OjgwMDAvdGlja2V0cyI7czo1OiJyb3V0ZSI7czozODoiZmlsYW1lbnQuYWRtaW4ucmVzb3VyY2VzLnRpY2tldHMuaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfM2RjN2E5MTNlZjVmZDRiODkwZWNhYmUzNDg3MDg1NTczZTE2Y2Y4MiI7aToxMTtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEyJEFDa0dVQTBjd1pKaS5xZTBLRmhlcS52NTN2blBsMnJYUFlIY3EzS0cvUTczdVRlek4yWXd1Ijt9', 1768718583),
	('LaVzzmR4Ve2pYciW0eSrbFWmcwoDsLAy2WGfNRU2', 11, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiUFFiaFhrWGtxb3E1QUNMNHVpdmtMeU5IY3dvdnlSY1BwbnhDN0RVZiI7czo1MDoibG9naW5fd2ViXzNkYzdhOTEzZWY1ZmQ0Yjg5MGVjYWJlMzQ4NzA4NTU3M2UxNmNmODIiO2k6MTE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjA6IiQyeSQxMiRBQ2tHVUEwY3daSmkucWUwS0ZoZXEudjUzdm5QbDJyWFBZSGNxM0tHL1E3M3VUZXpOMll3dSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7czo1OiJyb3V0ZSI7czozMDoiZmlsYW1lbnQuYWRtaW4ucGFnZXMuZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo4OiJmaWxhbWVudCI7YTowOnt9fQ==', 1767850682);

-- membuang struktur untuk table kaido_kit.settings
CREATE TABLE IF NOT EXISTS `settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `group` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `payload` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_group_name_unique` (`group`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.settings: ~0 rows (lebih kurang)
DELETE FROM `settings`;
INSERT INTO `settings` (`id`, `group`, `name`, `locked`, `payload`, `created_at`, `updated_at`) VALUES
	(1, 'KaidoSetting', 'site_name', 0, '"Spatie"', '2026-01-06 20:23:49', '2026-01-06 20:27:12'),
	(2, 'KaidoSetting', 'site_active', 0, 'true', '2026-01-06 20:23:49', '2026-01-06 20:27:12'),
	(3, 'KaidoSetting', 'registration_enabled', 0, 'false', '2026-01-06 20:23:49', '2026-01-06 20:27:12'),
	(4, 'KaidoSetting', 'login_enabled', 0, 'true', '2026-01-06 20:23:49', '2026-01-06 20:27:12'),
	(5, 'KaidoSetting', 'password_reset_enabled', 0, 'false', '2026-01-06 20:23:49', '2026-01-06 20:27:12'),
	(6, 'KaidoSetting', 'sso_enabled', 0, 'false', '2026-01-06 20:23:49', '2026-01-06 20:27:12');

-- membuang struktur untuk table kaido_kit.socialite_users
CREATE TABLE IF NOT EXISTS `socialite_users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `provider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialite_users_provider_provider_id_unique` (`provider`,`provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.socialite_users: ~0 rows (lebih kurang)
DELETE FROM `socialite_users`;

-- membuang struktur untuk table kaido_kit.tickets
CREATE TABLE IF NOT EXISTS `tickets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ticket_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `device_id` bigint unsigned DEFAULT NULL,
  `is_external_device` tinyint(1) NOT NULL DEFAULT '0',
  `assigned_to` bigint unsigned DEFAULT NULL,
  `category` enum('hardware','software','network','printer','other') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'hardware',
  `priority` enum('low','medium','high','critical') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'medium',
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('open','in_progress','waiting_for_user','resolved','closed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `resolution_notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `resolved_at` timestamp NULL DEFAULT NULL,
  `closed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tickets_ticket_number_unique` (`ticket_number`),
  KEY `tickets_user_id_foreign` (`user_id`),
  KEY `tickets_device_id_foreign` (`device_id`),
  KEY `tickets_assigned_to_foreign` (`assigned_to`),
  KEY `tickets_status_index` (`status`),
  KEY `tickets_priority_index` (`priority`),
  KEY `tickets_category_index` (`category`),
  KEY `tickets_created_at_index` (`created_at`),
  KEY `tickets_status_user_id_index` (`status`,`user_id`),
  KEY `tickets_status_assigned_to_index` (`status`,`assigned_to`),
  CONSTRAINT `tickets_assigned_to_foreign` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `tickets_device_id_foreign` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`) ON DELETE SET NULL,
  CONSTRAINT `tickets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.tickets: ~0 rows (lebih kurang)
DELETE FROM `tickets`;
INSERT INTO `tickets` (`id`, `ticket_number`, `user_id`, `device_id`, `is_external_device`, `assigned_to`, `category`, `priority`, `subject`, `description`, `status`, `resolution_notes`, `resolved_at`, `closed_at`, `created_at`, `updated_at`) VALUES
	(1, 'TKT-20260108-0001', 11, 1, 0, 11, 'hardware', 'medium', 'Perlu Update Antivirus', '<p>Antivirus expired</p>', 'closed', 'sudah diselesaikan', '2026-01-07 21:48:41', '2026-01-07 21:48:52', '2026-01-07 21:47:52', '2026-01-07 21:48:52'),
	(2, 'TKT-20260108-0002', 11, NULL, 1, NULL, 'software', 'medium', 'Mesin fotokopi macet', '<p>Mesin fotokopi macet</p>', 'closed', 'sudah solved', '2026-01-07 22:30:16', '2026-01-07 22:30:23', '2026-01-07 22:30:01', '2026-01-07 22:30:23'),
	(5, 'TKT-20260118-0001', 24, NULL, 1, NULL, 'hardware', 'medium', 'hardware ada yang error', '<p>hardware ada yang error</p>', 'in_progress', NULL, NULL, NULL, '2026-01-18 04:36:13', '2026-01-18 05:04:58');

-- membuang struktur untuk table kaido_kit.ticket_attachments
CREATE TABLE IF NOT EXISTS `ticket_attachments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` bigint unsigned NOT NULL,
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_size` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_attachments_ticket_id_foreign` (`ticket_id`),
  CONSTRAINT `ticket_attachments_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.ticket_attachments: ~0 rows (lebih kurang)
DELETE FROM `ticket_attachments`;
INSERT INTO `ticket_attachments` (`id`, `ticket_id`, `file_path`, `file_name`, `file_type`, `file_size`, `created_at`, `updated_at`) VALUES
	(1, 1, 'ticket-attachments/01KEDYXERKFCA6MKNKVHZDQ6J1.png', '01KEDYXERKFCA6MKNKVHZDQ6J1.png', 'image/png', 38852, '2026-01-07 21:47:52', '2026-01-07 21:47:52'),
	(4, 5, 'ticket-attachments/01KF8E8B9FRQZ4G3JMB1VHQW9Q.png', '01KF8E8B9FRQZ4G3JMB1VHQW9Q.png', 'image/jpeg', 52966, '2026-01-18 04:36:13', '2026-01-18 04:36:13');

-- membuang struktur untuk table kaido_kit.ticket_responses
CREATE TABLE IF NOT EXISTS `ticket_responses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_internal_note` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_responses_ticket_id_foreign` (`ticket_id`),
  KEY `ticket_responses_user_id_foreign` (`user_id`),
  KEY `ticket_responses_ticket_id_index` (`ticket_id`),
  KEY `ticket_responses_user_id_index` (`user_id`),
  KEY `ticket_responses_ticket_id_created_at_index` (`ticket_id`,`created_at`),
  CONSTRAINT `ticket_responses_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ticket_responses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.ticket_responses: ~0 rows (lebih kurang)
DELETE FROM `ticket_responses`;
INSERT INTO `ticket_responses` (`id`, `ticket_id`, `user_id`, `message`, `is_internal_note`, `created_at`, `updated_at`) VALUES
	(1, 5, 11, 'akan diselesaikan besok', 0, '2026-01-18 05:04:58', '2026-01-18 05:04:58'),
	(2, 5, 11, 'sekitar jam 09.00', 0, '2026-01-18 05:05:10', '2026-01-18 05:05:10');

-- membuang struktur untuk table kaido_kit.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nip` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '9 digit NIP untuk login',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Nullable untuk SSO users',
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `theme` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'default',
  `theme_color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_nip_unique` (`nip`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_email_index` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.users: ~0 rows (lebih kurang)
DELETE FROM `users`;
INSERT INTO `users` (`id`, `name`, `nip`, `email`, `phone_number`, `email_verified_at`, `password`, `avatar_url`, `theme`, `theme_color`, `remember_token`, `created_at`, `updated_at`) VALUES
	(11, 'RIO ALVAREZ', '817931566', 'rio.alvarez@pajak.go.id', '089678286135', '2026-01-06 20:23:51', '$2y$12$ACkGUA0cwZJi.qe0KFheq.v53vnPl2rXPYHcq3KG/Q73uTezN2Ywu', '01KF8FSPPHD8FF2Q7NC736ZX5Q.png', 'default', NULL, 'ZEBv3y8UErbXW1dv9ufsP7ks1onrGkxIm9t9x9UzbUSftS2Ym7uP09mrP4KI', '2026-01-06 20:23:51', '2026-01-18 05:03:10'),
	(12, 'WAHYU KURNIAWAN', '060114428', NULL, NULL, '2026-01-07 03:52:32', '$2y$12$MCDnnJzXtVO8uRGD/TjYC.GRCbzI5hzt10wP5NfSTzEk/NQeZ8XK6', NULL, 'default', NULL, NULL, '2026-01-06 20:42:58', '2026-01-06 20:42:58'),
	(13, 'ARIS SUKO WIBOWO', '060116130', NULL, NULL, '2026-01-07 03:52:33', '$2y$12$McMRpSIZhVaBPp4eNFHbheNB9gwtTsunC05V9VtfCJS7V/pNU.f0e', NULL, 'default', NULL, NULL, '2026-01-06 20:42:59', '2026-01-06 20:42:59'),
	(14, 'HARIS SUBEKTI', '060102726', NULL, NULL, '2026-01-07 03:52:34', '$2y$12$5HvUeIHx6NZtgDhPWcd0ruALzHon026x9F5TkMPjLPRyEi/i6cFb2', NULL, 'default', NULL, NULL, '2026-01-06 20:42:59', '2026-01-06 20:42:59'),
	(15, 'FRANSISKA JAYANTI DWILESTARI', '930102288', NULL, NULL, '2026-01-07 03:52:34', '$2y$12$bDMtGN.Kk0tiTjCzNQyOs.JaR/ro8J.gyOzMuQDQy1Ik8.ZXoiT1m', NULL, 'default', NULL, NULL, '2026-01-06 20:42:59', '2026-01-06 20:42:59'),
	(16, 'SRI RAHAYU', '930102368', NULL, NULL, '2026-01-07 03:52:35', '$2y$12$scKJoE/Q9x/pfirSQUPxt.Ge3e04ppMPakKAk47q5P6vF9YVQM.x6', NULL, 'default', NULL, NULL, '2026-01-06 20:42:59', '2026-01-06 20:42:59'),
	(17, 'ERVAN JANUARKO', '060115532', NULL, NULL, '2026-01-07 03:52:36', '$2y$12$t4seUzRHaNlzft3Ij4oB/epoU.5JKSqyJckveex9CwrkCnjgxoffy', NULL, 'default', NULL, NULL, '2026-01-06 20:43:00', '2026-01-06 20:43:00'),
	(18, 'REYNA DWI PRATIWI', '830602737', NULL, NULL, '2026-01-07 03:52:36', '$2y$12$ziNFvTfiuvVeWG7RCA/LqeTei900t5XICPxwBnVyxtIAI17PfNb3W', NULL, 'default', NULL, NULL, '2026-01-06 20:43:00', '2026-01-06 20:43:00'),
	(19, 'BUDI MUGIA RASPATI', '060080408', NULL, NULL, '2026-01-07 03:52:37', '$2y$12$qJ2dJ/SshY/c5anqJHr61.hBN7E59Z5T6WuHgKCgVUtKWRIZ5JYVi', NULL, 'default', NULL, NULL, '2026-01-06 20:43:00', '2026-01-06 20:43:00'),
	(20, 'HENNY SAPTARIA', '060103775', NULL, NULL, '2026-01-07 03:52:37', '$2y$12$hUHhC1W2ms2VEZ6I1a4UuORNJXeal0/oDdp/lqptfPhRI6MCu4hAW', NULL, 'default', NULL, NULL, '2026-01-06 20:43:00', '2026-01-06 20:43:00'),
	(21, 'CHRISTIANUS SETYO PRASTOWO', '060081902', NULL, NULL, '2026-01-07 03:52:38', '$2y$12$7H3TFwLVtGXSn5eXjEaCSe0YNdQKEFoVGIETt92uhIK/oLvs.0gSS', NULL, 'default', NULL, NULL, '2026-01-06 20:43:01', '2026-01-06 20:43:01'),
	(22, 'MELIA SINAGA', '830060484', NULL, NULL, '2026-01-07 03:52:39', '$2y$12$wNN6w7OypZSyF4xMD3FPCeyqyBd3tIS5enZYH1B1DuDhfkclegDby', NULL, 'default', NULL, NULL, '2026-01-06 20:43:01', '2026-01-06 20:43:01'),
	(23, 'MACHDAR ACHMEDY', '830600996', NULL, NULL, '2026-01-07 03:52:39', '$2y$12$KF3l3Z6ssnULqckMaE/ThOQp8SQC8zPOSO85vMTNBVaXQkXqAKYyC', NULL, 'default', NULL, NULL, '2026-01-06 20:43:01', '2026-01-06 20:43:01'),
	(24, 'AISYAH TASRI KHIYANINGRUM', '820480406', NULL, NULL, '2026-01-07 03:52:40', '$2y$12$kxOFoI0TSDeI2xJUUhxzROImGVJfx5eM/HvoIKjzqZlHNSWM7gB3u', NULL, 'default', NULL, NULL, '2026-01-06 20:43:01', '2026-01-06 20:43:01'),
	(25, 'YULI HENDRATNO', '060105892', NULL, NULL, '2026-01-07 03:52:41', '$2y$12$23vCGz8QoQ1yc.bTc8Q9y.9MdBmf9az4howX0Mqz1PNpD5X/B7YM2', NULL, 'default', NULL, NULL, '2026-01-06 20:43:01', '2026-01-06 20:43:01'),
	(26, 'THIO RIZKI FAUZI YUDHISTIRA', '830450647', NULL, NULL, '2026-01-07 03:52:41', '$2y$12$9jQwCsmGwmFMxRMlmIlR5.MF8yNEq7ltXfjb/.AoBsQ.pGKcjTu1q', NULL, 'default', NULL, NULL, '2026-01-06 20:43:02', '2026-01-06 20:43:02'),
	(27, 'ARIO ANGLING NURVANDITO', '060108933', NULL, NULL, '2026-01-07 03:52:42', '$2y$12$mxifSZ3JohNo6Qu14YD1AuSFBUaeN.CR/wySQs0emua4V1GW8GlZu', NULL, 'default', NULL, NULL, '2026-01-06 20:43:02', '2026-01-06 20:43:02'),
	(28, 'ADILAH NUR WIDYANI', '813300012', NULL, NULL, '2026-01-07 03:52:43', '$2y$12$tLGM3vVlmIH8BoqDZ3Ir4Oq37XVuo5xKzef3eL7bo4W.NvuYcHUc6', NULL, 'default', NULL, NULL, '2026-01-06 20:43:02', '2026-01-06 20:43:02'),
	(29, 'RISI NURFAIDAH', '830602754', NULL, NULL, '2026-01-07 03:52:43', '$2y$12$q8afaPe5BfaNZ.jCP6YhPeY7kMFd/lYcN5/g.Y8OwLI6x.9GoTmdi', NULL, 'default', NULL, NULL, '2026-01-06 20:43:02', '2026-01-06 20:43:02'),
	(30, 'VINA YULIA WIDYASTUTI', '813300993', NULL, NULL, '2026-01-07 03:52:44', '$2y$12$vuEctCqa.57Va1iZc3oF0.owEGAzpR11B4zCpC1haAZj6xeF.1lmW', NULL, 'default', NULL, NULL, '2026-01-06 20:43:03', '2026-01-06 20:43:03'),
	(31, 'PAJARNO', '060100867', NULL, NULL, '2026-01-07 03:52:45', '$2y$12$p3HIGj0gobAut74gvz90KeNkexhpQhuY41OV1Gtu268uTrg4EpZzi', NULL, 'default', NULL, NULL, '2026-01-06 20:43:03', '2026-01-06 20:43:03'),
	(32, 'RIESKA WIDIANI', '830290765', NULL, NULL, '2026-01-07 03:52:45', '$2y$12$4aXO5lfOMid8qds6kmVx2.apXUDNoCg0NYg5RXO.oaqtZtNggQNbW', NULL, 'default', NULL, NULL, '2026-01-06 20:43:03', '2026-01-06 20:43:03'),
	(33, 'IRMA AGUSTIN LEONITA', '930102156', NULL, NULL, '2026-01-07 03:52:46', '$2y$12$yIRKB.i.I1Yu2ynY.B4ZEu4UlHOKY0/OoXcT.BXiZ7I9ZhoubgjHS', NULL, 'default', NULL, NULL, '2026-01-06 20:43:03', '2026-01-06 20:43:03'),
	(34, 'WIJAYATI', '808360312', NULL, NULL, '2026-01-07 03:52:49', '$2y$12$xy6K9SlGPIcu.a9YFBgd7O9xppBLHHHEjVpoMsCdhlg7BvSquB2Za', NULL, 'default', NULL, NULL, '2026-01-06 20:43:04', '2026-01-06 20:43:04'),
	(35, 'MOHAMAD ADNAN ABDULLAH', '830601177', NULL, NULL, '2026-01-07 03:52:50', '$2y$12$/zdhP9K8gRKzu5/CKT6SNe.am/xIzjpNjPfhzkQiW4DK5Fsbkd9gy', NULL, 'default', NULL, NULL, '2026-01-06 20:43:04', '2026-01-06 20:43:04'),
	(36, 'BRATADI WISESA', '830203120', NULL, NULL, '2026-01-07 03:52:51', '$2y$12$TxGYNuwYGn4K31.j1qSDBup6efKtLgIaEl4ILA8QklFnRb9./kv2K', NULL, 'default', NULL, NULL, '2026-01-06 20:43:04', '2026-01-06 20:43:04'),
	(37, 'YULIS RISMAWATI', '060096561', NULL, NULL, '2026-01-07 03:52:51', '$2y$12$D2J4C9rjeDAS7gF2aj5IW.wFRoRO/YFsf.onymHHZGl.oGZBScH/.', NULL, 'default', NULL, NULL, '2026-01-06 20:43:04', '2026-01-06 20:43:04'),
	(38, 'NUR FITRIYAH', '060098757', NULL, NULL, '2026-01-07 03:52:52', '$2y$12$tX3vEO6OKWh8zzKPe4p3Du63JSdT03l7nOM3/RLGlJOXlO.RHufUq', NULL, 'default', NULL, NULL, '2026-01-06 20:43:04', '2026-01-06 20:43:04'),
	(39, 'ADANG MOCHAMAD SUGIRI', '951550965', NULL, NULL, '2026-01-07 03:52:53', '$2y$12$CCvI67SxFJx.YmM47k4S0.rDgioL57Rp5eToMPATMNttBkmlCm6a.', NULL, 'default', NULL, NULL, '2026-01-06 20:43:05', '2026-01-06 20:43:05'),
	(40, 'MIFTAKHUL ANAS FAKHRIZA', '060106393', NULL, NULL, '2026-01-07 03:52:54', '$2y$12$WoMHu14yzWX/lIAxM3FMc.IZ3G1px3v2.793BC9JqP6mbvaNhIQN2', NULL, 'default', NULL, NULL, '2026-01-06 20:43:05', '2026-01-06 20:43:05'),
	(41, 'WIDI HADIANSYAH', '060108709', NULL, NULL, '2026-01-07 03:52:54', '$2y$12$2sn5tvS.wxwRgw3uQkyYSuiod2P2m/0tcojO5XAyD/e3RfC/hhCgu', NULL, 'default', NULL, NULL, '2026-01-06 20:43:05', '2026-01-06 20:43:05'),
	(42, 'RENA AIRIN AGUSNI', '808360353', NULL, NULL, '2026-01-07 03:52:56', '$2y$12$.jL2xV.EMtnDsgZjJ7XSju/yakojShnGnD4WHcjkreBY/xsNfb3tK', NULL, 'default', NULL, NULL, '2026-01-06 20:43:05', '2026-01-06 20:43:05'),
	(43, 'MUHAMMAD ANWAR SHUBHAN', '810360048', NULL, NULL, '2026-01-07 03:52:59', '$2y$12$xvpEN39ELNkTI0ytspd7suNHGxh5VzgU1koksgyuW6PZCUr/mtHb2', NULL, 'default', NULL, NULL, '2026-01-06 20:43:06', '2026-01-06 20:43:06'),
	(44, 'DEDEN ADE SAEPULLAH', '060089355', NULL, NULL, '2026-01-07 03:53:02', '$2y$12$5stZLdzhEHZhK8pVuOAR3u7yaGsurj2KgqYZIHjuofXVTa4v.7hZq', NULL, 'default', NULL, NULL, '2026-01-06 20:43:06', '2026-01-06 20:43:06'),
	(45, 'YUSTINA TRISEPTIANI RAHAYU', '060105659', NULL, NULL, '2026-01-07 03:53:03', '$2y$12$.waiWB1fgKiWfmzeGG2HaexjTlKJa2AQGYTfBViBw8nvXYYYZq3Ou', NULL, 'default', NULL, NULL, '2026-01-06 20:43:06', '2026-01-06 20:43:06'),
	(46, 'ARIS KRISNHA WIBAWA', '060112143', NULL, NULL, '2026-01-07 03:53:04', '$2y$12$g..EdSSSylEZehMAt5qmjeTb7bdLgSDE80HUyhxoESxs1j.SNlxlK', NULL, 'default', NULL, NULL, '2026-01-06 20:43:06', '2026-01-06 20:43:06'),
	(47, 'FRISKA ARDIANTI PUSPITASARI', '813300239', NULL, NULL, '2026-01-07 03:53:05', '$2y$12$8iRjusvW6.9pEejbgilzUeoCr9pqRbL1JlZsa6qjHn9SB22dtJGO.', NULL, 'default', NULL, NULL, '2026-01-06 20:43:06', '2026-01-06 20:43:06'),
	(48, 'DEVITA PRADIANA KURNIA PUTRI', '820480331', NULL, NULL, '2026-01-07 03:53:06', '$2y$12$VsUgHl0jRFcNcUB8B.tStetT1M6R3Qz810m8XEZkC4LwTR/qujT8S', NULL, 'default', NULL, NULL, '2026-01-06 20:43:07', '2026-01-06 20:43:07'),
	(49, 'RHADYT BARA ICHFADHILLAH', '830602739', NULL, NULL, '2026-01-07 03:53:07', '$2y$12$pe./1PAiJ5WN3qdYMtqYJua5GrNA8uN84tR1leYDNw3Z5IGcQZF9W', NULL, 'default', NULL, NULL, '2026-01-06 20:43:07', '2026-01-06 20:43:07'),
	(50, 'MELLISA SEPANI EKATRIN', '917323204', NULL, NULL, '2026-01-07 03:53:08', '$2y$12$rpkXyaDXZyyI4cYdhSV6fOwZJGU98Qn.VNJ5EyiBXQlCMRN6Sq/XG', NULL, 'default', NULL, NULL, '2026-01-06 20:43:07', '2026-01-06 20:43:07'),
	(51, 'LUKMAN AHMADISASTRA', '060110663', NULL, NULL, '2026-01-07 03:53:08', '$2y$12$9lkiDZUXWuodqn6JSEhGReMF0aUSpS5S0QSbDP6yGg8uO0gjUQiNG', NULL, 'default', NULL, NULL, '2026-01-06 20:43:07', '2026-01-06 20:43:07'),
	(52, 'FADHIL DWI YULIAN', '817930614', NULL, NULL, '2026-01-07 03:53:09', '$2y$12$.ncqSXmQWeF159FbznqNgOBU/Krdg5nuvh25yeRbqB9Th3ZVJKNg2', NULL, 'default', NULL, NULL, '2026-01-06 20:43:08', '2026-01-06 20:43:08'),
	(53, 'RENI SAFITRI', '830602733', NULL, NULL, '2026-01-07 03:53:10', '$2y$12$kUVQSEu6SWHoyDnklSrwIucKQPWLfBCj7btW.037bY7MwN5YYvNz2', NULL, 'default', NULL, NULL, '2026-01-06 20:43:08', '2026-01-06 20:43:08'),
	(54, 'JUFRI HANDOKO SIJABAT', '817930733', NULL, NULL, '2026-01-07 03:53:10', '$2y$12$2KBuvZKfapn/RpW.U/yI0ukCmnVv.i0U.wasemg/Et9ZqqDOzSfny', NULL, 'default', NULL, NULL, '2026-01-06 20:43:08', '2026-01-06 20:43:08'),
	(55, 'DENI BASAR WIDJAYA', '060107310', NULL, NULL, '2026-01-07 03:53:11', '$2y$12$9Mzd9EbKNj9CWvRzK9Qq0.LF4e9kkJQFPm2ES/CSstwecUcentFWm', NULL, 'default', NULL, NULL, '2026-01-06 20:43:08', '2026-01-06 20:43:08'),
	(56, 'ALIF ADIYUDHA PRATAMA', '958635280', NULL, NULL, '2026-01-07 03:53:11', '$2y$12$v79UJ3XqPv1S/wl5l2PEweWGIdF0Wnt18TZwRR5YAxxAXk54ChqFi', NULL, 'default', NULL, NULL, '2026-01-06 20:43:09', '2026-01-06 20:43:09'),
	(57, 'REZA HERDIANA', '815100521', NULL, NULL, '2026-01-07 03:53:12', '$2y$12$Ks/cFx/bKlxu1y.4TneZcucXSNj1C8N96FnGxAcVIytFRoUTZGkAi', NULL, 'default', NULL, NULL, '2026-01-06 20:43:09', '2026-01-06 20:43:09'),
	(58, 'DEDI KURNIAWAN', '060087002', NULL, NULL, '2026-01-07 03:53:15', '$2y$12$dVuihw9f0asytxlRbRe.6.mXwahLKtoHqwRnVItrNbITm8OhLG1CC', NULL, 'default', NULL, NULL, '2026-01-06 20:43:09', '2026-01-06 20:43:09'),
	(59, 'FAUZIAH RAHMADITA NINGRUM', '908203808', NULL, NULL, '2026-01-07 03:53:16', '$2y$12$f/b6fcvO1v.lfa8wD/Nn2uyFlp84tPJXf0vL0p6JHydOUazp8WdSy', NULL, 'default', NULL, NULL, '2026-01-06 20:43:09', '2026-01-06 20:43:09'),
	(60, 'ANNISA ARIFKA SARI', '827040710', NULL, NULL, '2026-01-07 03:53:18', '$2y$12$dyhVtSEm59oEB4tUSTAhru5jgPo/BBgBGONaherr4PfZ7fwkfnHHS', NULL, 'default', NULL, NULL, '2026-01-06 20:43:09', '2026-01-06 20:43:09'),
	(61, 'WARDANI RAHENDRA', '060100660', NULL, NULL, '2026-01-07 03:53:23', '$2y$12$CSzHkTSUrEpQz5jKkPmCu.WmO0R3VcHFYbERsOXzKkzuvogm/JuCG', NULL, 'default', NULL, NULL, '2026-01-06 20:43:10', '2026-01-06 20:43:10'),
	(62, 'AEP SAEPULOH', '060093321', NULL, NULL, '2026-01-07 03:53:31', '$2y$12$fgk3K85LoX2q19TE1VamKOBFZ79nrLXFMm1SoYoRUApvPmOUMwVMq', NULL, 'default', NULL, NULL, '2026-01-06 20:43:10', '2026-01-06 20:43:10'),
	(63, 'IWAN SETIADY', '060087364', NULL, NULL, '2026-01-07 03:53:33', '$2y$12$aQO3p0ImQJjrFcuHli2Rrut5nIUHqs.HXWoRnfEN6.eqKngDXEhf.', NULL, 'default', NULL, NULL, '2026-01-06 20:43:10', '2026-01-06 20:43:10'),
	(64, 'ERWIN SIAHAAN', '060099976', NULL, NULL, '2026-01-07 03:53:34', '$2y$12$idsoyymkT4SGwPJfN7pZ.O9Sm0k0jMKLxOnhuFtypun/.fCmNxoHW', NULL, 'default', NULL, NULL, '2026-01-06 20:43:10', '2026-01-06 20:43:10'),
	(65, 'RENNY TIURMA ELIDA', '060103505', NULL, NULL, '2026-01-07 03:53:35', '$2y$12$C46ehy4FGe8ya6Iawvyj4Oi8dFWYMe9Pk.qz4uji4QRD/MHaZbGC6', NULL, 'default', NULL, NULL, '2026-01-06 20:43:11', '2026-01-06 20:43:11'),
	(66, 'ERWIN HIDAYANTO', '060078537', NULL, NULL, '2026-01-07 03:53:36', '$2y$12$FyPABL8Nb/yNCQeWDaellOzB9ermFBZLMGCaFRqkkHBSvQ1ZEeKg6', NULL, 'default', NULL, NULL, '2026-01-06 20:43:11', '2026-01-06 20:43:11'),
	(67, 'SOZARO ANDREAS FAMILYNARD MARUHAWA', '060083663', NULL, NULL, '2026-01-07 03:53:36', '$2y$12$ntgPoSAdGZAI2tHBrTnO4OMUunKnxjDLEedK.3Zxvm5oVFPfSE.wK', NULL, 'default', NULL, NULL, '2026-01-06 20:43:11', '2026-01-06 20:43:11'),
	(68, 'IIP TOIP', '060091011', NULL, NULL, '2026-01-07 03:53:37', '$2y$12$W2n08QPOXQbs1bRMFAN6Yew5Qq7RT2KIM1jHM.Qjy/osPBdxwOpKu', NULL, 'default', NULL, NULL, '2026-01-06 20:43:11', '2026-01-06 20:43:11'),
	(69, 'FATHONATIN NADZIRA PRAJA', '958634930', NULL, NULL, '2026-01-07 03:53:37', '$2y$12$1BtaUoXYM4dCBy4kk4hCRO1hYfx63zEdzX4iRiH/WNinXiX.Tkaqi', NULL, 'default', NULL, NULL, '2026-01-06 20:43:12', '2026-01-06 20:43:12'),
	(70, 'RISMA UMARSUDI', '060093388', NULL, NULL, '2026-01-07 03:53:38', '$2y$12$K.O8kH0wsu342ju3GLU/A.W.T1OZ3eFztxvrNksohlFKvOam56dvu', NULL, 'default', NULL, NULL, '2026-01-06 20:43:12', '2026-01-06 20:43:12'),
	(71, 'PANJI SANDHA HERYANTO', '060115226', NULL, NULL, '2026-01-07 03:53:39', '$2y$12$bHxzOKo4.RwV0f3j4wz6UesuNM9Cri9m77QpDkllIZKNcIb6y2YmC', NULL, 'default', NULL, NULL, '2026-01-06 20:43:12', '2026-01-06 20:43:12'),
	(72, 'INTAN WULANDARI', '958635369', NULL, NULL, '2026-01-07 03:53:39', '$2y$12$8ECyVLypebgAIWhof1zC8OsAbtuLWcTfleMfgKTZNCsmPWVgIY0TO', NULL, 'default', NULL, NULL, '2026-01-06 20:43:12', '2026-01-06 20:43:12'),
	(73, 'ASTRI RAFIKA AL HUSNA', '815100707', NULL, NULL, '2026-01-07 03:53:40', '$2y$12$zOsmah2LZl0RfbQLhSUJj.xi1AXc9.IRd7JF/qNA6Q0J.vKnqbYOm', NULL, 'default', NULL, NULL, '2026-01-06 20:43:12', '2026-01-06 20:43:12'),
	(74, 'ARFI RUMAISHA SHAFIRA', '817931513', NULL, NULL, '2026-01-07 03:53:40', '$2y$12$3tPSa.Sd0nKe42BYFyDP8eGyRy22k6Copg9FUHM3PX2GOgNY3GgGO', NULL, 'default', NULL, NULL, '2026-01-06 20:43:13', '2026-01-06 20:43:13'),
	(75, 'KANIA RAHMASARI', '817931543', NULL, NULL, '2026-01-07 03:53:41', '$2y$12$mjBEVK4MNQgVwv8RvG/0XuUwNFZp52t1Nb3Z3lBHwW.YjYkwBl1zC', NULL, 'default', NULL, NULL, '2026-01-06 20:43:13', '2026-01-06 20:43:13'),
	(76, 'SCIFO LUANSA', '817932257', NULL, NULL, '2026-01-07 03:53:41', '$2y$12$aX5cfv9BzetUJVDmNhhtAuj4QfogXQ80X6Be9cCa7Abp1Waf6urJa', NULL, 'default', NULL, NULL, '2026-01-06 20:43:13', '2026-01-06 20:43:13'),
	(77, 'EVANDO ON TAMBUNAN', '958631882', NULL, NULL, '2026-01-07 03:53:42', '$2y$12$gmSQrj.HoHnMgJzZCAF.9uPXe/ehg65AerRzpm2MOeHZslEfLttWe', NULL, 'default', NULL, NULL, '2026-01-06 20:43:13', '2026-01-06 20:43:13'),
	(78, 'MEINDRY MARINTAN REVIANTY PANDJAITAN', '060081666', NULL, NULL, '2026-01-07 03:53:43', '$2y$12$gttOMY0y3zu01o/XdSgQXOLUkC2Aa7zSDFVInIqfnOCIhq6O1jr3e', NULL, 'default', NULL, NULL, '2026-01-06 20:43:14', '2026-01-06 20:43:14'),
	(79, 'UJANG WIJIONO EKA MEI', '060095498', NULL, NULL, '2026-01-07 03:53:43', '$2y$12$Psqr3aXYCmF.crbU/t41SeTOq27jg5ee0mrLdN.iYreV97fgBiFpS', NULL, 'default', NULL, NULL, '2026-01-06 20:43:14', '2026-01-06 20:43:14'),
	(80, 'FAISAL NURGHANI', '817931061', NULL, NULL, '2026-01-07 03:53:45', '$2y$12$e4T9ezrnznhCCmBlmZQKmOM.oEJ9aRJuCSZ9OgjmUR5NUSjbn16V2', NULL, 'default', NULL, NULL, '2026-01-06 20:43:14', '2026-01-06 20:43:14'),
	(81, 'CAHYO KUSUMO', '910222613', 'cahyo.kusumo@pajak.go.id', NULL, '2026-01-07 03:51:31', '$2y$12$EYV83UonVtlDnZPcqDo2MeffoOZGb8B3UIzpt6MOPt0J3eL5C3qFG', NULL, 'default', NULL, 'M1lFy40zpr7mecH9CqQQeU4Gxy3qfQJzilat6vpKoYTPLlhCPaGIArPf2zQu', '2026-01-06 20:43:14', '2026-01-06 20:43:14'),
	(83, 'KIKI WALUYA', '060081000', NULL, NULL, '2026-01-07 03:53:46', '$2y$12$3N2bQjE.WEvuLEBzjqWIZOyz0Qo8Hteb.SVRQIgo54zgfq33DF/XG', NULL, 'default', NULL, NULL, '2026-01-06 20:43:15', '2026-01-06 20:43:15'),
	(84, 'CAHYO WIBOWO PALUPI', '060106173', NULL, NULL, '2026-01-07 03:53:47', '$2y$12$cmJeB7uOKpsZluTEb/FjNuQOj8B5oMKLYBw/YXmvRcLcxrLVohlIq', NULL, 'default', NULL, NULL, '2026-01-06 20:43:15', '2026-01-06 20:43:15'),
	(85, 'RIO MUCHLIS', '060112290', NULL, NULL, '2026-01-07 03:53:58', '$2y$12$3B.B3eqYoHa5EJbnL0t.vez.5q8/oc1tirT8M1ctxsTHvILQkSyuq', NULL, 'default', NULL, NULL, '2026-01-06 20:43:15', '2026-01-06 20:43:15'),
	(86, 'FITRI INDRIANI', '910222527', NULL, NULL, '2026-01-07 03:54:00', '$2y$12$sDGPO4nwCea9kUrcyJMS..cpRBx8bulG8i7IOKTBhyV4.kqrSwyNC', NULL, 'default', NULL, NULL, '2026-01-06 20:43:15', '2026-01-06 20:43:15'),
	(87, 'KARIMATUL `ULYA', '817931635', NULL, NULL, '2026-01-07 03:54:01', '$2y$12$xvrOsx8PsH7fMeXCdiv3ouSn7PlvmAtf/WTzeOjZR8moXfFA9b0tK', NULL, 'default', NULL, NULL, '2026-01-06 20:43:16', '2026-01-06 20:43:16'),
	(88, 'STEFANI LAKSITA NORMALADEWI', '958633367', NULL, NULL, '2026-01-07 03:54:02', '$2y$12$9J3ppIaOb99DtTma5hlmyeQbNI9b.BnvaWhV0N77RC5p1XmxYoZg.', NULL, 'default', NULL, NULL, '2026-01-06 20:43:16', '2026-01-06 20:43:16'),
	(89, 'IRVAN ALQORNI', '958633825', NULL, NULL, '2026-01-07 03:54:02', '$2y$12$/JIdxud.GUqIXqQIV/ah8utRpVnUaQ.R8lKOOWiQvUhjTjP9xV2vS', NULL, 'default', NULL, NULL, '2026-01-06 20:43:16', '2026-01-06 20:43:16'),
	(90, 'DIKY PRIHANTONO', '060084984', NULL, NULL, '2026-01-07 03:54:03', '$2y$12$hRAIK4XSquWOuHrbfot1JOnNiTLUk8LaK4wjWSbo8nrYwm8hAKmsK', NULL, 'default', NULL, NULL, '2026-01-06 20:43:16', '2026-01-06 20:43:16'),
	(91, 'MOHAMAD ANDRY SURYONDARU', '060085353', NULL, NULL, '2026-01-07 03:54:03', '$2y$12$qST0DutBBM.J5zrdCwjnwOr8M2Ppkam5P3YXSsceZMxkOWQ38a9qO', NULL, 'default', NULL, NULL, '2026-01-06 20:43:17', '2026-01-06 20:43:17'),
	(92, 'SOEKMAJA', '060085605', NULL, NULL, '2026-01-07 03:54:04', '$2y$12$WjKDLzu0DpRSniyPLuU7weSx1p6co.4pZatu4oWuADdpxTzNLq9AO', NULL, 'default', NULL, NULL, '2026-01-06 20:43:17', '2026-01-06 20:43:17'),
	(93, 'DWI HERNOWO', '060091674', NULL, NULL, '2026-01-07 03:54:05', '$2y$12$cnjtOq6oLF71.gvxCKtKseb9DtalqoeW.ffC9tB5hRHJEr1PMRb8i', NULL, 'default', NULL, NULL, '2026-01-06 20:43:17', '2026-01-06 20:43:17'),
	(94, 'LENY DJUHAENI', '060094828', NULL, NULL, '2026-01-07 03:54:05', '$2y$12$5hABgNtTIgjx0.S4Kb84teKw0YCkd//yp7U5v/onahHeKBqpgf58m', NULL, 'default', NULL, NULL, '2026-01-06 20:43:17', '2026-01-06 20:43:17'),
	(95, 'BAYU ARGO', '060106234', NULL, NULL, '2026-01-07 03:54:06', '$2y$12$4bAjqkgQY.rjpeIL/grrhu2MtoJCxxBNN1jb0154obY1X5PuLaJPW', NULL, 'default', NULL, NULL, '2026-01-06 20:43:17', '2026-01-06 20:43:17'),
	(96, 'UTAMY ARAFAH', '813300991', NULL, NULL, '2026-01-07 03:54:08', '$2y$12$VBiNhhLnM6KmqWq8vjUabe17J5uaoVmdVridthE3dKu6OSrWkiXyi', NULL, 'default', NULL, NULL, '2026-01-06 20:43:18', '2026-01-06 20:43:18'),
	(97, 'ARBI DWI KURNIAWAN', '817930502', NULL, NULL, '2026-01-07 03:54:08', '$2y$12$gS4LCtIvGXc2a.M2.yTHk.mUfwFKoi9hGJPRk0F/ejR7F75VSbd/.', NULL, 'default', NULL, NULL, '2026-01-06 20:43:18', '2026-01-06 20:43:18'),
	(98, 'HERLIANA NUR LAILY', '917318035', NULL, NULL, '2026-01-07 03:54:09', '$2y$12$.S.z.cbIrvEe7FL.SRolrOs1YKe5V7MYNc6wqaiBM3Y9eGLLW2IYm', NULL, 'default', NULL, NULL, '2026-01-06 20:43:18', '2026-01-06 20:43:18'),
	(99, 'ALLAFTA NUZULA ZAHRA', '958635448', NULL, NULL, '2026-01-07 03:54:10', '$2y$12$GkTnurCcOmUAsrZw/nwGFuDgjhf9S/aKPAohpfncGvzzM4KwDQFOm', NULL, 'default', NULL, NULL, '2026-01-06 20:43:18', '2026-01-06 20:43:18'),
	(100, 'CHRISTOFER', '815100020', NULL, NULL, '2026-01-07 03:54:10', '$2y$12$gXroV4gSTVOPpzSSUPwzZ.OdIviQ1fctftQjug3qCDdfSSz31q/mu', NULL, 'default', NULL, NULL, '2026-01-06 20:43:19', '2026-01-06 20:43:19'),
	(101, 'RD OKI TRESNA RAHMAWAN', '815101015', NULL, NULL, '2026-01-07 03:54:11', '$2y$12$Dtm0dMyD7w04IssPhIi.xON6ytiD7zZ6I0FG6CTiu31DajkvXCg6u', NULL, 'default', NULL, NULL, '2026-01-06 20:43:19', '2026-01-06 20:43:19'),
	(102, 'YESICA NATALIA SINAMBELA', '958633556', NULL, NULL, '2026-01-07 03:54:11', '$2y$12$uYM0jZfn/qIbGql9AEF5x.9oidPeWoMmH6yvRXl3sE4Pitwmj4ZFq', NULL, 'default', NULL, NULL, '2026-01-06 20:43:19', '2026-01-06 20:43:19'),
	(103, 'BIMO RAMADHANI JATMIKO', '817931515', NULL, NULL, '2026-01-07 03:54:13', '$2y$12$bTEr2QhM7PXKSmI/VtE5LexapRwWDSpIkkZXD2BIFwd8nusJmPjxm', NULL, 'default', NULL, NULL, '2026-01-06 20:43:19', '2026-01-06 20:43:19'),
	(104, 'FATHIMAH NAURATUL FIRDAUSI', '817931529', NULL, NULL, '2026-01-07 03:54:20', '$2y$12$011pN6zu4vBk9QedL3L.vez6LLnQw6pPEKnL5UhJAJk71jcOJVjSi', NULL, 'default', NULL, NULL, '2026-01-06 20:43:20', '2026-01-06 20:43:20'),
	(105, 'APRILIA DEWI NUR DIANTI', '958631413', NULL, NULL, '2026-01-07 03:54:20', '$2y$12$Ky5KkzQ/gd3ITNHn.OGZduIZREybTRKvbWnahqvO1hEhyQNJ3oCz2', NULL, 'default', NULL, NULL, '2026-01-06 20:43:20', '2026-01-06 20:43:20'),
	(106, 'ISNANINGSIH', '958632282', NULL, NULL, '2026-01-07 03:54:19', '$2y$12$LeYtuQy26dFriX4WNFfjwe7rYdCgiqsltld16.0XlPNmSK3YXkPTm', NULL, 'default', NULL, NULL, '2026-01-06 20:43:20', '2026-01-06 20:43:20'),
	(107, 'REGITA DUMARIA HUTAURUK', '958633064', NULL, NULL, '2026-01-07 03:54:19', '$2y$12$XHxVHYmPvt751Dwk7sJft.rOj0i.nmL764E9vMHI7Ge8eNa1Q9oYq', NULL, 'default', NULL, NULL, '2026-01-06 20:43:20', '2026-01-06 20:43:20'),
	(108, 'AZALIA TASYA NARISWARI', '958634709', NULL, NULL, '2026-01-07 03:54:19', '$2y$12$f3EzJhwmlUudZNatMaqbuOafjauHQ81ucQCEDPrzElK46VygmKk1a', NULL, 'default', NULL, NULL, '2026-01-06 20:43:20', '2026-01-06 20:43:20'),
	(109, 'ROJAKUM', '060077850', NULL, NULL, '2026-01-07 03:54:18', '$2y$12$W/b25cBwETuwSu8lWr6c.OUnjF5UFPasGzx/KkLdLV4Pj6AtNUNli', NULL, 'default', NULL, NULL, '2026-01-06 20:43:21', '2026-01-06 20:43:21'),
	(110, 'DANURI', '060081430', NULL, NULL, '2026-01-07 03:54:18', '$2y$12$tWnpu32933ogmqhUUO6IJuFcpxb2CdZJprK9F1T8LKc00orpvpvfy', NULL, 'default', NULL, NULL, '2026-01-06 20:43:21', '2026-01-06 20:43:21'),
	(111, 'SUPENDI NEMAN', '060101259', NULL, NULL, '2026-01-07 03:54:17', '$2y$12$Q8HYkYrbdWRV3WiOtDAiTuuXiIQm5D3Iant77A2vzhXVYOEma4csW', NULL, 'default', NULL, NULL, '2026-01-06 20:43:21', '2026-01-06 20:43:21'),
	(112, 'GUNAWAN FEBRIANTO ANTHUR', '060088976', NULL, NULL, '2026-01-07 03:54:17', '$2y$12$ML36Q3oH4ZCzIJao9oTGXuxietcArSvdKMz1HibLVdkCB.KR9AZRO', NULL, 'default', NULL, NULL, '2026-01-06 20:43:21', '2026-01-06 20:43:21'),
	(113, 'PROEMNA LITA DINAMIYATI', '060100249', NULL, NULL, '2026-01-07 03:54:16', '$2y$12$7w2CYMQ2UfyC7NvDUUqpX.noSnCykAoiPfCCnU8PjBM.gbu.eOUk6', NULL, 'default', NULL, NULL, '2026-01-06 20:43:22', '2026-01-06 20:43:22'),
	(114, 'TINO ARUS WAHYU JATI', '060110649', NULL, NULL, '2026-01-07 03:54:34', '$2y$12$OEce1XQJH4r4wtiJ4cHPs.quVtP6vGUAp56PLlqRB07ZZycvaEgPe', NULL, 'default', NULL, NULL, '2026-01-06 20:43:22', '2026-01-06 20:43:22'),
	(115, 'ALTORANA', '820340542', NULL, NULL, '2026-01-07 03:54:39', '$2y$12$OjcctpSU0EjmZDxygV.C6u3Y.8CyRzO1w7D833mow1gp9XFRirp6C', NULL, 'default', NULL, NULL, '2026-01-06 20:43:22', '2026-01-06 20:43:22'),
	(116, 'INTANNISA RAMADHINI', '860014263', NULL, NULL, '2026-01-07 03:54:38', '$2y$12$2wdneAG3o0z40vMoaD.j9eq84cHgr3pLhjuQ9fbaFtHbvoZXuh73C', NULL, 'default', NULL, NULL, '2026-01-06 20:43:22', '2026-01-06 20:43:22'),
	(117, 'DEDY TARYOKO', '060116673', NULL, NULL, '2026-01-07 03:54:38', '$2y$12$UVn8nRLCj28Chtoa2XOcQutcwJUQAdx7vImXmJEPGC6R942/xN/pG', NULL, 'default', NULL, NULL, '2026-01-06 20:43:23', '2026-01-06 20:43:23'),
	(118, 'HENRIZAL AMRAN', '060079621', NULL, NULL, '2026-01-07 03:54:38', '$2y$12$rknryW3OTvgBeIMRL5gW0OZFDtiJItAE8KR8ciJ8XE/uWqEHkoiBW', NULL, 'default', NULL, NULL, '2026-01-06 20:43:23', '2026-01-06 20:43:23'),
	(119, 'AHMAD AFRIZAL', '813300028', NULL, NULL, '2026-01-07 03:54:37', '$2y$12$11K6XNU8Or14./hIpqym8.fASEtLIA3XNjg56Bq2oVO4KRpqg80x6', NULL, 'default', NULL, NULL, '2026-01-06 20:43:23', '2026-01-06 20:43:23'),
	(120, 'DANI ANWAR IBRAHIM', '813300124', NULL, NULL, '2026-01-07 03:54:37', '$2y$12$UM1n3ZCVkciNUJxBZWz46.en603olBo9ZWrFqRV3zi68R4RDFyTxq', NULL, 'default', NULL, NULL, '2026-01-06 20:43:23', '2026-01-06 20:43:23'),
	(121, 'WITARSA JAKA PERMANA', '830203672', NULL, NULL, '2026-01-07 03:54:36', '$2y$12$/HpptcFX8EaUk34Xqoxf.OK08dZwRS5ZxLmcpcqVdMFAQX1qPW94.', NULL, 'default', NULL, NULL, '2026-01-06 20:43:24', '2026-01-06 20:43:24'),
	(122, 'PEVI IDA NURLAELASARI', '930102149', NULL, NULL, '2026-01-07 03:54:36', '$2y$12$1T.eKGeDYtfmVasU9acaaOJgxnu5x.ygNLckvc6Vml/GXw81k5sCe', NULL, 'default', NULL, NULL, '2026-01-06 20:43:24', '2026-01-06 20:43:24'),
	(123, 'FAZA HASYIM ASYARIE', '958636039', NULL, NULL, '2026-01-07 03:54:35', '$2y$12$odUn9En.o9sfYwwTo2akQO5z6QuYeByqeWfdT.0jYsbTFmqmp.Tg2', NULL, 'default', NULL, NULL, '2026-01-06 20:43:24', '2026-01-06 20:43:24'),
	(124, 'DIAN SEPTIANINGSIH', '958635323', NULL, NULL, '2026-01-07 03:54:16', '$2y$12$DzhNr9k4F0vPXZg/RhZXre4mP2EsFESCAhD/FuSDQzOP6Zcd8tcb6', NULL, 'default', NULL, NULL, '2026-01-06 20:43:24', '2026-01-06 20:43:24');

-- membuang struktur untuk table kaido_kit.vehicles
CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `plate_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `brand` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `year` year DEFAULT NULL,
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `capacity` tinyint unsigned NOT NULL DEFAULT '4',
  `fuel_type` enum('bensin','solar','listrik') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'bensin',
  `ownership` enum('dinas','sewa') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'dinas',
  `condition` enum('excellent','good','fair','poor') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'good',
  `status` enum('available','in_use','maintenance','retired') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'available',
  `last_service_date` date DEFAULT NULL,
  `tax_expiry_date` date DEFAULT NULL,
  `inspection_expiry_date` date DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vehicles_plate_number_unique` (`plate_number`),
  KEY `vehicles_status_index` (`status`),
  KEY `vehicles_plate_number_index` (`plate_number`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.vehicles: ~0 rows (lebih kurang)
DELETE FROM `vehicles`;
INSERT INTO `vehicles` (`id`, `plate_number`, `brand`, `model`, `year`, `color`, `capacity`, `fuel_type`, `ownership`, `condition`, `status`, `last_service_date`, `tax_expiry_date`, `inspection_expiry_date`, `image`, `notes`, `created_at`, `updated_at`) VALUES
	(1, 'D 1027 T', 'Toyota', 'Grand New Kijang Innova', '2015', 'Putih', 4, 'bensin', 'dinas', 'good', 'available', NULL, NULL, NULL, NULL, NULL, '2026-01-06 20:33:25', '2026-01-06 20:33:25'),
	(2, 'D 1123 T', 'Mitsubishi', 'Xpander (Matic)', '2019', 'Hitam', 4, 'bensin', 'dinas', 'good', 'available', NULL, NULL, NULL, NULL, NULL, '2026-01-06 20:34:21', '2026-01-06 20:34:21'),
	(3, 'D 1121 T', 'Mitsubishi', 'Xpander (Matic - Suki)', '2019', 'Hitam', 4, 'bensin', 'dinas', 'good', 'available', NULL, NULL, NULL, NULL, NULL, '2026-01-06 20:35:12', '2026-01-06 20:35:12'),
	(4, 'D 1127 T', 'Suzuki', 'Ertiga (Was 1)', '2020', 'Hitam', 4, 'bensin', 'dinas', 'good', 'available', NULL, NULL, NULL, NULL, NULL, '2026-01-06 20:35:49', '2026-01-06 20:35:49'),
	(5, 'D 1692 D', 'Toyota', 'New Kijang Innova (Was 5 - Manual)', '2011', 'Silver', 4, 'bensin', 'dinas', 'good', 'available', NULL, NULL, NULL, NULL, NULL, '2026-01-06 20:36:55', '2026-01-06 20:36:55');

-- membuang struktur untuk table kaido_kit.vehicle_bookings
CREATE TABLE IF NOT EXISTS `vehicle_bookings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `booking_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `vehicle_id` bigint unsigned NOT NULL,
  `driver_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `driver_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `passengers` json DEFAULT NULL,
  `destination` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `purpose` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `departure_time` time DEFAULT NULL,
  `status` enum('approved','in_use','completed','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'approved',
  `start_odometer` int unsigned DEFAULT NULL,
  `end_odometer` int unsigned DEFAULT NULL,
  `fuel_level` enum('empty','quarter','half','three_quarter','full') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `return_condition` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `return_notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `returned_at` timestamp NULL DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cancellation_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vehicle_bookings_booking_number_unique` (`booking_number`),
  KEY `vehicle_bookings_user_id_foreign` (`user_id`),
  KEY `vehicle_bookings_vehicle_id_start_date_end_date_status_index` (`vehicle_id`,`start_date`,`end_date`,`status`),
  KEY `vehicle_bookings_status_index` (`status`),
  KEY `vehicle_bookings_user_id_index` (`user_id`),
  KEY `vehicle_bookings_vehicle_id_index` (`vehicle_id`),
  KEY `vehicle_bookings_start_date_index` (`start_date`),
  KEY `vehicle_bookings_end_date_index` (`end_date`),
  KEY `vehicle_bookings_status_user_id_index` (`status`,`user_id`),
  KEY `vehicle_bookings_status_end_date_returned_at_index` (`status`,`end_date`,`returned_at`),
  KEY `vehicle_bookings_vehicle_id_status_start_date_end_date_index` (`vehicle_id`,`status`,`start_date`,`end_date`),
  CONSTRAINT `vehicle_bookings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `vehicle_bookings_vehicle_id_foreign` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.vehicle_bookings: ~2 rows (lebih kurang)
DELETE FROM `vehicle_bookings`;
INSERT INTO `vehicle_bookings` (`id`, `booking_number`, `user_id`, `vehicle_id`, `driver_name`, `driver_phone`, `document_number`, `passengers`, `destination`, `purpose`, `start_date`, `end_date`, `departure_time`, `status`, `start_odometer`, `end_odometer`, `fuel_level`, `return_condition`, `return_notes`, `returned_at`, `notes`, `cancellation_reason`, `created_at`, `updated_at`) VALUES
	(1, 'KDO-20260108-0001', 11, 2, 'Rio Alvarez', '089678286135', 'ST-0001/KPP.0905/2026', '["Cahyo Kusumo", "Ujang Wijiono"]', 'KBP', 'Visit Lapangan', '2026-01-08', '2026-01-08', '13:00:00', 'completed', NULL, 80000, 'half', 'Baik, tidak ada kerusakan', NULL, '2026-01-07 21:54:26', NULL, NULL, '2026-01-07 21:53:10', '2026-01-07 21:54:26'),
	(2, 'KDO-20260108-0002', 39, 2, 'Deni Tata', NULL, 'ST-0002/KPP.0905/2026', '[]', 'Cimahi', 'Visit Lapangan', '2026-01-08', '2026-01-08', '14:00:00', 'completed', NULL, 90000, 'quarter', 'Baik, tidak ada kerusakan', NULL, '2026-01-07 22:00:04', NULL, NULL, '2026-01-07 21:57:01', '2026-01-07 22:00:04');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
