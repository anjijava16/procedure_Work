<!-- 
	Document	: home.jsp
	Created on	: Dec 7th,2014, 1:00AM
	Author     	: anji@iwinner.com
 -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/css/menuStyle.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/addExamValidation.js"></script>

<title>Home - Online Examination Portal</title>
<style type="text/css">
#navigation {
	width: 950px;
	height: 50px;
	margin: 0;
	padding: 0;
	background: url("${pageContext.request.contextPath}/images/navigation-bg.jpg") no-repeat left top;
}

#navigation ul {
	list-style: none;
	margin: 0;
	padding: 0;
}

#navigation ul li {
	display: inline;
	margin: 0px;
}

#navigation ul li a {
	height: 33px;
	display: block;
	float: left;
	padding: 17px 15px 0 15px;
	font: bold 12px Arial;
	color: #FFF;
	text-decoration: none;
	background: url(images/navigation-separator.png) no-repeat right center;
}

#navigation ul li a:hover {
	color: #134264;
	background: url("${pageContext.request.contextPath}/images/navigation-hover.png") repeat-x left top;
}

#navigation ul li#active a {
	color: #134264;
	background: url("${pageContext.request.contextPath}/images/navigation-hover.png"") repeat-x left top;
}

.Page-Heading {
	padding: 0;
	margin: 0;
	color: #4778e3;
	font: bold 38px "Calibri", Arial;
}

.show {
	display: block;
}

.hide {
	display: none;
}
</style>
</head>
<script type="text/javascript">
function checkExamId(value){
	var xmlhttp;
	var url="./checkExamId.do";
	url=url+"?examId="+value;
	  if (window.XMLHttpRequest)
	    	xmlhttp=new XMLHttpRequest();
	    else
		    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    xmlhttp.onreadystatechange=stateChangeObject
	xmlhttp.open("POST",url,true);
	xmlhttp.send();
	function stateChangeObject(){
		if (xmlhttp.readyState==4 && xmlhttp.status==200 )
		{
			var showdata = xmlhttp.responseText;
		    document.getElementById("ExamIdError").innerHTML=xmlhttp.responseText;
		    if(document.getElementById("ExamIdError").innerHTML=="ExamId AVAIABLE,Chose anothre Id"){
		    	document.getElementById("ExamId").focus();
		    }
		    if(document.getElementById("ExamIdError").innerHTML=="ExamId Not Found"){
		    	document.getElementById("ExamName").focus();
		    }
		}
	}	
}
</script>
<script type="text/javascript">
function checkExamName(value){
	if(value==""){
		alert("Please Enter ExamName");
		document.getElementById("ExamName").focus();
		return false;
	}
	if(value==0){
		alert("Please Enter ExamName");
		document.getElementById("ExamName").focus();
		return false;
	}
	return true;
}

</script>
<body>
	<%
		HttpSession Usersession = request.getSession(false);
		if (Usersession.getAttribute("username_") == null|| Usersession.getAttribute("ROLE") == null) {
			response.sendRedirect("startUp.do");
} else {%>

	<h2 class="Page-Heading">Online Examination Portal</h2>
	<%
		out.println("<b>Welcome "
					+ Usersession.getAttribute("username_") + "...</b>");
	%>
	<div id="navigation">
		<ul>
			<li id="active"><a href="landingPage.do">Home</a></li>
			<%
				if (Usersession.getAttribute("ROLE").toString().contains("ADMIN")) {
						out.println("<li><a href = 'adminConsole.do'>Administration Console</a></li>");
					}
			%>
			
			<a href="main.jsp">
			<li><a href="avaiableExams.do">Available Exams</a></li>
			<li><a href="PreviousResults.jsp">Previous Results</a></li>
			<li><a href="ContactUs.jsp">Contact Us</a></li>
			<li><a href="logout.do">Logout</a></li>
		</ul>
	</div>
<table border="0" width="950">
                    <tr>
                        <td align ="center">
<form name="RegisterNewExamForm" id="RegisterNewExamForm"  action="addNewExam.do" method="POST">
<table cellpadding ="10" cellspacing="0" border ="0" style="padding-top: 40px; border: none"> 
    <th colspan ="2" align="center">
    <h2 style="color: #4778e3;">
        New Exam Registration
    </h2>
    </th>
    <tr>
        <td style="color: #4778e3;">
            <b>Exam ID</b>
        </td>
        <td>
            <input type="text" onchange="checkExamId(this.value)" name="ExamId" id="ExamId" value=""/><b id="ExamIdError"> Enter a 5 digit Unique ID</b>
            <input type="hidden" name="ExamIdStatus" id="IdStatus"/>
        </td>
    </tr>
    <tr>
        <td style="color: #4778e3;">
            <b> Exam Name</b>
        </td>
        <td>
            <input type="text" name="ExamName" id="ExamName" value="" onclick="checkExamName(this.value)"  style="width: 400px"/>
        </td>
    </tr>
    <tr>
        <td style="color: #4778e3;">
            <b> Exam Description</b>
        </td>
        <td>
            <textarea rows="10" cols="50" name="txtexamdescription" id="txtexamdescription" style="width: 400px"></textarea>
        </td>
    </tr>
    
    <tr>
        <td></td>
        <td>
            <b style="padding-left: 55px;padding-top: 5px; padding-bottom: 15px"><% 
            if(Usersession.getAttribute("ExamCreationError")!= null)
             out.print(Usersession.getAttribute("ExamCreationError")); %></b><br/>
              <input class="submit" type="image" src="${pageContext.request.contextPath}/images/Register-Exam-btn.png" 
              width="160" height="42" style="margin-top:10px;; border: 0" />
     
        <a href="AdminConsoleHome.jsp">
                        <img src="${pageContext.request.contextPath}/images/Cancel-Exam-Registration-btn.png" width="160" height="42" style="margin-top:10px; border: 0" /></a>
         </td>
    </tr> 
  <input type="submit">  
</table>
<%
String message=(String)request.getAttribute("examIdInsertedMessage");
if(message!=null){
	out.println("<h3><font color='red'>"+message+"</font><h3>");
}
%>
    </form>
        </td>
        </tr>
                </table>

	<%
		}
	%>
</body>

</html>
