from sqlalchemy import create_engine

DB_CONFIG = {
    "user": "crypto_user",
    "password": "crypto_pass",
    "host": "localhost",
    "port": "5432",
    "database": "crypto_dw"
}

def get_engine():
    url = (
        f"postgresql://{DB_CONFIG['user']}:{DB_CONFIG['password']}"
        f"@{DB_CONFIG['host']}:{DB_CONFIG['port']}/{DB_CONFIG['database']}"
    )
    return create_engine(url)