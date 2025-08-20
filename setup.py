# setup.py
from setuptools import setup, find_packages

setup(
    name='git-sync-cli',
    version='1.0.0',
    packages=find_packages(),
    install_requires=[
        'click',
        'PyYAML',
    ],
    entry_points={
        'console_scripts': [
            'git-sync = git_sync.cli:cli',
        ],
    },
    python_requires='>=3.6',
)
