import pathlib

WORKSPACE_PATH = pathlib.Path(__file__).parents[0].resolve()
print(__file__)
print(WORKSPACE_PATH)