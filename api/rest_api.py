from db import create_db_table, get_user_by_email, insert_user
from flask import Flask, request, jsonify
from flask_cors import CORS

users = []
test_user = {
    "username": "jdoe",
    "email": "johndoe@gamil.com",
    "pass": "Test123!",
}
users.append(test_user)
create_db_table()

for i in users:
    print(insert_user(i))

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}})

@app.route('/api/users/<email>', methods=['GET'])
def api_get_user(email):
    return jsonify(get_user_by_email(email))

@app.route('/api/users/add',  methods = ['POST'])
def api_add_user():
    user = request.get_json()
    return jsonify(insert_user(user))
if __name__ == "__main__":
    #app.debug = True
    #app.run(debug=True)
    app.run()