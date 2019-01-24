<!doctype html>
<html lang="{{ app()->getLocale() }}">
    <head>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
            google.charts.load('current', {'packages':['corechart']});
            google.charts.setOnLoadCallback(drawChart);

            function drawChart() {
                var data = google.visualization.arrayToDataTable([
                    ['Year', 'Sales'],
                    ['2004',  1000,      400],
                      ['2005',  1170,      460],
                      ['2006',  660,       1120],
                      ['2007',  1030,      540]
                ]);

                var options = {
                    title: 'Company Performance',
                    curveType: 'function',
                    legend: { position: 'bottom' }
                };

                var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

                chart.draw(data, options);
            }
    </script>
  </head>
  <body>
    @if(Session::has('token'))
    <select>
        <option>Bulan</option>
        <option>januari</option>
        <option>februari</option>
        <option>maret</option>
        <option>april</option>
        <option>mei</option>
        <option>juni</option>
        <option>juli</option>
        <option>agustus</option>
        <option>september</option>
        <option>oktober</option>
        <option>november</option>
        <option>desember</option>
    </select>
    <div id="curve_chart" style="width: 900px; height: 500px"></div>
    @else
    <form action="{{ url('/login')}}" method="post">
        {{ csrf_field() }}
      <div class="container">
        <label for="uname"><b>Username</b></label>
        <input type="text" placeholder="Enter Username" name="email" required>

        <label for="psw"><b>Password</b></label>
        <input type="password" placeholder="Enter Password" name="password" required>

        <button type="submit">Login</button>
      </div>

    </form>
    @endif
  </body>
</html>
