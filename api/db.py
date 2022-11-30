import sqlite3

def connect_to_db():
    conn = sqlite3.connect('database.db')
    return conn
def create_db_table():
    try:
        conn = connect_to_db()
        conn.execute('''DROP TABLE IF EXISTS users;''')
        conn.execute('''
            CREATE TABLE users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                username TEXT NOT NULL,
                email TEXT NOT NULL,
                password TEXT NOT NULL
            );
        ''')

        conn.commit()
        print("User table created successfully")
    except:
        print("User table creation failed - Maybe table")
    finally:
        conn.close()


def insert_user(user):
    print(user)
    print(type(user))
    inserted_user = {}
    try:
        conn = connect_to_db()
        cur = conn.cursor()
        cur.execute("INSERT INTO users (username, email, password) VALUES (?, ?, ?)", (user['username'], user['email'], user['password']) )
        conn.commit()
        inserted_user = get_user_by_id(cur.lastrowid)
    except:
        conn().rollback()

    finally:
        conn.close()
    print("Inserted user:", inserted_user)
    return inserted_user


def get_user_by_id(user_id):
    user = {}
    try:
        conn = connect_to_db()
        conn.row_factory = sqlite3.Row
        cur = conn.cursor()
        cur.execute("SELECT * FROM users WHERE id = ?", (user_id,))
        row = cur.fetchone()

        # convert row object to dictionary
        user["id"] = row["id"]
        user["username"] = row["username"]
        user["email"] = row["email"]
        user["password"] = row["password"]
    except Exception as e:
        print("Hit exception when returning user")
        print(e)
        user = {}

    return user


def get_user_by_email(email):
    user = {}
    try:
        conn = connect_to_db()
        conn.row_factory = sqlite3.Row
        cur = conn.cursor()
        cur.execute("SELECT * FROM users WHERE email = ?", (email,))
        row = cur.fetchone()

        # convert row object to dictionary
        user["id"] = row["id"]
        user["username"] = row["username"]
        user["email"] = row["email"]
        user["password"] = row["password"]
    except Exception as e:
        print("Hit exception when returning user")
        print(e)
        user = {}

    return user


def get_users():
    users = []
    try:
        conn = connect_to_db()
        conn.row_factory = sqlite3.Row
        cur = conn.cursor()
        cur.execute("SELECT * FROM users")
        rows = cur.fetchall()

        # convert row objects to dictionary
        for i in rows:
            user = {}
            user["id"] = i["id"]
            user["username"] = i["username"]
            user["email"] = i["email"]
            user["password"] = i["password"]
            users.append(user)

    except:
        print("Exception encountered when retrieving users")
        users = []

    return users