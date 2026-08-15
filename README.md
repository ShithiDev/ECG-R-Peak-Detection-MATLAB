# ECG R-Peak Detection and Heart Rate Estimation using MATLAB

## Overview

This project implements a basic ECG signal-processing pipeline in MATLAB to detect R-peaks and estimate heart rate from an ECG recording.

## Dataset

ECG data were obtained from the MIT-BIH Arrhythmia Database available through PhysioNet.

- Record: 100
- Sampling frequency: 360 Hz
- Two ECG channels are available in the recording
- Channel 1 was used for the analysis

Dataset: https://physionet.org/content/mitdb/

## Signal Processing Method

The ECG signal was processed using the following steps:

1. Read and decode the ECG signal from the MIT-BIH record.
2. Apply a 5–15 Hz Butterworth band-pass filter.
3. Differentiate the filtered signal to emphasize rapid QRS changes.
4. Square the differentiated signal.
5. Apply moving-window integration.
6. Detect QRS peaks using an amplitude threshold and minimum peak distance.
7. Calculate RR intervals and heart rate from the detected peaks.

## Heart Rate Calculation

RR intervals were calculated from consecutive detected R-peaks:

RR = difference between consecutive R-peak locations / sampling frequency

Heart rate was then calculated as:

HR = 60 / RR

The mean heart rate was calculated from all detected beats.

## Result

The detected R-peaks are marked with red circles on the ECG signal.

![Detected R-Peaks](ECG_R_Peak_Result.png)

## Tools

- MATLAB
- Signal Processing Toolbox
- MIT-BIH Arrhythmia Database

## Skills Demonstrated

- ECG signal processing
- Digital filtering
- QRS/R-peak detection
- RR interval calculation
- Heart rate estimation
- MATLAB signal analysis

## Author

Shithi Dev  
M.Sc. Biomedical Engineering  
TU Wien
