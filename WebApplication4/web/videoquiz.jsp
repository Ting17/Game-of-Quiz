<%-- 
    Document   : question
    Created on : Apr 29, 2017, 11:59:49 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html data-ng-app="myApp">
<head>
                
<!-- Description: Game of Quiz -->
<!-- Author: Ting Lee Ting -->
<!-- Last update: 2017-->
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Play</title>
<meta name="viewport" content="width=device-width, initialscale=1.0"/>
<!-- Bootstrap -->
<link href="frameworks/css/bootstrap.min.css" rel="stylesheet" />
<!-- StyleSheet -->
<link href="style.css" rel="stylesheet" />
<link href="questionstyle.css" rel="stylesheet" />

<!-- StyleSheet -->
<link href="languages.min.css" rel="stylesheet" />


<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->

</head>

<body>
        <%!
            Connection conn,conn1;
            PreparedStatement pstmt,pstmt1;
            Statement stmt,st,stm;
            ResultSet result,res,rs;
            String qry,qry1,category; 
            Integer videoID; 
            String username,password;
        %>

        <%-- READ function for question--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");
            
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
            if(request.getParameter("id") != null && request.getParameter("id")!= ""){  
                videoID = Integer.parseInt(request.getParameter("id"));
                category = request.getParameter("categ");
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    stmt=conn.createStatement();
                    res = stmt.executeQuery("SELECT * FROM video WHERE videoID = '"+ videoID +"'");
       
                }catch(ClassNotFoundException cnfe){
                    out.println("Class not Found Execption:-" + cnfe.toString());
                }catch(SQLException sqle){
                    out.println("SQL Query Exception:- " + sqle);
                } 
            }else{
                response.sendRedirect("./index.html");
            }
        %>
        
<script src="frameworks/js/paginationMethod.js"></script> 
    
    <div class="row"><!--1--> 
        <div class="col-xs-12 col-md-12 col-lg-12 parallax"> <!--1.1--> 
            
            <div class="row"><!--1.1.1--> 
                <div class="col-xs-8 col-md-8 col-lg-8 title"><!--1.1.1.1--> 
                    <h3>"Push yourself because no one else is going to do it for you"</h3>
                </div>
                
                <div class="col-xs-4 col-md-4 col-lg-4"><!--1.1.1.2--> 
                    <a data-toggle="modal" data-target="#myModal" >
                        <img src="resources/img/cat.gif" class="cat" alt="click me" title="click me" onClick="meowSound()"/> <!-- image obtained from http://misstingtingwu.blogspot.my/ -->
                    </a>

                    <!-- Modal -->
                    <div class="modal fade" id="myModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                    <div class="modal-content catnote">
                        <b>Thanks for noticing me human!</b><br/><br/>
                        <h3 class="yellow"><span class="glyphicon glyphicon-star-empty yellow"</span> Reward <span class="glyphicon glyphicon-star-empty yellow"</span></h3><br/>
                        <b>Go answer any quiz and click the check button for</b><p>exactly V times</p><b>You will get what you</b><br/><br/><b> DESERVED</b>
                        <div class="catpawn">
                        <p>Regards,</p>
                        <img src="resources/img/catpawn.png"></div>
                    </div>
                    </div>
                    </div> <!--close modal-->
                </div> <!--close column 1.1.1.2-->
            </div> <!--close row 1.1.1-->
        </div> <!--close column 1.1-->
    </div> <!--close row 1-->
    <div class="row">
        <div class="col-xs-12 col-md-12 col-lg-12 right">
            <div id="google_translate_element"></div>

            <script type="text/javascript">
            function googleTranslateElementInit() {
              new google.translate.TranslateElement({pageLanguage: 'en'}, 'google_translate_element');
            }
            </script>

            <script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>

        </div>
    </div>
    
<div class="container">
        <%
            while(res.next() ) {
        %>
    <div class="row wrap"><!--2--> 
        <div class="col-xs-12 col-md-8 col-lg-8 videoquestion"><!--2.1--> 
            <video class="videoque" controls>
                <source src="<%=res.getString("videoPath")%>" type="video/mp4">
            </video>
        </div>
        
        <div class="col-xs-12 col-md-4 col-lg-4 videoquestion" ><!--2.2--> 
            <jsp:include page="videoquestion.jsp"></jsp:include>
        </div> 
    </div> <!--close row 2-->
    
    <div class="row wrap"><!--3--> 
        <div class="col-xs-12 col-md-8 col-lg-8 contentborder"><!--3.1--> 
            <h3><%=res.getString("videoName") %></h3>
            <h4>Category << <%=res.getString("category") %> >></h4>
            <hr/>
            <p><%=res.getString("videoDesc") %></p>
        </div> <!--close column 3.1-->
        
        <%
           }
        %>
        
        <div class="col-xs-12 col-md-4 col-lg-4 contentborder link"><!--3.2--> 
            <a href="video2.jsp" class="btn btn-primary">Back To Video</a>
            <a href="index.html" class="btn btn-primary">Play More Quiz</a>
            <a href="profile.jsp" class="btn btn-primary">Profile</a>
            <a href="index.html" class="btn btn-primary">Feedback</a>
        </div> <!--close column 3.2-->
    </div> <!--close row 3-->
                  
    <div class="row wrap2"><!--4-->
        <div class="col-xs-12 col-md-12 col-lg-12 contentborder"><!--4.1--> 
            <h4>Related Videos</h4>
            <center>
            <div id="myCarousel" class="carousel slide " data-interval="false">
          
            <!-- Wrapper for slides -->
            <div class="carousel-inner">
                <div class="item active">
                   <jsp:include page="table.jsp"></jsp:include>
                </div>

                <div class="item">
                    <jsp:include page="table.jsp"></jsp:include>
                </div>  
                    
                <div class="item">
                    <jsp:include page="table.jsp"></jsp:include>
                </div>
            </div>

            <!-- Left and right controls -->
            <a class="left carousel-control" href="#myCarousel" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="right carousel-control" href="#myCarousel" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right"></span>
                <span class="sr-only">Next</span>
            </a>
            </div>
            </center>
        </div><!--end column 4.1--> 
    </div><!--end row 4--> 

</div> <!--close container--> 





<jsp:include page="footer.jsp"></jsp:include>
