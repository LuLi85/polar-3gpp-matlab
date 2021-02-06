%message len
EsN0 = 2.5;
len = 20;
a = round(rand(1,len));
%
G = 44;

%why CRC length is 11 ?
%how to get 3gpp N (2^N)? if E , else N
%how to under stand the rate_match sequence , and how to achieve rate_match sequence use three modes:
%  'repetition', 'puncturing' or 'shortening'
%   rate_matching_pattern will be a row vector comprising E number of
%   integers, each having a value in the range 1 to N. Each integer
%   identifies which one of the N outputs from the polar encoder kernal
%   provides the corresponding bit in the encoded bit sequence.

f = PUCCH_encoder(a,G);

% QPSK modulation
f2 = [f,zeros(1,mod(-length(f),2))];
tx = sqrt(1/2)*(2*f2(1:2:end)-1)+1i*sqrt(1/2)*(2*f2(2:2:end)-1);

N0 = 1/(10^(EsN0/10));
% Simulate transmission
rx = tx + sqrt(N0/2)*(randn(size(tx))+1i*randn(size(tx)));

% QPSK demodulation
f2_tilde = zeros(size(f2));
f2_tilde(1:2:end) = -4*sqrt(1/2)*real(rx)/N0;
f2_tilde(2:2:end) = -4*sqrt(1/2)*imag(rx)/N0;
f_tilde = f2_tilde(1:length(f));

% Perform polar decoding
L = 4;
min_sum = true;

%how should receiver konw the 'len'?
a_hat = PUCCH_decoder(f_tilde,len,L,min_sum);
