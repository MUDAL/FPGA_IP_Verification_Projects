# Author: Olaoluwa Raji
# Date:   04/11/2026

# FFT golden model.

import numpy as np
from   scipy.fft import fft

FFT_LENGTH = 8
NUM_INPUTS = FFT_LENGTH * 100
MAX_VALUE  = np.pow(2,10) - 1

input_data = np.random.randint(MAX_VALUE, size=NUM_INPUTS)

with open("inputs.txt", "w") as f_input:
    f_input.writelines(np.strings.mod("%d\n", input_data))

fft_data = np.zeros(NUM_INPUTS, dtype=complex)
index = 0

for i in range(round(NUM_INPUTS/FFT_LENGTH)):
    fft_data[index:index+FFT_LENGTH] = fft(input_data[index:index+FFT_LENGTH])
    index = index + FFT_LENGTH

with open("outputs.txt", "w") as f_output:
    real_data2str = np.strings.mod("%d ",  np.round(fft_data.real))
    imag_data2str = np.strings.mod("%d\n", np.round(fft_data.imag))
    f_output.writelines(real_data2str + imag_data2str)