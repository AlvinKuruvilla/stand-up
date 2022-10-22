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
                pass TEXT NOT NULL
            );
        ''')

        conn.commit()
        print("User table created successfully")
    except:
        print("User table creation failed - Maybe table")
    finally:
        conn.close()


def insert_user(user):
    inserted_user = {}
    try:
        conn = connect_to_db()
        cur = conn.cursor()
        cur.execute("INSERT INTO users (username, email, pass) VALUES (?, ?, ?)", (user['username'], user['email'], user['pass']) )
        conn.commit()
        inserted_user = get_user_by_id(cur.lastrowid)
    except:
        conn().rollback()

    finally:
        conn.close()

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
        user["pass"] = row["pass"]
    except:
        user = {}

    return 


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
        user["pass"] = row["pass"]
    except:
        user = {}

    return 