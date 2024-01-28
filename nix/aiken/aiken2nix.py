#!/usr/bin/env python3

import json
import subprocess
import sys
import tomllib

res = {}

def nix_prefetch_url(url):
    return subprocess.run(
        ["nix-prefetch-url", "--unpack", "--type", "sha256", url],
        check=True,
        capture_output=True,
        text=True,
    ).stdout.strip()

def to_sri(h):
    return subprocess.run(
        ["nix", "hash", "to-sri", "--type", "sha256", h],
        check=True,
        capture_output=True,
        text=True,
    ).stdout.strip()

with open('aiken.lock', 'rb') as f:
    data = tomllib.load(f)
    for p in data['requirements']:
        raw_name = p['name']
        name = raw_name.replace('/', '-')
        rev = p['version']
        match p['source']:
            case "github":
                url = f'https://github.com/{raw_name}/archive/{rev}.tar.gz'
                hash = to_sri(nix_prefetch_url(url))
                res[name] = {
                    'url': url,
                    'hash': hash,
                }
            case unknown:
                print(f"Unknown source type: '{unknown}'")
                sys.exit(1)

with open("aiken-nix.lock", "w") as f:
    json.dump(res, f, indent=2)
