import  typer
import psutil
from rich import print

app = typer.Typer(help="System Resources Checker")

@app.command()
def health():
    print(f"[bold green]CPU Usage:[/bold green] {psutil.cpu_percent()}%")
    print(f"[bold green]Memory Usage:[/bold green] {psutil.virtual_memory().percent}%")
    print(f"[bold green]Disk Usage:[/bold green] {psutil.disk_usage('/').percent}%")
