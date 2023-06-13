cd;
cd Documents/Innotech;
echo 'enter a folder name';
read folder_name;
mkdir $folder_name;
cd $folder_name;
mkdir python;
touch python/dbcreds.py;
echo 'enter DB name';
read db_input;
echo "conn_params = {

    'user':'root',
    'password': 'password',
    'host': 'localhost',
    'port': 3306,
    'database': '$db_input'

}" >> python/dbcreds.py;
touch python/app.py;
echo 'Enter proceedure name';
read proceedure;
echo 'Enter api endpoint';
read api_endpoint;
echo 'Enter function name';
read function;
echo "#importing
import json
from flask import Flask,request, make_response, jsonify
import dbhelper, api_helper
app = Flask(__name__)

@app.post('$api_endpoint')
#function gets called on api request
def $function():
   try:
      #calls the function in api_helper to loop through the information sent
         error=api_helper.check_endpoint_info(request.json, ['']) 
         if(error !=None):
            return make_response(jsonify(error), 400)
         #calls the proceedure to insert sent information into the DB
         results = dbhelper.run_proceedure('CALL $proceedure(?)', [request.json.get('')])
         #returns results from db run_proceedure
         if(type(results) == list):
            return make_response(jsonify(results), 200)
         else:
            return make_response(jsonify('something how gone wrong'), 500)

   except TypeError:
      print('Invalid entry, try again')
      
   except: 
      print("something went wrong")

#running @app
app.run(debug=True)" >> python/app.py;
touch .gitignore;
echo "venv/
dbcreds.py" >> .gitignore;
touch python/dbhelper.py;
echo "import mariadb
import dbcreds
#makes returned data look nicer
def convert_data(cursor, results):
    column_names = [i[0] for i in cursor.description]
    new_results = []
    for row in results:
        new_results.append(dict(zip(column_names, row)))
    return new_results

#function that gets called on each request using args based on which request was called
def run_proceedure(sql, args):
    try:
        #connecting to the DB/making results = None so if it does become defined by following code, it will end the connection.
        results = None
        conn = mariadb.connect(**dbcreds.conn_params)
        cursor = conn.cursor()
        cursor.execute(sql, args)
        results = cursor.fetchall()
        results = convert_data(cursor, results)
        #catching errors and diagnosing them
    except mariadb.ProgrammingError as error:
        print('There is an issue with the DB code: ', error)
    except mariadb.OperationalError as error:
        print('DB connection issue: ',error)
    except Exception as error:
        print('Unknown error: ', error)
    finally:
        if(cursor !=None):
            cursor.close()
        if(conn !=None):
            conn.close()
            #returing the results from cursor.fetchall()
        return results
" >> python/dbhelper.py;

touch python/api_helper.py;
echo "def check_endpoint_info(sent_data, expected_data):
    try:    
        for data in expected_data:
            if(sent_data.get(data) == None):
                return f'the {data} must be sent!'
    except TypeError:
        print('Invalid entry. (how could this happen?)')
    except:
        print('Something went wrong with endpoint info check.')" >> python/api_helper.py;
touch readme.md;
echo 'enter readme text';
read readme_text;
echo "$readme_text" >> readme.md;

echo 'creating python virtual environment';
python3 -m venv venv;
source venv/bin/activate
echo 'installing flask and mariadb';
pip install flask;
pip install mariadb;

echo 'enter personal auth token';
read auth_token
curl \-X POST -H "Accept: application/vnd.github+json" -H "Authorization: token $auth_token" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/user/repos -d "{\"name\": \"$1\" }"
git init;
git add -A;
git commit -m "first commit";
git branch -M main;
git remote add origin "https://github.com/NuckenMcFuggets/$1.git";
git push -u origin main;