from fastapi import FastAPI
import joblib
from pydantic import BaseModel
import numpy as np
from sklearn.cluster import KMeans

app = FastAPI()

model = joblib.load('kmeans_model.pkl')
scaler = joblib.load('robust_scaler.pkl')

class HealthData(BaseModel):
  steps: int
  calories: float
  lightsleep: float
  deepsleep: float
  remsleep: float
  awakesleep: float
  mean_hr: float
  max_hr: float
  min_hr: float

@app.get('/')
def home():
  return {"message": "Mentis AI API está no ar"}

@app.post('/predict')
async def predict_status(data: HealthData):
  input_data = np.array([[
    data.steps, 
    data.calories, 
    data.lightsleep, 
    data.deepsleep, 
    data.remsleep, 
    data.awakesleep, 
    data.mean_hr, 
    data.min_hr, 
    data.max_hr
  ]])
  
  input_scaled = scaler.transform(input_data)
  
  prediction = model.predict(input_scaled)

  cluster_index = int(prediction[0])
  
  riscos = {
    1: "Baixo",
    2: "Moderado-Baixo",
    0: "Moderado-Alto",
    3: "Alto"
  }

  return {
    "cluster_principal": cluster_index,
    "nivel_risco": riscos.get(cluster_index, "Desconhecido"),
    "status": "sucesso"
  }