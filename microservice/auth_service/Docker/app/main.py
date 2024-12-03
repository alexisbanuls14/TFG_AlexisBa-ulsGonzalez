# app/main.py
from fastapi import FastAPI, Depends, HTTPException, status, Query
from sqlalchemy.orm import Session
from .database import Base, engine, get_db
from .models import User
from .auth import get_password_hash, verify_password, create_access_token, verify_token
from pydantic import BaseModel


app = FastAPI()

# Crear las tablas en la base de datos
Base.metadata.create_all(bind=engine)

# Esquemas de Pydantic para entrada y salida
class UserCreate(BaseModel):
    username: str
    password: str

class UserLogin(BaseModel):  # Esquema para login
    username: str
    password: str

class Token(BaseModel):
    access_token: str
    token_type: str

@app.post("/register", response_model=Token)
def register(user: UserCreate, db: Session = Depends(get_db)):
    db_user = db.query(User).filter(User.username == user.username).first()
    if db_user:
        raise HTTPException(status_code=400, detail="Username already registered")
    
    hashed_password = get_password_hash(user.password)
    new_user = User(username=user.username, hashed_password=hashed_password)
    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    access_token = create_access_token(data={"sub": new_user.username})
    return {"access_token": access_token, "token_type": "bearer"}

@app.post("/login", response_model=Token)
async def login(user: UserLogin, db: Session = Depends(get_db)):
    # Buscar usuario en la base de datos
    db_user = db.query(User).filter(User.username == user.username).first()
    if not db_user:
        raise HTTPException(status_code=400, detail="User not found")

    # Verificar contraseña
    if not verify_password(user.password, db_user.hashed_password):
        raise HTTPException(status_code=400, detail="Incorrect password")
    
    # Generar token
    access_token = create_access_token(data={"sub": db_user.username})
    return {"access_token": access_token, "token_type": "bearer"}

@app.get("/verify-token")
def verify_token_route(token: str = Query(...)):
    username = verify_token(token)
    if not username:
        raise HTTPException(status_code=401, detail="Token is invalid or expired")
    return {"message": f"Token is valid for user {username}"}
