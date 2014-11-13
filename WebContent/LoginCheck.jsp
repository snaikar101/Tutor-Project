<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<body>
        <%
        String username=request.getParameter("username");
        String password=request.getParameter("password");
       
        if((username.equals("santosh") && password.equals("naikar")))
            {
            session.setAttribute("username",username);
            response.sendRedirect("index.jsp");
            }
        else
            response.sendRedirect("Error.jsp");
        %>
    </body>


Read more: http://mrbool.com/how-to-create-a-login-form-with-jsp/25685#ixzz3IyNhMgj5

</body>
</html>