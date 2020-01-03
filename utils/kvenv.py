import os
import sys
import subprocess
import re
import ruamel.yaml as yaml

env = os.environ.get('ENV', 'uat').lower()
valuespath = os.environ.get('VALUES_PATH', './deploy/values.yaml')
debug = os.environ.get('DEBUG', False)

with open(valuespath, "r") as f:
    envs = yaml.safe_load(f)['envs']
    for key, values in envs.items():
        value = values.get('uat', values['_default'])
        if "keyvault" in value:
            matches = re.search(
                '\${keyvault:(?P<keyvault>.+)/(?P<secret>.+)\}', value)
            kv = matches.group('keyvault')
            secret = matches.group('secret')
            p = subprocess.Popen(
                'az keyvault secret show --vault-name %s --name %s | jq .value'
                % (kv, secret),
                shell=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE)
            out, err = [
                entry.decode('utf-8').strip() for entry in p.communicate()
            ]
            if err:
                if debug:
                    sys.stderr.write("%s error: %s" % (key, err))
            else:
                value = out
        print('export %s=%s;' % (key, value))
