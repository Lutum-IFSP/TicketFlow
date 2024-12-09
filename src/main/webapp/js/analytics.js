import "https://www.gstatic.com/charts/loader.js";

google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

function setData() {
    let url = `analytic/`;

    graph.innerHTML = ""

    fetch(url)
        .then(response => {
            if (!response.ok) {
                throw new Error('Requisição errada');
            }
            return response.json();
        })
        .then(data => {
            function drawChart() {

                // Create the data table.
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Topping');
                data.addColumn('number', 'Slices');
                data.addRows([
                ['Mushrooms', 3],
                ['Onions', 1],
                ['Olives', 1],
                ['Zucchini', 1],
                ['Pepperoni', 2]
                ]);
            
                // Set chart options
                var options = {'title':'Relatório de Tickets',
                            'width':400,
                            'height':300,
                            'pieHole': 0.4
                            };
            
                // Instantiate and draw our chart, passing in some options.
                var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
                chart.draw(data, options);
            }
        })
}