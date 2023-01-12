import os
import psycopg2
import json
from flask import Flask

app = Flask(__name__)

def get_db_connection():
    try:
        conn = psycopg2.connect(host="localhost",
    	database="P_final",
        user=os.environ['DB_USERNAME'],
		password=os.environ['DB_PASSWORD'])
    except psycopg2.Error as err:
        print('Unable to connect to database!')
        print('Error:', err)
        return None
    else:
        print('Connected!')
        return conn
    
@app.route('/average/')
def average():
    conn = get_db_connection()
    if conn != None:
        cur = conn.cursor()
        try:
            cur.execute('SELECT AVG(Tiempo) AS average '
                        'FROM Participantes'
                        'GROUP BY C_carrera')
        except psycopg2.Error as err:
            print('Error:', err)
            return {'ERRORCODE': err.pgcode, 'ERROR': err.diag.message_primary}
        else:
            avg = cur.fetchone()[0]
            return {'average': avg}
    else:
        return {'ERROR': 'Unable to connect to database'}

@app.route('/min/')
def average():
    conn = get_db_connection()
    if conn != None:
        cur = conn.cursor()
        try:
            cur.execute('SELECT MIN(AVG(Tiempo)) AS minimun_average '
                        'FROM Participantes'
                        'GROUP BY C_carrera')
        except psycopg2.Error as err:
            print('Error:', err)
            return {'ERRORCODE': err.pgcode, 'ERROR': err.diag.message_primary}
        else:
            minavg = cur.fetchone()[0]
            return {'minimun_average': minavg}
    else:
        return {'ERROR': 'Unable to connect to database'}