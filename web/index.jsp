<%@page import="model.*"%>
<%@page import="java.util.*"  %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>VICE</title>
        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <!-- Icons -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <!-- CSS -->
        <link rel="stylesheet" href="css/styleGlobal.css">
    </head>

    <body>
        <!-- NAVBAR -->
        <nav class="navbar navbar-expand-lg fixed-top">
            <div class="container-fluid">
                <!-- NAVBAR -->
                <div class="navbar-logo col-md-2">
                    <a class="navbar-brand" href="#">
                        <img style="width: 100px;" src="image/branding/vice logo.png" alt="">
                    </a>
                </div>
                <!-- NAVBAR TOOGLER -->
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
                        aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <!-- NAVBAR CATEGORY -->
                <div class="collapse navbar-collapse col-md-5" id="navbarNavDropdown">
                    <ul class="navbar-nav">
                        <%
                            HashMap<Integer,Category> cat_name = (HashMap<Integer,Category>) session.getAttribute("cat_list");
                            for (int key : cat_name.keySet()) {
                        %>
                        <div class="nav-item">
                            <a class="nav-link hover-animation-underline" href="Search?cat_id=<%= cat_name.get(key).getId() %>">
                                <%= cat_name.get(key).getName()%></a>
                        </div>
                        <%}%>
                    </ul>
                </div>
                <!-- NAVBAR SEARCH -->
                <div class="col-md-3 navbar-search">
                    <form action="Search">
                        <input style="width: 100%;" type="text" name="title" placeholder="Search anything">
                        <button style="border: 0px;" type="submit" class="rounded-circle nopadding">
                            <i class="material-icons hover-animation-grow">search</i>
                        </button>
                    </form>
                </div>

                <!-- NAVBAR PROFILE -->
                <div class="col-md-2 navbar-login navbar-collapse" id="navbarNavDropdown">
                    <% String user = "user";
                         int ID = 0;
                         if (session.getAttribute("user") != null) {  
                        User user1 = (User)session.getAttribute("user");
                        user = user1.getName();
                        ID = user1.getId();
                        }%>
                    <p class="nopadding">Hello, <%= user %></p>
                    <ul class="navbar-nav">
                        <li class="nav-item dropdown">
                            <a class="dropdown-toggle" href="#" id="navbarDropdownMenuLink" id="navbar-icon-user"
                               role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="material-icons hover-animation-grow">person</i>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownMenuLink">
                                <!-- c�i n�y th?ng n�o l�m jsp th� ph�n lo?i theo ki?u ng??i d�ng -->
                                <% if (session.getAttribute("user") == null) {  %>
                                <li><a class="dropdown-item" href="login.jsp">Login</a></li>
                                <li><a class="dropdown-item" href="login.jsp">Sign up</a></li>
                                    <%} else{ %>
                                <li><a class="dropdown-item" href="UserLogout">Log out</a></li>
                                <li><a class="dropdown-item" href="Profile?id=<%= ID %>">Profile</a></li>
                                    <%}%>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- spacer for fixed navbar -->
        <div style="height: 84px;" class="spacer"></div>
        <!-- Hotest News -->
        <!-- 2 row: 1st be full row; 2nd be 3 smaller one -->
        <div class="hotest-news">
            <div class="container-fluid">
                <div style="background-color: black;" class="row card featured-card nopadding">
                    <div class="row nopadding">
                        <%
                            ArrayList<News> news_list = (ArrayList<News>) request.getAttribute("news_list");
                            HashMap<Integer,User> user_nameList = (HashMap<Integer,User>) request.getAttribute("user_list");
                        %>
                        <div class="col-md-8 featured-card-image nopadding">
                            <img class="card-img" src="<%= session.getAttribute("location") %><%= news_list.get(0).getImage() %>" alt="...">
                        </div>
                        <div class="col-md-4 featured-card-content align-self-center nopadding">
                            <div class="card-body">
                                <h5 class="card-subtitle"><%= cat_name.get(news_list.get(0).getCat_id()).getName() %></h5><!-- first news -->
                                <h3 class="card-title"><%= news_list.get(0).getTitle()%></h3>
                                <p class="card-text"><%= news_list.get(0).getSubtitle()%></p>
                                <h6 class="card-text"><%= user_nameList.get(news_list.get(0).getUser_id()).getName() %></h6>
                            </div>
                        </div>
                    </div>
                    <a style="position: absolute; width: 100%; height: 100%;" href="GetNews?news_id=<%= news_list.get(0).getNews_id()%>"></a>
                </div>
                <div class="row card-group nopadding">
                    <%
                        for (int idx = 1 ; idx < 5; idx++) { //display 4 top
                    %>
                    <div class="card">
                        <a href="GetNews?news_id=<%= news_list.get(idx).getNews_id()%>" ><img src="<%= session.getAttribute("location") %><%= news_list.get(idx).getImage() %>" class="card-img-top" alt="..."> </a>
                        <div class="card-body">
                            <a href="Search?cat_id=<%= news_list.get(idx).getCat_id() %>"><h5 class="card-subtitle"><%= cat_name.get(news_list.get(idx).getCat_id()).getName() %></h5></a>
                            <a href="GetNews?news_id=<%= news_list.get(idx).getNews_id()%>" > <h3 class="card-title"><%= news_list.get(idx).getTitle()%></h3> </a>
                            <a href="GetNews?news_id=<%= news_list.get(idx).getNews_id()%>" ><p class="card-text"><%= news_list.get(idx).getSubtitle()%></p> </a>
                            <h6 class="card-text"><%= user_nameList.get(news_list.get(idx).getUser_id()).getName() %></h6>
                        </div>
                    </div>
                    <%}%>
                </div>
            </div>
        </div>

        <!-- Title -->
        <div class="latest-title nopadding">
            <h1>THE</h1>
            <h1>LATEST</h1>
        </div>


        <div class="latest-news">
            <div class="container-fluid">
                <%
                    for (int idx = 0 ; idx < news_list.size() ; idx++ ) {
                %>
                <div class="row card nopadding">
                    <div class="col-md-8 latest-news-body nopadding">
                        <div class="row nopadding">
                            <div class="col-md-6 card-image nopadding">
                                <a href="GetNews?news_id=<%= news_list.get(idx).getNews_id()%>" > <img class="card-img" src="<%= session.getAttribute("location") %><%= news_list.get(idx).getImage() %>" alt="..."></a>
                            </div>
                            <div class="col-md-6 card-content align-self-center nopadding">
                                <div class="card-body">
                                    <a href="Search?cat_id=<%= news_list.get(idx).getCat_id() %>"><h5 class="card-subtitle"><%= cat_name.get(news_list.get(idx).getCat_id()).getName() %></h5></a>
                                    <a href="GetNews?news_id=<%= news_list.get(idx).getNews_id()%>" > <h3 class="card-title"><%= news_list.get(idx).getTitle()%></h3> </a>
                                    <a href="GetNews?news_id=<%= news_list.get(idx).getNews_id()%>" ><p class="card-text"><%= news_list.get(idx).getSubtitle()%></p> </a>
                                    <h6 class="card-text"><%= user_nameList.get(news_list.get(idx).getUser_id()).getName() %></h6>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 latest-news-blank nopadding"></div>
                </div>
                <%}%>
            </div>

            <!-- footer -->
            <div class="footer">
                <img class="rotate" style="width: 100px;" src="image/branding/VMG-logo-updated.png" alt="">
                <ul>
                    <li>Tran The H�ng</li>
                    <li>L� The Luong</li>
                    <li>Ph�ng Ph�c L�m</li>
                    <li>Nguyen Ho�ng Hiep</li>
                    <li>Nguyen Ch� Trung</li>
                </ul>
                <p>@ 2023 PRj301 HE1725</p>
            </div>
        </div>
        <!-- Bootstrap script -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
        crossorigin="anonymous"></script>
    </body>

</html>