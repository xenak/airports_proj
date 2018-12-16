import pandas as pd
import make_html as mh
from flask import Flask
from flask import render_template
app = Flask(__name__)


info=pd.read_csv('~/homework/info.csv', sep='\t') #собранные в script.sh данные
info=info.sort_values(by=['Status']) #сортировка по коду, чтобы проблемные аэропорты оказались в начале списка

bad = info.groupby('Status')['Airport'].nunique()['Be careful!'] #сколько аэропортов всего сейчас столкнулись с плохой погодой
info=info.drop(columns='Status')
mh.write_to_html_file(info,bad,'/home/xenak/homework/templates/page.html') #скрипт лежит отдельно в make_html.py; рендерит веб-страницу

@app.route('/')
def homepage():
    return render_template('page.html', bad=bad)

app.run('83.220.168.38', port=5008)
