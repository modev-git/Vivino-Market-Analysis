import sqlite3
from pathlib import Path

def get_db_path() -> Path:
    # Resolves the absolute path to the database file dynamically
    current_dir = Path(__file__).parent
    project_root = current_dir.parent
    
    return project_root / "data" / "vivino.db"

def execute_sql_file(sql_file_path: str) -> list:
    db_path = get_db_path()

    with open(sql_file_path, 'r') as file: 
        query = file.read()

    with sqlite3.connect(db_path) as conn: 
        # Establishes connection to database
        cursor = conn.cursor()
        # Maps column names from DB to results for easier fetching
        conn.row_factory = sqlite3.Row
        cursor.execute(query)
        results = cursor.fetchall()

    return results