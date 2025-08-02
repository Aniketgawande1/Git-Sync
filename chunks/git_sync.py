import typer 
from git import Repo
from rich import print

app = typer.Typer(help="git automation tools")


@app.command()
def auto_commit(message: str = typer.Option(..., help="Commit message")):
    repo = Repo(".")
    repo.git.add(A=True)
    repo.index.commit(message)
    origin = repo.remote(name='origin')
    origin.push()
    print("[green]✅ code is commited and pushed ![/green]")