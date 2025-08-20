# git_sync/core.py
import subprocess
import os
import sys

def run(cmd):
    print(f"▶️ {cmd}")
    try:
        # For git commands, show real-time output
        result = subprocess.run(cmd, shell=True, check=True, timeout=30)
        return result
    except subprocess.TimeoutExpired:
        print(f"⏰ Command timed out after 30 seconds: {cmd}")
        raise
    except subprocess.CalledProcessError as e:
        print(f"❌ Command failed: {cmd}")
        raise

def sync_repo(path, upstream, branch, auto_push):
    # Validate path exists and is a git repo
    if not os.path.exists(path):
        raise ValueError(f"Path does not exist: {path}")
    
    if not os.path.exists(os.path.join(path, '.git')):
        raise ValueError(f"Not a git repository: {path}")
    
    # Save current directory to restore later
    original_dir = os.getcwd()
    
    try:
        os.chdir(path)
        
        # Check if git is available
        try:
            subprocess.run("git --version", shell=True, check=True, capture_output=True)
        except subprocess.CalledProcessError:
            raise RuntimeError("Git is not installed or not available in PATH")
        
        run("git fetch origin")
        
        # Check if upstream remote exists and has correct URL
        remotes = subprocess.run("git remote -v", shell=True, capture_output=True, text=True, timeout=10)
        upstream_exists = False
        for line in remotes.stdout.split('\n'):
            if line.startswith('upstream'):
                if upstream in line:
                    upstream_exists = True
                    break
                else:
                    # Upstream exists but with different URL, update it
                    run(f"git remote set-url upstream {upstream}")
                    upstream_exists = True
                    break
        
        if not upstream_exists:
            run(f"git remote add upstream {upstream}")

        run("git fetch upstream")
        run(f"git checkout {branch}")
        run(f"git rebase upstream/{branch}")
        
        if auto_push:
            # Use force-with-lease for safer force push after rebase
            run(f"git push --force-with-lease origin {branch}")
            
    except Exception as e:
        print(f"❌ Error syncing {path}: {str(e)}")
        raise
    finally:
        # Always restore original directory
        os.chdir(original_dir)
