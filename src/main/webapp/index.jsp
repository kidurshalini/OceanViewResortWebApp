<%@ page import="com.oceanviewresortapp.model.User" %>
<%
    User user = (User) session.getAttribute("loggedUser");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Home | Ocean View Resort</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f7fa;
        }

        /* Hero Section */
        .hero-section {
            background: url('Component/images/image1.webp') no-repeat center center;
            background-size: cover;
            position: relative;
            color: white;
            text-shadow: 0 2px 6px rgba(0,0,0,0.5);
        }
        .hero-section::after {
            content: '';
            position: absolute;
            top:0; left:0; width:100%; height:100%;
            background: rgba(0,0,0,0.4);
        }
        .hero-section .container {
            position: relative;
            z-index: 1;
        }
        .hero-section h1 {
            font-size: 3rem;
            font-weight: 700;
            animation: fadeInDown 1s ease forwards;
        }
        .hero-section p {
            font-size: 1.2rem;
            margin-bottom: 20px;
            animation: fadeInUp 1s ease forwards;
        }
        .btn-hero {
            background: linear-gradient(135deg, #6dd5ed, #2193b0);
            color: white;
            font-weight: 600;
            padding: 12px 30px;
            border-radius: 50px;
            transition: all 0.3s ease;
        }
        .btn-hero:hover {
            background: linear-gradient(135deg, #2193b0, #6dd5ed);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }

        @keyframes fadeInDown {
            0% { opacity:0; transform: translateY(-20px);}
            100% { opacity:1; transform: translateY(0);}
        }
        @keyframes fadeInUp {
            0% { opacity:0; transform: translateY(20px);}
            100% { opacity:1; transform: translateY(0);}
        }

        /* Carousel */
        .carousel-inner img {
            height: 450px;
            object-fit: cover;
            border-radius: 1rem;
        }
        .carousel-caption {
            background: rgba(0,0,0,0.4);
            border-radius: 0.5rem;
            padding: 15px;
        }

        /* About Us Section */
        .about-us {
            padding: 80px 0;
        }
        .about-us h2 {
            margin-bottom: 40px;
            font-weight: 700;
            color: #2193b0;
        }
        .about-us .card {
            border-radius: 1rem;
            padding: 30px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            background-color: white;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .about-us .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
        }

        /* Footer / small text */
        .text-muted {
            color: #6c757d !important;
        }
    </style>
</head>
<body>

<jsp:include page="Component/NavBar.jsp" />

<!-- Hero Section -->
<header class="hero-section py-5 text-center">
    <div class="container">
        <h1>Welcome to Ocean View Resort!</h1>
        <p>Quick, easy, and efficient booking at your fingertips.</p>
        <% if (user != null) { %>
            <a href="ViewRoomDetails.jsp" class="btn btn-hero mt-3">View Available Rooms</a>
        <% } else { %>
            <a href="Login.jsp" class="btn btn-hero mt-3">Login to Book</a>
        <% } %>
    </div>
</header>

<!-- Carousel -->
<div class="container mt-5">
    <div id="resortCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#resortCarousel" data-bs-slide-to="0" class="active"></button>
            <button type="button" data-bs-target="#resortCarousel" data-bs-slide-to="1"></button>
            <button type="button" data-bs-target="#resortCarousel" data-bs-slide-to="2"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="Component/images/image1.webp" class="d-block w-100" alt="Ocean View">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Stunning Ocean Views</h5>
                    <p>Wake up to breathtaking scenery every morning.</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="Component/images/image2.avif" class="d-block w-100" alt="Luxury Room">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Luxury Rooms</h5>
                    <p>Elegant interiors with all modern comforts.</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="Component/images/image3.jpg" class="d-block w-100" alt="Resort Pool">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Refreshing Pool</h5>
                    <p>Relax and unwind at our pristine poolside.</p>
                </div>
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
</div>

<!-- About Us Section -->
<section class="about-us text-center">
    <div class="container">
        <h2>About Us</h2>
        <div class="card mx-auto col-lg-8">
            <p class="lead">At Ocean View Resort, we offer a luxurious escape by the sea. Enjoy breathtaking ocean views, world-class amenities, and unforgettable experiences designed for relaxation and adventure. Whether you're here for a family vacation or a romantic getaway, we ensure comfort, elegance, and memories that last a lifetime.</p>
            <p>Our dedicated team is here to provide personalized services, making every stay seamless and special. Discover tranquility, adventure, and exquisite dining—all in one place.</p>
        </div>
    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>