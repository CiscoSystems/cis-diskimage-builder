#!/usr/bin/env python

import yaml
cloudcfg = "/etc/cloud/cloud.cfg"
user = "cloud-user"

with open(cloudcfg) as f:
  cfg = yaml.load(f)

print cfg['system_info']['default_user']['name']
if cfg['system_info']['default_user']['name'] == user:
  print("No change needed")
  exit()
else:
  # Change the user to cloud-user
  cfg['system_info']['default_user']['name'] = user
  cfg['system_info']['default_user']['gecos'] = "Cloud User"
  print cfg['system_info']['default_user']['name']


with open(cloudcfg, "w") as f:
  yaml.dump(cfg, f, default_flow_style=False)
