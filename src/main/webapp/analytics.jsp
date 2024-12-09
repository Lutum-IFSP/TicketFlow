<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page session="true" %>

<fmt:setBundle basename="ticketflow" scope="application" />

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <c:set var="url">${pageContext.request.requestURL}</c:set>
        <base href="${fn:substring(url, 0, fn:length(url) - fn:length(pageContext.request.requestURI))}${pageContext.request.contextPath}/" />
        
        <link rel="stylesheet" href="css/analytics.css"/>
        <!-- Boxicons CDN Link -->
        <link href="https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
        <link rel="shortcut icon" href="image/favicon.ico" type="image/x-icon">
        <link rel="stylesheet" href="css/toast.css">
        <link rel="stylesheet" href="css/high_contrast.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
            google.charts.load('current', {'packages':['corechart']});
            google.charts.setOnLoadCallback(drawChart);

            function drawChart() {

                const myHeaders = new Headers();
                myHeaders.append("Access-Control-Allow-Origin", "*");
                const obj = {
                    method: "GET",
                    headers: myHeaders,
                }

                // Create the data table.
                var dataPieTickets = new google.visualization.DataTable();
                var dataPieUsers = new google.visualization.DataTable();

                fetch ("analytic/get", obj)
                    .then(response => {
                        return response.json();
                    })
                    .then(dataR => {
                        var users = dataR.users;
                        var tickets = dataR.tickets;
                        var open = dataR.open;
                        var closed = dataR.closed;
                        var qtdUsers = users.length;
                        var qtdTickets = tickets.length;
                        var qtdOpen = open.length;
                        var qtdClosed = closed.length;
                        var qtdUser = 0;
                        var qtdTech = 0;
                        var qtdAdmin = 0;
                        users.forEach(user => {
                            if(user.role == "USER") {
                                qtdUser++;
                            } else if(user.role == "TECHNICIAN") {
                                qtdTech++;
                            } else if(user.role == "ADMIN") {
                                qtdAdmin++;
                            }
                        })

                        function drawPieTickets() {
                            dataPieTickets.addColumn('string', 'Stage');
                            dataPieTickets.addColumn('number', 'qtd');
                            dataPieTickets.addRows([
                                ['Open', qtdOpen],
                                ['Closed', qtdClosed]
                            ]);
                        
                            var options = {'title':'Relatório de Tickets',
                                        'width':400,
                                        'height':200,
                                        'pieHole': 0.4
                                        };
                            
                            var chart = new google.visualization.PieChart(document.getElementById('chart_div_tickets'));
                            
                            chart.draw(dataPieTickets, options);
                        }

                        function drawPieUsers() {
                            dataPieUsers.addColumn('string', 'Role');
                            dataPieUsers.addColumn('number', 'qtd');
                            dataPieUsers.addRows([
                                ['User', qtdUser],
                                ['Technician', qtdTech],
                                ['Admin', qtdAdmin]
                            ]);

                            var options = {'title':'Relatório de Usuarios',
                                    'width':400,
                                    'height':200,
                                    'pieHole': 0.4
                                    };
                            
                            var chart = new google.visualization.PieChart(document.getElementById('chart_div_users'));
                            
                            chart.draw(dataPieUsers, options);

                        }

                        drawPieTickets();
                        drawPieUsers();

                    })
                    .catch(error => {console.err("Erro: " + error)})

            }
        </script>
        <title>TicketFlow - <fmt:message key="analytics" /></title>
    </head>
    <body onload="setData()">
        <div id="cir1" class="circle"></div>
        <div id="cir2" class="circle"></div>

        <!-- Data -->
        
        <main>
            <c:import url="sidebar.jsp" />

            <div id="ticketFundo">
                <div id="ticket">
                    <h1><fmt:message key="analytics" /></h1>
                    <hr>
                    <div id="chart_div_tickets"></div>
                    <div id="chart_div_users"></div>
                </div>
            </div>
        </main>
        
    </body>
</html>