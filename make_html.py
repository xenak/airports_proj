def write_to_html_file(df, bad, filename='out.html'):
    '''
    Write an entire dataframe to an HTML file with nice formatting.
    '''

    result = '''
<html>
<head>
<title>Airport Weather Condition</title>
<link href='https://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet'>
<style>
    body {
        background-color: #F9F9F9;
        font-family: 'Montserrat';font-size: 22px;
    }
    h1 {
        text-align: center;
        color = #606060;
    }
    h2 {
        text-align: center;
        color = #606060;
    }
    table { 
        margin-left: auto;
        margin-right: auto;
        background-color: white;
    }
    table, th, td {
        border-bottom: 1px solid #F5F5F5;
        border-top: 1px solid #F5F5F5;
        border-left: 0px solid white;
        border-right: 0px solid white;
        border-collapse: collapse;
    }
    th, td {
        padding: 5px;
        text-align: center;
        font-family: Helvetica, Arial, sans-serif;
        font-size: 95%;
    }
    table tbody tr:hover {
        background-color: #F9F9F9;
    }
    .wide {
        width: 90%; 
    }
    table tr:nth-child(-n+{{bad}}){
        background-color: #FFC4E8;
    }
    table th{
        background-color: #606060;
        color: white;
    }

</style>

    <h1> Airport Weather Condition </h1>\n
    <h2> <span style="color: #FF89D2"> 
        {{bad}} out of 29  </span> airports are in danger. Be careful! 
    </h2>\n

</head>
<body>
    '''
    result += df.to_html(classes='wide', escape=False,index=False)
    result += '''
</body>
</html>
'''
    with open(filename, 'w') as f:
        f.write(result)
