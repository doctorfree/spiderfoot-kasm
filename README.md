<a href="https://www.spiderfoot.net/r.php?u=aHR0cHM6Ly93d3cuc3BpZGVyZm9vdC5uZXQv&s=os_gh"><img src="https://www.spiderfoot.net/wp-content/themes/spiderfoot/img/spiderfoot-wide.png"></a>



[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/smicallef/spiderfoot/master/LICENSE)
[![Python Version](https://img.shields.io/badge/python-3.7+-green)](https://www.python.org)
[![Stable Release](https://img.shields.io/badge/version-4.0-blue.svg)](https://github.com/smicallef/spiderfoot/releases/tag/v4.0)
[![CI status](https://github.com/smicallef/spiderfoot/workflows/Tests/badge.svg)](https://github.com/smicallef/spiderfoot/actions?query=workflow%3A"Tests")
[![Last Commit](https://img.shields.io/github/last-commit/smicallef/spiderfoot)](https://github.com/smicallef/spiderfoot/commits/master)
[![Codecov](https://codecov.io/github/smicallef/spiderfoot/coverage.svg)](https://codecov.io/github/smicallef/spiderfoot)
[![Twitter Follow](https://img.shields.io/twitter/follow/spiderfoot?label=follow&style=social)](https://twitter.com/spiderfoot)
[![Discord](https://img.shields.io/discord/770524432464216074)](https://discord.gg/vyvztrG)

**SpiderFoot** is an open source intelligence (OSINT) automation tool. It integrates with just about every data source available and utilises a range of methods for data analysis, making that data easy to navigate. 

SpiderFoot has an embedded web-server for providing a clean and intuitive web-based interface but can also be used completely via the command-line.  It's written in **Python 3** and **MIT-licensed**.

This forked version can be readily deployed to Kasm workspaces.

<img src="https://www.spiderfoot.net/wp-content/uploads/2022/04/opensource-screenshot-v4.png" />

Original Repo: [smicallef/spiderfoot](https://github.com/smicallef/spiderfoot)

## Deploy on Kasm Workspaces
- Build docker image
```
sudo docker build -t spiderfoot -f Dockerfile .
```

- Deploy on Kasm
In Kasm, go to "Workspaces", add a new workspace, and fill the docker image field as ***spiderfoot:latest*** and the rest of the fields as required. Click "save" and wait for the image to be available.