# app/database.py
import os
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Leer la URL de la base de datos desde las variables de entorno
#DATABASE_URL = os.getenv("DATABASE_URL")
DATABASE_URL = "sqlite:///./test.db"  # Para pruebas locales o variable de entorno

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
