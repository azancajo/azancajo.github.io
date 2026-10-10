"""Restore published files that predate the current Quarto source.

Quarto cleans docs/ on a project render. The files in _legacy_site/ are
still published URLs, so copy them back without replacing fresh output.
"""

from pathlib import Path
from shutil import copy2


project = Path(__file__).resolve().parent.parent
source = project / "_legacy_site"
output = project / "docs"

for original in source.rglob("*"):
    if not original.is_file():
        continue
    destination = output / original.relative_to(source)
    if not destination.exists():
        destination.parent.mkdir(parents=True, exist_ok=True)
        copy2(original, destination)
