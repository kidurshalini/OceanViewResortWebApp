<%@ page import="com.oceanviewresortapp.model.User" %>
<%
    User user = (User) session.getAttribute("loggedUser");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Home | Ocean View Resort</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link href="css/open-iconic/font/css/open-iconic-bootstrap.min.css" rel="stylesheet">
    <style>

        .carousel-inner img {
            height: 400px;
            object-fit: cover;
        }
        .about-us {
            padding: 60px 0;
            background-color: #f8f9fa;
        }
        .about-us h2 {
            margin-bottom: 30px;
        }
    </style>
</head>
<body>

<jsp:include page="Component/NavBar.jsp" />

<header class="hero-section py-5 bg-light text-dark">
    <div class="container text-center">
        <h1 class="display-5 fw-bold">Welcome to Ocean View Resort!</h1>
        <p class="lead text-muted">Quick, easy, and efficient booking at your fingertips.</p>

        <% if (user != null) { %>
        <a href="AddRoomDetails.jsp" class="btn btn-primary btn-lg mt-3">Book Now</a>
        <% } else { %>
        <a href="Login.jsp" class="btn btn-primary btn-lg mt-3">Login to Book</a>
        <% } %>

    </div>
</header>


<div id="resortCarousel" class="carousel slide mt-5" data-bs-ride="carousel">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#resortCarousel" data-bs-slide-to="0" class="active" aria-current="true"></button>
        <button type="button" data-bs-target="#resortCarousel" data-bs-slide-to="1"></button>
        <button type="button" data-bs-target="#resortCarousel" data-bs-slide-to="2"></button>
    </div>
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="Component/images/image1.webp" class="d-block w-100" alt="Ocean View">
        </div>
        <div class="carousel-item">
            <img src="Component/images/image2.avif" class="d-block w-100" alt="Luxury Room">
        </div>
        <div class="carousel-item">
            <img src="Component/images/image3.jpg" class="d-block w-100" alt="Resort Pool">
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#resortCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#resortCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>


<section class="about-us text-center">
    <div class="container">
        <h2>About Us</h2>
        <p class="lead">At Ocean View Resort, we offer a luxurious escape by the sea. Enjoy breathtaking ocean views, world-class amenities, and unforgettable experiences designed for relaxation and adventure. Whether you're here for a family vacation or a romantic getaway, we ensure comfort, elegance, and memories that last a lifetime.</p>
        <p>Our dedicated team is here to provide personalized services, making every stay seamless and special. Discover tranquility, adventure, and exquisite dining—all in one place.</p>
    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>