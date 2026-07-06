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
def to_json(path : str):
    cwd = Path(".")
    print(cwd)
    path = cwd / path
    with open(path, mode="r") as file:
        content = file.read()
        json_obj = str2json(content)
        return json.dumps(json_obj)

if "__name__" == "__main__":
    ast_str = app()
    print(ast_str)