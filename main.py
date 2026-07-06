from ast2json import str2json
import json
import typer
from pathlib import Path

app = typer.Typer()

@app.command()
def hello():
    """Hello World"""
    print("hello world")

@app.command()
def to_json(file_path : str):
    p = Path()
    path = p.cwd() / file_path
    with open(path, mode="r") as file:
        content = file.read()
        json_obj = str2json(content)
        print(json.dumps(json_obj))

if __name__ == "__main__":
    app()
    
