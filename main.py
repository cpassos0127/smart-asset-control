
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import databases

# Altere aqui para seu banco (PostgreSQL ou MySQL 8+)
DATABASE_URL = "mysql+pymysql://user:password@localhost:3306/seubanco"
# DATABASE_URL = "postgresql+asyncpg://user:password@localhost:5432/seubanco"

database = databases.Database(DATABASE_URL)

app = FastAPI()

class CaminhoAtivo(BaseModel):
    id: int
    nome: str
    tipo: str
    nivel: int
    caminho: str

class AtivoIn(BaseModel):
    nome: str
    tipo: str
    codigo: str
    ativo_pai_id: int | None = None
    nivel: int

class OrdemServicoIn(BaseModel):
    ativo_id: int
    descricao: str
    status: str

@app.on_event("startup")
async def startup():
    await database.connect()

@app.on_event("shutdown")
async def shutdown():
    await database.disconnect()

@app.get("/ativos/{id}/caminho", response_model=list[CaminhoAtivo])
async def get_caminho_ate_raiz(id: int):
    query = """
    WITH RECURSIVE caminho_ativo AS (
      SELECT 
        id,
        nome,
        tipo,
        codigo,
        ativo_pai_id,
        nivel,
        CAST(nome AS CHAR(1000)) AS caminho
      FROM ativos
      WHERE id = :id

      UNION ALL

      SELECT 
        a.id,
        a.nome,
        a.tipo,
        a.codigo,
        a.ativo_pai_id,
        a.nivel,
        CONCAT(a.nome, ' ← ', c.caminho) AS caminho
      FROM ativos a
      INNER JOIN caminho_ativo c ON c.ativo_pai_id = a.id
    )
    SELECT id, nome, tipo, nivel, caminho FROM caminho_ativo ORDER BY nivel;
    """
    rows = await database.fetch_all(query=query, values={"id": id})
    if not rows:
        raise HTTPException(status_code=404, detail="Ativo não encontrado")
    return rows

@app.get("/ativos/{id}/filhos")
async def get_filhos(id: int):
    query = "SELECT * FROM ativos WHERE ativo_pai_id = :id"
    rows = await database.fetch_all(query=query, values={"id": id})
    return rows

@app.post("/ativos")
async def create_ativo(ativo: AtivoIn):
    query = """
    INSERT INTO ativos (nome, tipo, codigo, ativo_pai_id, nivel)
    VALUES (:nome, :tipo, :codigo, :ativo_pai_id, :nivel)
    """
    await database.execute(query=query, values=ativo.dict())
    return {"message": "Ativo criado com sucesso"}

@app.post("/os")
async def create_ordem_servico(os_data: OrdemServicoIn):
    query = """
    INSERT INTO ordens_servico (ativo_id, descricao, status)
    VALUES (:ativo_id, :descricao, :status)
    """
    await database.execute(query=query, values=os_data.dict())
    return {"message": "Ordem de Serviço criada com sucesso"}
