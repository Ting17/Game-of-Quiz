<%-- 
    Document   : login
    Created on : Jul 21, 2017, 4:19:07 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>              
<!-- Description: Game of Quiz -->
<!-- Author: Ting Lee Ting -->
<!-- Last update: 2017-->
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User List</title>
<meta name="viewport" content="width=device-width, initialscale=1.0"/>
<!-- Bootstrap -->
<link href="frameworks/css/bootstrap.min.css" rel="stylesheet" />
<!-- StyleSheet -->
<link href="style.css" rel="stylesheet" />
<!-- StyleSheet -->
<link href="languages.min.css" rel="stylesheet" />


<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
<![endif]-->

<script language="Javascript">
function disappearImage() {
var myDiv = '';
if (document.all) myDiv = document.all.flyimage1;
if (document.getElementById) myDiv = document.getElementById('flyimage1');
if (myDiv) myDiv.innerHTML = '';
}
</script>

</head>

<body onload="setTimeout('disappearImage()',10*1000)"> 
     <%!
        Connection conn;
        Statement stmt,stm;
        ResultSet result1,rs,res;
        String username,password;
        Integer quizID; 
    %>

    <%-- login function & read function--%>    
    <%
        username = request.getParameter("username");    
        password = request.getParameter("password");
     
        session.setAttribute("uname",username);
        session.setAttribute("pass",password);
        
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
     
            stmt = conn.createStatement();
            rs = stmt.executeQuery("select * from user where username='" + username + "' and password='" + password + "'");
            
        }catch(ClassNotFoundException cnfe){
            out.println("Class not Found Execption:-" + cnfe.toString());
        }catch(SQLException sqle){
            out.println("SQL Query Exception:- " + sqle);
        }     
    %>
    
    
    
   <div class="container">

    <div class="row" id="top"><!--1.2.1-->
                <div class="col-xs-12 col-md-12 col-lg-12"><!--1.2.1.1-->
                    <img src="resources/img/banner.jpg" alt="banner" class="banner"/>
                    <nav class="navbar navbar-default">
                    <div class="container-fluid">
                    <div class="navbar-header">
    <%  
        if (rs.next()) {
    %>
                        <p class="navbar-brand">Welcome Back  <%=rs.getString("username")%>!!!</p>
    <%
        }else  {
            out.println(request.getAttribute("errorMessage"));
        response.sendRedirect("index.html");
        }
    %>
                    </div>
    
                    <div class="navbar-header"> 
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-to-collapse">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button> 
                    </div>
        
                    <div class="navbar-collapse collapse" id="navbar-to-collapse">
                        <ul class="nav navbar-nav">
                            <li><a href="#">Video</a></li>
                            <li><a href="#">Quiz</a></li>
                            <li><a href="#">Star Collected</a></li>
                        </ul> 
                        <ul class="nav navbar-nav navbar-right">
                           
                            <li><a href='index.html'>Log out</a></li>
                        </ul> 
                    </div><!--end navigation collapse-->        
                    </div><!--close container-->
                    </nav>
                </div><!--end column 1.2.1.1-->
            </div><!--end row 1.2.1 & end of navigation-->
            
            
               
          
  
                <a href="profile.jsp" id="profile"><%=rs.getString("username")%></a>
    
         <span class="gif"><img src="resources/img/gif.gif" /></span>
        
      
        <div class="row"><!--3--> 
            <div class="col-xs-12 col-md-12 col-lg-12"> <!--3.1 --> 
                <div data-ng-view></div>
            </div>
        </div>
                <div >
      <FONT COLOR="RED" >
        <%= (int) (Math.random() * 10) %>
      </FONT>
      
                </div>
     ​
    </div>

  


<div id="flyimage1" style="position:absolute;">
<img name="seeYa" src="resources/img/cathungry.jpg" />
</div>
 
    <jsp:include page="footer.jsp"></jsp:include>