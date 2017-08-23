<%-- 
    Document   : topic
    Created on : Apr 29, 2017, 11:57:54 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<body>
        <%!
            Connection conn;
            PreparedStatement pstmt;
            String qry;
            Statement stmt;
            ResultSet result;
            Integer quizID;
        %>
        
        <%-- READ function--%>
        <%
            try{
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");
                stmt=conn.createStatement();
                qry = "SELECT * FROM quiz";
                result = stmt.executeQuery(qry);
            }catch(ClassNotFoundException cnfe){
                out.println("Class not Found Execption:-" + cnfe.toString());
            }catch(SQLException sqle){
                out.println("SQL Query Exception:- " + sqle);
            }
        %>
    <center>
                 
        <div class="panel panel-default">
        <div class="panel-heading"><h1>Welcome to Game Of Quiz</h1><p>Relax and enjoy! Your results will not be recorded.</p></div>

        <div class="table-responsive">
        <table class="table table-stripped table-hover">
            <thead>
                <tr>
                    <th id="topic" scope="col" >Topic</th>
                </tr>
            </thead>                      
            <tbody>
                <%
                    while(result.next()) {
                        quizID = result.getInt("quizID");
                %>
                <tr>
                    <td headers="topic" class="topic"><a href="question.jsp?id=<%=quizID%>"><%=result.getString("quizTopic") %></a></td>
                    <td headers="topic" class="topicbtn"><a href="question.jsp?id=<%=quizID%>"><span class="glyphicon glyphicon-play-circle"></span></a></td>

                </tr>
                <%
                    }
                %>
            </tbody>  
        </table>       
        </div>
        </div> 
    </center>
</body>
</html>