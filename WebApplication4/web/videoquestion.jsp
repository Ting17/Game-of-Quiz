<%-- 
    Document   : question
    Created on : Apr 29, 2017, 11:59:49 PM
    Author     : tingting17
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>

        <%!
            Connection conn;
            PreparedStatement pstmt;
            Statement stmt,stm;
            ResultSet result,rs;
            Integer videoID;
            String username,password;
            
        %>

        <%-- READ function for question--%>
        <%
            username = (String)session.getAttribute("uname");
            password = (String)session.getAttribute("pass");

            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz","root","");

            videoID = Integer.parseInt(request.getParameter("id"));
            try{
                Class.forName("com.mysql.jdbc.Driver");
             
                stmt = conn.createStatement();
                result = stmt.executeQuery("SELECT * FROM question WHERE videoID = '"+videoID +"' LIMIT 5");
     
                stm = conn.createStatement();
                rs = stm.executeQuery("select * from user where username='" + username + "' and password='" + password + "'");
                
            }catch(ClassNotFoundException cnfe){
                out.println("Class not Found Execption:-" + cnfe.toString());
            }catch(SQLException sqle){
                out.println("SQL Query Exception:- " + sqle);
            } 
            
            if(request.getParameter("btnCollect") != null){
                pstmt = conn.prepareStatement("UPDATE user SET result = ? WHERE username='" + username + "' and password='" + password + "'");
                pstmt.setString(1,request.getParameter("star"));
                pstmt.executeUpdate();
                
            }  
        %>
             
                    
    <div class="table-responsive">
        <table class="table table-stripped table-hover sortable questiont" id="tablepaging">
            <thead>
                <tr>
                    <th>
                        <center>
                            <div id="pgNum"></div>
                        </center> 
                    </th>
                </tr>
            </thead>       
            <tbody>
                <tr>  
        <%
            while(result.next() ) {
             
        %>               
                    <td>
                        <!--display quiz question-->
                        <div id="<%=result.getInt("questionID") %>" class="questioncontainer">
                            <h4><%=result.getString("question") %></h4>
                            <a class="glyphicon glyphicon-exclamation-sign" title="Hint" data-ng-click="show = 1"></a>
                        </div> 

                        <div class="container2">
                            <!-- Format for multiple choice -->
                            <div data-ng-if="'<%=result.getString("type")%>' === 'M'">
                                <form name="form1">
                                    <div class="row"><!--2.2.1--> 
                                        <div class="col-xs-6 col-md-12 col-lg-12 multichoice "><!--2.2.1.1--> 
                                            <label for="A">
                                                A <input type="radio" data-ng-model="checkeds" value="A" id="A" name="multiradio" required/> <%=result.getString("input1") %>
                                            </label>
                                        </div>
                                        <div class="col-xs-6 col-md-12 col-lg-12 multichoice"><!--2.2.1.2--> 
                                            <label for="B">
                                                B <input type="radio" data-ng-model="checkeds" value="B" id="B" name="multiradio" /> <%=result.getString("input2") %>
                                            </label>
                                        </div>
                                    </div> <!--close row 2.2.1-->

                                    <div class="row"><!--2.2.2-->        
                                        <div class="col-xs-6 col-md-12 col-lg-12 multichoice"><!--2.2.2.1--> 
                                            <label for="C">
                                                C <input type="radio" data-ng-model="checkeds" value="C" id="C" name="multiradio" /> <%=result.getString("input3") %>
                                            </label>
                                        </div>
                                        <div class="col-xs-6 col-md-12 col-lg-12 multichoice"><!--2.2.2.2--> 
                                            <label for="D">
                                                D <input type="radio" data-ng-model="checkeds" value="D" id="D" name="multiradio" /> <%=result.getString("input4") %>
                                            </label>
                                        </div>
                                    </div> <!--close row 2.2.2-->
             
                                    <!-- button -->   
                                    <div class="row button"><!--2.2.3-->
                                        <div class="col-xs-6 col-md-6 col-lg-6 full-width1" ><!--2.2.3.1-->
                                            <a  class="btn btn-primary btn-lg givecheckbutton" data-ng-click="show = 2; count = count+1" data-ng-init="0" data-ng-disabled="form1.$invalid" onClick="checkansSound()">Check</a>
                                        </div>
                                        <div class="col-xs-6 col-md-6 col-lg-6 full-width2"><!--2.2.3.2-->
                                            <a class="btn btn-danger btn-lg givecheckbutton" data-ng-click="show = 3" onClick="giveupSound()">Give Up</a>
                                        </div> 
                                    </div> <!--close row 2.2.3--> 
                                </form>                      
                 
                <!-- check answer-->
                <div data-ng-show="show === 2">
                    <!-- correct -->
                    <div data-ng-if="checkeds === '<%=result.getString("checked")%>'" >
                        <span class="yellow"><h3>Correct</h3></span>
                        <hr class="correct">

                        <b>Explanation:</b>
                        <p><%=result.getString("explanation")%></p>
                                
                        <form action="" method="POST">
                        <%  
                            if (rs.next()) {
                        %>
                            <input type="hidden" name="star" value="<%=rs.getInt("result")+1%>"/>
                        <%
                            }
                        %> 
                            <label for="collect">
                                <span class="glyphicon glyphicon-star yellow"></span>
                                <input type="submit" id="collect" name="btnCollect" style="display:none" onClick="collectSound()"/>
                            </label>
                        </form>  
                                
                        <div data-ng-if="count === 5 ">
                            <b>Congratulation!!! Bonus Time!!</b><br/><br/>
                            <a href="bonus.jsp">Claim here</a>
                        </div>                 
                    </div>
                                
                    <!-- incorrect -->
                    <div data-ng-if="checkeds !== '<%=result.getString("checked")%>'">
                        <h3>Incorrect</h3>
                        <hr class="incorrect">
                    </div> 
                </div>
                        
                <!-- Show answer -->
                <div data-ng-show="show === 3">
                    <b class="answer">Answer: <%=result.getString("checked")%></b><br/>
                    <b>Explanation in detail:</b>
                    <p><%=result.getString("explanation")%></p>
                </div> 
                            </div> <!--end of multiple choice format-->
                            
                            
                            <!-- Format for Fill in the Blank -->
                            <div data-ng-if="'<%=result.getString("type")%>' === 'B'">
                                <ul class="answercontainer">
                                    <li>
                                        <span><%=result.getString("input1") %></span>
                                        <span class="tab"><%=result.getString("input2") %></span>
                                        <span class="tab"><%=result.getString("input3") %></span>
                                        <span class="tab"><%=result.getString("input4") %></span>
                                    </li>
                                </ul>
                            </div> <!--end of fill in blank format-->

                            <!-- User input for Fill in the Blank & True False -->
                            <div data-ng-if="'<%=result.getString("type")%>' === 'B' || '<%=result.getString("type")%>' === 'T'">
                                <form name="form2">
                                    <div class="useranswer">
                                        <h4>Answer:</h4>
                                        <input type="text" name="answer" data-ng-model="checkeds" required/>
                                    </div>
                                                                                  
                                    <div class="row"><!--2.2.1-->
                                        <div class="col-xs-6 col-md-6 col-lg-6 full-width1"><!--2.2.1.1--> 
                                            <button class="btn btn-primary btn-lg givecheckbutton" data-ng-click="show = 2; count = count+1" data-ng-init="0" data-ng-disabled="form2.$invalid" onClick="checkansSound()">Check</button>
                                        </div>
                                        <div class="col-xs-6 col-md-6 col-lg-6 full-width2"><!--2.2.1.2-->
                                            <button class="btn btn-danger btn-lg givecheckbutton" data-ng-click="show = 3" onClick="giveupSound()">Give Up</button>  
                                        </div> 
                                    </div> <!--close row 2.2.1-->                 
                                </form>
                
                <!-- check answer-->
                <div data-ng-show="show === 2">
                    <!-- correct -->
                    <div data-ng-if="checkeds === '<%=result.getString("checked")%>'" >
                        <span class="yellow"><h3>Correct</h3></span>
                        <hr class="correct">

                        <b>Explanation:</b>
                        <p><%=result.getString("explanation")%></p>
                                
                        <form action="" method="POST">
                        <%  
                            if (rs.next()) {
                        %>
                            <input type="hidden" name="star" value="<%=rs.getInt("result")+1%>"/>
                        <%
                            }
                        %> 
                            <label for="collect">
                                <span class="glyphicon glyphicon-star yellow"></span>
                                <input type="submit" id="collect" name="btnCollect" style="display:none" onClick="collectSound()"/>
                            </label>
                        </form>  
                                
                        <div data-ng-if="count === 5 ">
                            <b>Congratulation!!! Bonus Time!!</b><br/><br/>
                            <a href="bonus.jsp">Claim here</a>
                        </div>                 
                    </div>
                                
                    <!-- incorrect -->
                    <div data-ng-if="checkeds !== '<%=result.getString("checked")%>'">
                        <span class="glyphicon glyphicon-star"></span>
                        <hr class="incorrect">
                        <p>Incorrect. You can try again</p>
                    </div> 
                </div>
                        
                <!-- Show answer -->
                <div data-ng-show="show === 3">
                    <b class="answer">Answer: <%=result.getString("checked")%></b><br/>
                    <b>Explanation in detail:</b>
                    <p><%=result.getString("explanation")%></p>
                </div> 
                
                
                
                            </div>
                                   
                 
                <div data-ng-show="show === 1">
                    <p><%=result.getString("hints") %></p>  
                </div>                     

                
                        </div> <!--close container2-->
                    </td>
                </tr>    
        <%
            } 
        %>
            </tbody>
        </table>
    </div>
           