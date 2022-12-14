import hashlib
from db import create_db_table, get_user_by_email, insert_user, get_users
from flask import Flask, request, jsonify
from flask_cors import CORS

users = []
string = "Test123!"
hash = hashlib.sha256(string.encode()).hexdigest()
test_user = {
    "username": "jdoe",
    "email": "johndoe@gamil.com",
    "password": hash,
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
@app.route('/api/users', methods=['GET'])
def api_get_users():
    return jsonify(get_users())
if __name__ == "__main__":
    #app.debug = True
    #app.run(debug=True)
    app.run()
    print(get_users())