import typer 

from chunks import git_butler, sys_check

app = typer.Typer(help="CLI for managing git sync and system checks.")

app.add_typer(git_butler.app, name="git")
app.add_typer(sys_check.app, name="sys")

if __name__ == "__main__":
    app()
