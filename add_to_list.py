#!/usr/bin/env python3
import os
import sys

env_variable = sys.argv[1]
new_values = sys.argv[2:]
old_values = os.environ.get(env_variable, "")
if old_values == "":
    old_values = []
else:
    old_values = old_values.split(":")

for value in new_values:
    if value in old_values:
        old_values.remove(value)
new_values += old_values

print(":".join(new_values))
