<%-- 
    Document   : Home
    Created on : Jan 21, 2024, 11:34:32 AM
    Author     : ACER
--%>

<%@page import="Model.LectureDAO"%>
<%@page import="Model.EnrollDAO"%>
<%@page import="Model.ClassesDTO"%>
<%@page import="Model.ClassesDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <link rel="stylesheet" href="css/bootstrap/bootstrap.min.css"/>
        <script src="./js/bootstrap/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="./Assets/css/style.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    </head>
    <%@include file="./Components/Header.jsp" %>
    <body>
        <div class="bg-body-tertiary" >
            <div id="carouselExampleInterval" class="carousel slide container mb-2 mt-2" data-bs-ride="carousel">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="carousel-indicators">
                            <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0"
                                    class="active" aria-current="true" aria-label="Slide 1"></button>
                            <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1"
                                    aria-label="Slide 2"></button>
                            <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2"
                                    aria-label="Slide 3"></button>
                        </div>
                        <div class="carousel-inner " style="height: 270px;">
                            <div class="carousel-item active rounded-4" data-bs-interval="10000">
                                <img src="./Assets/img/slide.jpg" class="d-block w-100 rounded-4 img-fluid" alt="...">
                            </div>
                            <div class="carousel-item" data-bs-interval="10000">
                                <img src="./Assets/img/slide.jpg" class="d-block w-100 rounded-4 img-fluid" alt="...">
                            </div>
                            <div class="carousel-item" data-bs-interval="10000">
                                <img src="./Assets/img/slide.jpg" class="d-block w-100 rounded-4 img-fluid" alt="...">
                            </div>
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleInterval"
                                data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleInterval"
                                data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>
                </div>
            </div>
            <!-- Ket thuc slide -->


            <div class="container mt-5">

                <div class="row">
                    <h3 class="fw-medium mb-1">Kham pha cac lop hoc</h3>
                </div>
                <div class="row mt-3 mb-4">
                    <% List<ClassesDTO> list = (List<ClassesDTO>) request.getAttribute("class_list");
                        if (list != null) {
                            int count = 0;
                            EnrollDAO enrollDAO = new EnrollDAO();
                            for (ClassesDTO items : list) {
                                if (getRole.equals("student") && !enrollDAO.isEnrolledClass(id, items.getId())) {
                                    count++;

                    %>
                    <div class="col-lg-4">
                        <div class="card rounded-4">
                            <img src="<%=items.getThumbnail()%>" class="card-img-top object-fit-cover rounded-top-4" alt="<%= items.getName()%>" style="max-height: 10rem;">
                            <div class="card-body">
                                <h5 class="card-title"><%=items.getName()%></h5>
                                <p class="card-text">Giảng viên: <%= items.getLecturer().getEmail()%></p>
                                <a href="#myModal" role="button" class="btn btn-lg btn-primary" data-bs-toggle="modal" data-class-id = "<%= items.getId()%>" onclick="showPopup(this)">Show more</a>
                            </div>
                        </div>
                    </div>

                    <%} else {%>
                    <div class="col-lg-4">
                        <div class="card rounded-4">
                            <img src="<%=items.getThumbnail()%>" class="card-img-top object-fit-cover rounded-top-4" alt="<%= items.getName()%>" style="max-height: 10rem;">
                            <div class="card-body">
                                <h5 class="card-title"><%=items.getName()%></h5>
                                <p class="card-text">Giảng viên: <%= items.getLecturer().getEmail()%></p>
                                <%
                                    ClassesDAO classesDAO = new ClassesDAO();
                                    if ((getRole.equals("lecturer") && classesDAO.isLectureInClass(id, items.getId())) || getRole.equals("student")) {
                                %>
                                <a href="<%="insideClass?class_id=" + items.getId()%>" class="btn btn-lg btn-primary" >Go to class</a>
                                <%
                                    }
                                %>

                            </div>
                        </div>
                    </div>

                    <%}
                            }
                        }%>
                </div>
                <!-- Ket thuc kham pha hoc phan -->

                <div class="row">
                    <h3 class="fw-medium mb-3">Lop hoc cua ban</h3>
                </div>
                <div class="row">
                    <%
                        List<ClassesDTO> listClassEnrolled = (List<ClassesDTO>) request.getAttribute("classListEnrolled");
                        if (listClassEnrolled.size() > 0) {
                            for (ClassesDTO item : listClassEnrolled) {

                    %>
                    <div class="col-lg-3">
                        <a href="<%="insideClass?class_id=" + item.getId()%>" style="text-decoration: none">
                            <div class="card">
                                <img src="<%=item.getThumbnail()%>" class="card-img-top object-fit-cover rounded-top-4" alt="<%= item.getName()%>" style="max-height: 10rem;">
                                <div class="card-body">
                                    <h5 class="card-title"><%= item.getName()%></h5>
                                    <p class="card-text">Giảng viên: <%= item.getLecturer().getEmail()%></p>
                                </div>

                            </div>
                        </a> 
                    </div>
                    <%
                            }
                        }
                    %>
                    <!--                    <div class="col-lg-3">
                                            <div class="card">
                                                <div class="card-body">
                                                    <h5 class="card-title">Ten lop hoc</h5>
                                                    <p class="card-text">Fpt, VietNam</p>
                                                    <span class="badge rounded-pill text-bg-secondary">19 cau hoi</span>
                                                    <span class="badge rounded-pill text-bg-secondary">2 thanh vien</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-3">
                                            <div class="card">
                                                <div class="card-body">
                                                    <h5 class="card-title">Ten lop hoc</h5>
                                                    <p class="card-text">Fpt, VietNam</p>
                                                    <span class="badge rounded-pill text-bg-secondary">19 cau hoi</span>
                                                    <span class="badge rounded-pill text-bg-secondary">2 thanh vien</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-3">
                                            <div class="card">
                                                <div class="card-body">
                                                    <h5 class="card-title">Ten lop hoc</h5>
                                                    <p class="card-text">Fpt, VietNam</p>
                                                    <span class="badge rounded-pill text-bg-secondary">19 cau hoi</span>
                                                    <span class="badge rounded-pill text-bg-secondary">2 thanh vien</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                    
                                </div>-->
                    <div id="myModal" class="modal fade" tabindex="-1">
                        <div class="modal-dialog">

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function myFunction() {
            var x = document.querySelector("#passwordInput");
                if (x.type === "password") {
                    x.type = "text";
                } else {
                    x.type = "password";
                }
            }
        </script>
        <script>
    var selectModal = document.querySelector("div#myModal > .modal-dialog");
            function showPopup(element) {
                selectModal.innerHTML='<div class="spinner"></div>';
               var classId =  element.getAttribute("data-class-id");
                $.ajax({
  url: "enroll-class",
  method: "GET",
  data: {  class_id: classId },
  success: function(data) {
    // Xử lý dữ liệu nhận được ở đây
    console.log("Data from json: "+ data.name);
selectModal.innerHTML = '<div class="modal-content">' +
    '<div class="modal-header">' +
    '<h5 class="modal-title">Thông tin chi tiết lớp học ' + data.name + '</h5>' +
    '<button type="button" class="btn-close" data-bs-dismiss="modal"></button>' +
    '</div>' +
    '<form accept-charset="UTF-8" action="enroll-class" method="POST" id="formEnrollClass">' +
    '<div class="modal-body">' +
    '<p class="text-primary mb-1">Giảng viên '+data.lecturer.name+' </p>' +
    '<p class="text-primary mb-1">Thông tin chi tiết lớp học:</p>' +
    '<p class="text-secondary mb-1">'+data.description+'</p>' +
    '<p class="text-primary mb-1">Password</p>' +
    '<input type="password" class="form-control" name="password" id="passwordInput"/>' +
    '<input type="hidden" name="class_id" value="'+data.id+'">' +
    '<p class="card-text text-danger" id="messageError"></p>'+
    '<input type="checkbox" onclick="myFunction(0)"> Show Password' +
    '</div>' +
    '<div class="modal-footer">' +
    '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>' +
    '<button type="submit" class="btn btn-primary">Enroll</button>' +
    '</div>' +
    '</form>' +
    '</div>';
    var getFormSubmit = document.querySelector("#formEnrollClass");
    getFormSubmit.addEventListener("submit", (event) => {
        event.preventDefault();
        getDataFormEvent={
            password: event.srcElement[0].value,
            class_id: event.srcElement[1].value
        };

        $.ajax({
            url:"enroll-class",
            method:"POST",
            data:{
                class_id:getDataFormEvent.class_id,
                password:getDataFormEvent.password
            },success: function(msg) {
                var redirectUrl = msg;
                console.log(msg);
    window.location.href = redirectUrl; 
            }, error: function(xhr, status, error) {
                $("#messageError").html("Wrong password, please try another password!");
  }
        })
    });
  },
  error: function(xhr, status, error) {
    // Xử lý lỗi nếu có
    console.log("Lỗi: " + error);
  }
});

            }
        </script>
        <%@include file="./Components/Footer.jsp" %>
    </body>
</html>
