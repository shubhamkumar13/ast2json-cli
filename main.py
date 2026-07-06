from posixpath import defpath
import pathlib
from posix import mkdir
from ast2json import str2json
import json
import typer
from pathlib import Path

app = typer.Typer()

@app.command()
def to_json(file_path : str):
    """
        TYPE : String -> File Json
        consumes a valid string and creates a json file
    """
    # current path
    path = Path('.').cwd() / file_path
    file_name = path.name
    json_file_dir = Path('.').cwd() / 'ast2json'
    # check if parents exist and we are not recreating the directory
    json_file_dir.mkdir(parents=True, exist_ok=True)
    # use the same file name to generate the ast json
    json_file_path = json_file_dir / f'{file_name}.json'
    with open(path, mode="r") as file:
        content = file.read()
        json_obj = str2json(content)
        with open(json_file_path, mode="w+") as json_file:
            json.dump(json_obj, json_file)

if __name__ == "__main__":
    app()
    
