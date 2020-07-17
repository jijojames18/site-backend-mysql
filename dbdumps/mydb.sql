SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

INSERT INTO `page` (`page_id`, `page_name`, `page_url`, `create_time`) VALUES
(1, 'blog', '/blog', '2020-07-16 20:25:05');

INSERT INTO `page_element` (`element_id`, `page_id`, `element_type`, `element_html_id`, `element_html_attrs`, `element_parent`, `element_position`) VALUES
(1, 1, 1, NULL, '{\n  "class": "modal-content modal-animated-in"\n}', NULL, 0),
(2, 1, 1, NULL, '{\n  "class": "modal-header"\n}', 1, 0),
(3, 1, 11, NULL, '{\n  "class": "header-title"\n}', 2, 0),
(4, 1, 1, NULL, '{\n  "class": "close-btn"\n}', 2, 1),
(5, 1, 12, NULL, '{\n  "src": "img/close_contact.png"\n}', 4, 0),
(6, 1, 1, 'contact-form-container', NULL, 1, 1),
(7, 1, 1, NULL, '{\n  "class": "modal-body"\n}', 6, 0),
(8, 1, 1, NULL, '{\n  "class": "col-md-6 col-md-offset-3"\n}', 7, 0),
(9, 1, 3, 'contact', '{\n  "method": "POST"\n}', 8, 0),
(10, 1, 1, NULL, '{\n  "class": "row"\n}', 9, 0),
(11, 1, 1, NULL, '{\r\n  "class": "col-md-12"\r\n}', 10, 0),
(12, 1, 13, NULL, NULL, 11, 0),
(13, 1, 5, 'name', '{\n  "name": "name",\n  "type": "text",\n  "class": "form-control",\n  "placeholder": "Your name...",\n  "required": true\n}', 12, 0),
(14, 1, 1, NULL, '{\n  "class": "col-md-12"\n}', 10, 1),
(15, 1, 13, NULL, NULL, 14, 0),
(16, 1, 14, 'form-submit', '{\n  "class": "btn",\n  "type": "submit"\n}', 15, 0);

INSERT INTO `page_element_types` (`element_id`, `element_name`) VALUES
(10, 'a'),
(8, 'article'),
(9, 'aside'),
(14, 'button'),
(1, 'div'),
(13, 'fieldset'),
(7, 'footer'),
(3, 'form'),
(11, 'h3'),
(6, 'header'),
(12, 'img'),
(5, 'input'),
(4, 'p'),
(2, 'span');

INSERT INTO `page_text_values` (`element_id`, `element_value`) VALUES
(3, 'Say hello');

INSERT INTO `user` (`username`, `email`, `password`, `create_time`) VALUES
('jijo', 'jijojames18@gmail.com', '1d99775d476aba577a336d9a59bc3e6ffdb02880', '2020-07-16 14:53:30');

INSERT INTO `user_record` (`record_id`, `create_time`, `record_element`) VALUES
(1, '2020-07-16 20:59:24', 9);

INSERT INTO `user_record_item` (`record_id`, `record_element`, `record_value`) VALUES
(1, 13, 'Jijo');

INSERT INTO `website` (`wname`, `create_time`, `contact_mail`, `contact_number`) VALUES
('jijojames.com', '2020-07-16 00:00:00', 'jijojames18@gmail.com', '+919876543210');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
