<%@page import="com.rays.pro4.Model.TimeTableModel"%>
<%@page import="com.rays.pro4.controller.TimeTableListCtl"%>
<%@page import="com.rays.pro4.Util.DataUtility"%>
<%@page import="com.rays.pro4.Util.HTMLUtility"%>
<%@page import="com.rays.pro4.Bean.TimeTableBean"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.rays.pro4.Util.ServletUtility"%>
<%@page import="com.rays.pro4.controller.ORSView"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<link rel="icon" type="image/png"
	href="<%=ORSView.APP_CONTEXT%>/img/logo.png" sizes="16*16" />
<title>TimeTable List</title>

<script src="<%=ORSView.APP_CONTEXT%>/js/jquery.min.js"></script>
<script src="<%=ORSView.APP_CONTEXT%>/js/Checkbox11.js"></script>

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
	<jsp:useBean id="bean" class="com.rays.pro4.Bean.TimeTableBean"
		scope="request"></jsp:useBean>
	<%@include file="Header.jsp"%>

	<form action="<%=ORSView.TIMETABLE_LIST_CTL%>" method="post">
		<center>

			<div align="center">
				<h1>TimeTable List</h1>
				<h3>
					<font style="font: bold; color: red"><%=ServletUtility.getErrorMessage(request)%></font>
					<font style="font: bold; color: green"><%=ServletUtility.getSuccessMessage(request)%></font>
				</h3>
			</div>

			<%
				List cList = (List) request.getAttribute("courseList");

				List sList = (List) request.getAttribute("subjectList");

				int next = 0;
				if (request.getAttribute("nextListSize") != null) {
					next = DataUtility.getInt(request.getAttribute("nextListSize").toString());
				}
			%>
			<%
				int pageNo = ServletUtility.getPageNo(request);
				int pageSize = ServletUtility.getPageSize(request);
				int index = ((pageNo - 1) * pageSize) + 1;

				List list = ServletUtility.getList(request);
				Iterator<TimeTableBean> it = list.iterator();

				if (list.size() != 0) {
			%>

			<table width="100%">
				<tr>
					<td align="center"><label>Course Name :</label> <%=HTMLUtility.getList("clist", String.valueOf(bean.getCourseId()), cList)%>

						<label>Subject Name :</label> <%=HTMLUtility.getList("slist", String.valueOf(bean.getSubjectId()), sList)%>

						<%-- <label>Date Of Exam :</label>
		<input type ="text"  name="Exdate" readonly="readonly" id ="abcd" placeholder="Select Date" value="<%=DataUtility.getDateString(bean.getExamDate()) %>">		
		&nbsp;
 --%> <input type="submit" name="operation"
						value="<%=TimeTableListCtl.OP_SEARCH%>"> &nbsp; <input
						type="submit" name="operation"
						value="<%=TimeTableListCtl.OP_RESET%>"></td>
				</tr>
			</table>
			<br>
			<table border="1" width="100%" align="center" cellpadding=6px
				cellspacing=".2">
				<tr style="background: skyblue">

					<th width="5%"><input type="checkbox" id="select_all"
						name="Select">Select All.</th>
					<th>S.No.</th>
					<th>Course Name.</th>
					<th>Subject Name.</th>
					<th>Semester.</th>
					<th>ExamDate.</th>
					<th>ExamTime.</th>
					<th>Edit</th>

				</tr>
				<%
					while (it.hasNext()) {
							bean = it.next();
				%>
				<tr align="center">
					<td><input type="checkbox" class="checkbox" name="ids"
						value="<%=bean.getId()%>"></td>
					<td><%=index++%></td>
					<td><%=bean.getCourseName()%></td>
					<td><%=bean.getSubjectName()%></td>
					<td><%=bean.getSemester()%></td>
					<td><%=bean.getExamDate()%></td>
					<td><%=bean.getExamTime()%></td>
					<td><a href="TimeTableCtl?id=<%=bean.getId()%>">Edit</a></td>
				</tr>
				<%
					}
				%>
			</table>

			<table width="100%">
				<tr>
					<th></th>
					<%
						if (pageNo == 1) {
					%>
					<td align="left"><input type="submit" name="operation"
						disabled="disabled" value="<%=TimeTableListCtl.OP_PREVIOUS%>"></td>
					<%
						} else {
					%>
					<td align="left"><input type="submit" name="operation"
						value="<%=TimeTableListCtl.OP_PREVIOUS%>"></td>
					<%
						}
					%>

					<td><input type="submit" name="operation"
						value="<%=TimeTableListCtl.OP_DELETE%>"></td>
					<td><input type="submit" name="operation"
						value="<%=TimeTableListCtl.OP_NEW%>"></td>

					<%
						TimeTableModel model = new TimeTableModel();
					%>

					<%--  <%if(list.size()<pageSize ||model.nextPk()-1 == bean.getId()){ 
		 
				
		 %>	
		 
			<td align="right"><input type="submit" disabled="disabled" name="operation" value="<%=TimeTableListCtl.OP_NEXT%>" ></td>
			<%}else{ %>
			<td align="right"><input typeRR="submit" name="operation" value="<%=TimeTableListCtl.OP_NEXT%>" ></td>
			<%} %> --%>

					<td align="right"><input type="submit" name="operation"
						value="<%=TimeTableListCtl.OP_NEXT%>"
						<%=(list.size() < pageSize || next == 0) ? "disabled" : ""%>></td>

				</tr>
			</table>

			<%
				}
				if (list.size() == 0) {
			%>
			<td align="center"><input type="submit" name="operation"
				value="<%=TimeTableListCtl.OP_BACK%>"></td>
			<%
				}
			%>


			<input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
				type="hidden" name="pageSize" value="<%=pageSize%>">
	</form>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>
	</center>

	<%@include file="Footer.jsp"%>
</body>
</html>