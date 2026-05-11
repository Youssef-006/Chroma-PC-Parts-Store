Chroma is a full-stack e-commerce web application dedicated to PC hardware and pre-built gaming systems. The platform enables customers to browse, search, and purchase a wide catalogue of computer components from CPUs and GPUs to peripherals and factory-assembled builds while giving administrators complete control over inventory, product listings, and order fulfilment.

Chroma follows the standard Spring MVC (Model-View-Controller) layered architecture:
Model - JPA entities (User, Product, Order, OrderItem) mapped to a MySQL 8 database via Spring Data JPA repositories.
View - Thymeleaf templates rendered server-side; separate layout fragments for navbar, footer, and role-specific navigation.
Controller - Spring @Controller classes handle HTTP requests, apply business logic, and pass model attributes to templates.
Service layer - business logic and transaction management decoupled from controllers.

Technology Stack
Backend: Spring Boot 3, Spring Web, Spring MVC, Spring Data JPA, Spring Security
Frontend: Thymeleaf, HTML5, CSS3, JavaScript
Database: MySQL 8.0
Build tool: Maven
Version control: Git / GitHub

Spring Security form login, authentication is handled via Spring Security with BCrypt password encoding and a custom login page, satisfying the Spring Security bonus requirement.
Implemented automated email functionality to send user-specific data and notifications using Spring Boot dependencies. 
Managed user and cart sessions through cookie handling for a seamless shopping experience. 
Applied multithreading techniques to efficiently process and handle concurrent user checkouts. 

