from setuptools import setup, find_packages

setup(
    name="git-sync",
    version="1.0.0",
    py_modules=['cli'],
    packages=find_packages(),
    install_requires=[
        "typer",
        "rich",
        "gitpython",
        "psutil"
    ],
    entry_points={
        "console_scripts": [
            "git-sync=cli:app"
        ]
    },
)
