<%@page import="java.util.*"%>
<%@page import="model.*"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Category</title>
        <!--Bootstrap-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <!-- Icons -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <!-- Embed Bootstrap -->
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
        <!-- Embed Global CSS -->
        <link rel="stylesheet" href="css/styleGlobal.css">
        <!-- Embed newsInfo CSS -->
        <link rel="stylesheet" href="css/styleNewsInfo.css">
    </head>

    <body>
        <!-- NAVBAR -->
        <nav class="navbar navbar-expand-lg fixed-top">
            <div class="container-fluid">
                <!-- NAVBAR -->
                <div class="navbar-logo col-md-3">
                    <a class="navbar-brand" href="MainPage">
                        <img style="width: 100px;" src="image/branding/vice logo.png" alt="">
                    </a>
                </div>
                <!-- NAVBAR TOOGLER -->
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
                        aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <!-- NAVBAR CATEGORY -->
                <div class="collapse navbar-collapse col-md-6" id="navbarNavDropdown">
                    <ul class="navbar-nav">
                        <%
                            HashMap<Integer,Category> cat_name = (HashMap<Integer,Category>) session.getAttribute("cat_list");
                        %>
                        <c:forEach items="<%= cat_name %>" var = "cat_name" >
                            <div class="nav-item">
                                <a class="nav-link hover-animation-underline" href="Search?cat_id=<c:out value="${cat_name.key}"/>"  ><c:out value="${cat_name.value.getName()}"/></a>
                            </div>
                        </c:forEach>
                    </ul>
                </div>
                <!-- NAVBAR LOGIN -->
                <div class="navbar-login col-md-3">
                    <a href="" id="navbar-icon-user">
                        <i class="material-icons hover-animation-grow">person</i>
                    </a>
                </div>
            </div>
        </nav>
        <%
            News news = (News) request.getAttribute("news");
            HashMap<Integer,User> user_nameList = (HashMap<Integer,User>) request.getAttribute("user_list");
            ArrayList<News> listNews = (ArrayList<News>) request.getAttribute("sameCategoryNews");
            ArrayList<Comments> commentList = (ArrayList<Comments>) request.getAttribute("commentList");
        %>
        <!-- spacer for fixed navbar -->
        <div style="height: 84px;" class="spacer"></div>

        <div class="scroller">
            <!-- HEADING -->
            <div class="heading">
                <div class="container-fluid">
                    <!-- getCategory here -->
                    <a class="heading-category" href="Search?cat_id=<%=news.getCat_id()%>"><%= cat_name.get(news.getCat_id()).getName() %></a>
                    <!-- getTitle here -->
                    <h1 class="heading-title"> <%= news.getTitle() %> </h1>
                </div>
            </div>
            <!-- SUB-HEADING -->
            <div class="sub-heading">
                <div class="container-fluid">
                    <div class="col-md-7 nopadding">
                        <!-- getSubtitle here -->
                        <h4 class="sub-heading-text"><%= news.getSubtitle() %></h4>
                        <div class="author">
                            <a class="author-info" href="publicUserInfo?user_id=<%= news.getUser_id()%>">
                                <!-- Author image here -->
                                <img class="author-image rounded-circle" src="<%= session.getAttribute("location") %><%= news.getImage() %>" alt="">
                                <p class="author-name nopadding">By <span><%= user_nameList.get(news.getUser_id()).getUname() %></span></p>
                            </a>
                            <div class="save-button">
                                <c:if test="${param.status eq 'saved' }">
                                    <a class="saved">Saved</a>
                                </c:if>
                                <c:if test="${param.status == null }">
                                    <a onclick="checkSession()" href="SaveNews?news_id=${news.getNews_id()}&user_id=${sessionScope.user.getId()}" class="save">Save this news</a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <c:if test="${( sessionScope.user.isIsAdmin() )}" >
                <form onsubmit="return confirm('Are you sure you want to delete this news?')" action="DeleteNews" method="post">
                    <input type="hidden" name="news_id" value="<%= news.getNews_id() %>">
                    <input type="submit" value="Delete">
                </form>
            </c:if>
            <!-- NEWS CONTENT -->
            <div class="news-content">
                <div class="container-fluid">
                    <div class="col-md-7 nopadding">
                        <div class="news-content-image">
                            <img src="<%= session.getAttribute("location") %><%= news.getImage() %>" alt="">
                        </div>
                        <!-- getText here -->
                        <div class="news-content-text">
                            <p><%= news.getContent()%> </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--COMMENT-->
        <div class = "comment">
            <div class = "comment-box" id="com">
                <form action="CommentController" method="post">
                    <c:if test="${param.action == 'edit'}">
                        <input type="text" style="display: none" name="action" value="update">
                        <input type="text" style="display: none" name="comment_id" value="${param.com_id}">
                        <c:set var="value" value="${param.content}"/>
                    </c:if>
                    <c:if test="${param.action == null}">
                        <input type="text" style="display: none" name="action" value="insert">
                        <c:set var="value" value=""/>
                    </c:if>
                    <input type="text" style="display: none" name="news_id" value=<%= news.getNews_id() %>>
                    <table>
                        <h3>Comment(<c:out value="${requestScope.listComments.size()}"/>)</h3>
                        <tr>
                            <td colspan="2"><input value="${value}" class="news-content-text" type="text" name="comment_content" placeholder="Type a comment..." onclick="checkSession()"></td>
                        </tr>
                        <tr>
                            <td>You need to login/signup before posting comment</td>
                            <td><input  type="submit" value ="Post comment"></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
        <div class="comment">
            <c:set var="user_nameList" value="${requestScope.user_list}"/>
            <c:forEach var = "commentList" varStatus="loop" items="${requestScope.commentList}">
                <div class="comment-content-text">
                    <p><a href="publicUserInfo?user_id=${commentList.getUser_id()}">
                            <i class="material-icons hover-animation-grow">person</i><b>${user_nameList[commentList.getUser_id()].getUname()}</b></a>
                    </p> 
                    <p><c:out value="${commentList.getCommment_content()}"/>
                        <c:if test="${sessionScope.user != null}">
                            <c:if test="${commentList.getUser_id() == sessionScope.user.getId()}"> <!<!-- chi chinh sua dc comment cua minh -->
                                <a href="GetNews?news_id=${news.getNews_id()}&action=edit&com_id=${commentList.getComment_id()}&content=${commentList.getCommment_content()}&#com" class = "edit">Edit</a>
                                <a onclick="return confirm('Are you sure you want to delete this comment?')" href="deleteComment?news_id=${news.getNews_id()}&comment_id=${commentList.getComment_id()}" class="edit">Delete</a>
                            </c:if>
                        </c:if>
                    </p>
                </div>
            </c:forEach>
        </div>
        <!-- FOOTER -->
        <div class="footer">
            <img class="rotate" style="width: 100px;" src="image/branding/VMG-logo-updated.png" alt="">
            <ul>
                <li>Tr?n Th? Hùng</li>
                <li>Lý Th? L??ng</li>
                <li>Phùng Phúc Lâm</li>
                <li>Nguy?n Hoàng Hi?p</li>
                <li>Nguy?n Chí Trung</li>
            </ul>
            <p>@ 2023 PRj301 HE1725</p>
        </div>
        <script>
            function checkSession() {
                // Retrieve data from the server-side using JSP expressions
                var username = <%= session.getAttribute("user") %>;

                // Use the server-side data in the JavaScript code
                if (!username) {
                    event.preventDefault(); // prevent going to href first
                    window.location.href = "login.jsp";
                    alert("You have to login or sign up to commit this action");
                }
            }
        </script>
    </body>

</html>