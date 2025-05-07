
import gradio as gr
import sqlite3
from pathlib import Path

DB_FILE = Path("ativos_os.db")

def conectar():
    return sqlite3.connect(DB_FILE)

def cadastrar_ativo(nome, tipo, pai_id):
    conn = conectar()
    cursor = conn.cursor()
    cursor.execute("INSERT INTO ativos (nome, tipo, ativo_pai_id) VALUES (?, ?, ?)",
                   (nome, tipo, pai_id if pai_id else None))
    conn.commit()
    conn.close()
    return f"✅ Ativo '{nome}' cadastrado com sucesso."

def emitir_os(ativo_id, descricao):
    conn = conectar()
    cursor = conn.cursor()
    cursor.execute("INSERT INTO ordens_servico (ativo_id, descricao) VALUES (?, ?)", (ativo_id, descricao))
    conn.commit()
    conn.close()
    return f"✅ OS para ativo {ativo_id} emitida."

def listar_tudo(nome, tipo, pai_id, ativo_os_id, desc_os):
    res1 = cadastrar_ativo(nome, tipo, pai_id)
    res2 = emitir_os(ativo_os_id, desc_os)

    conn = conectar()
    ativos = conn.execute("SELECT * FROM ativos").fetchall()
    ordens = conn.execute("""
        SELECT os.id, a.nome, os.descricao, os.status
        FROM ordens_servico os
        JOIN ativos a ON os.ativo_id = a.id
    """).fetchall()
    conn.close()
    return res1, res2, ativos, ordens

gr.Interface(
    fn=listar_tudo,
    inputs=[
        "text",       # nome do ativo
        "text",       # tipo do ativo
        "number",     # ID pai
        "number",     # ID ativo para OS
        "text"        # descrição OS
    ],
    outputs=[
        "text",       # resultado 1
        "text",       # resultado 2
        "dataframe",  # ativos
        "dataframe"   # ordens
    ],
    title="Smart Asset Control - MVP"
).launch()
