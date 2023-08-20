#!/bin/env python3
import numpy as np
import sys


volt_column = sys.argv[1]

volt_column = np.fromstring(volt_column, dtype=np.float16, sep=" ")
mean_volts = np.mean(volt_column)

print(mean_volts)
