# git_sync/cli.py
import click
import yaml
import sys
from git_sync.core import sync_repo

@click.command()
@click.option('--config', default='config.yaml', help='Path to config YAML file')
def cli(config):
    try:
        with open(config, 'r') as f:
            cfg = yaml.safe_load(f)
    except FileNotFoundError:
        click.echo(f"❌ Config file not found: {config}")
        sys.exit(1)
    except yaml.YAMLError as e:
        click.echo(f"❌ Invalid YAML in config file: {e}")
        sys.exit(1)
    
    if 'repos' not in cfg:
        click.echo("❌ No 'repos' section found in config file")
        sys.exit(1)
    
    success_count = 0
    total_count = len(cfg['repos'])
    
    for repo in cfg['repos']:
        try:
            print(f"\n🔁 Syncing: {repo['path']}")
            sync_repo(
                path=repo['path'],
                upstream=repo['upstream'],
                branch=repo['branch'],
                auto_push=repo.get('auto_push', False)
            )
            print(f"✅ Successfully synced: {repo['path']}")
            success_count += 1
        except Exception as e:
            print(f"❌ Failed to sync {repo['path']}: {str(e)}")
            continue
    
    print(f"\n📊 Summary: {success_count}/{total_count} repositories synced successfully")
    
    if success_count < total_count:
        sys.exit(1)

if __name__ == '__main__':
    cli()
