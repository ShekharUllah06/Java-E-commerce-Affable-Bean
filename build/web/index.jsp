<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : index
    Created on : Sep 19, 2016, 8:37:25 PM
    Author     : Shekhar Ullah
--%>
<sql:query var="categories" dataSource="jdbc/affablebean">
    SELECT * FROM category
</sql:query>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<div id="indexLeftColumn">
    <div id="welcomeText">
        <p>[ welcome text ]</p>

        <!-- test to access context parameters -->
        categoryImagePath: ${initParam.categoryImagePath}
        productImagePath: ${initParam.productImagePath}
        <br>
        <img src="img/categories/meats.jpg" alt=""/>
        <img src=${initParam.productImagePath}broccoli.png alt="broccoli"/>
    </div>
</div>

<div id="indexRightColumn">
    <c:forEach var="category" items="${categories.rows}">
        <div class="categoryBox">
            <a href="category?${category.id}">

                <span class="categoryLabelText">${category.name}</span>

                <img src="${initParam.categoryImagePath}${category.name}.jpg"
                     alt="${category.name}">
            </a>
        </div>
    </c:forEach>
</div>
