clear all
clc
f=360;
fdata=fopen('100.dat');
data=fread(fdata, [3,inf],"uint8");
fclose(fdata);
%decode the signal in actual signal value
sig1= bitshift(bitand(data(2,:),15),8)+data(1,:);
sig2=bitshift(data(3,:),4)+bitshift(data(2,:),-4);
sig1(sig1>2047)= sig1(sig1>2047)-4096;
sig2(sig2>2047)= sig2(sig2>2047)-4096;

%plot the raw signal
t=(0:length(sig1)-1)/f;
subplot(2,1,1); plot(t, sig1); title('Channel 1');
subplot(2,1,2); plot(t, sig2); title('Channel 2');

%QRS detection
w= [5 15]*2/f;
[a,b]=butter(3,w,'bandpass'); 
sig_filt=filtfilt(a,b, sig1); %apply filter

sig_diff=diff(sig_filt);
sig_sq=sig_diff.^2;
%moving window approach
win_size=round(0.15*f);
sig_int=conv(sig_sq, ones(1,win_size)/win_size, 'same');
%Peak Detection
peak_distance=round(0.25*f);
peak_height = mean(sig_int) + 0.7*std(sig_int);
[~,locs]=findpeaks(sig_int, "MinPeakHeight",peak_height, "MinPeakDistance",peak_distance);
%Heart beat calculation
RR=diff(locs)/f;
HR=60./RR;
mean_hr=mean(HR);
%Plot
figure;
subplot(2,1,1);
plot(t, sig1); hold on;
plot(locs/f, sig1(locs), 'ro', 'MarkerSize', 8);

subplot(2,1,2);
plot((0:length(sig_int)-1)/f, sig_int);

%%%%%%%%%%%%%%%%%%

% Plot first 10 seconds
N = 10*f;

figure
plot(t(1:N), sig1(1:N))
hold on

% R-peaks within first 10 seconds
p = locs(locs <= N);

plot(p/f, sig1(p), 'ro')

xlabel('Time (s)')
ylabel('Amplitude')
title('ECG with Detected R-Peaks')
grid on