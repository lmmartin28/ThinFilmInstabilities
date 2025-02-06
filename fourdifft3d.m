    function Dmf = fourdifft3d(f,m)

% Dmf = fourdifft(f,m) computes the m-th derivative of the function
% f(x) using the Fourier differentiation process.   The function 
% is assumed to be 2pi-periodic and the input data values f should 
% correspond to samples of the function at N equispaced points on [0, 2pi).
% The Fast Fourier Transform is used.
% 
%  Input:
%  f:      Vector of samples of f(x) at x = 0, 2pi/N, 4pi/N, ... , (N-1)2pi/N
%  m:      Derivative required (non-negative integer)
%
%  Output:
%  Dmf:     m-th derivative of f
%
%  S.C. Reddy, J.A.C. Weideman 2001

     f = f(:,:); 
     %size(f,1)
     %size(f,2)% Make sure f is a 2D matrix
     N = size(f,2);                    % Evaluate the length of the matrix columns to fit the 1D framework
     
%For fourier transform along 2D there will be a matrix input instead of a column input
%In the second direction, you will have to transpose the matrix before fft,
%because the fft function treats the columns of f as vectors and returns
%the fourier transform of each column. Dont forget to retranspose after
%fft.% probably no need to adapt the function other than allow it to
%manipulate matrix instead of columns. Then the direction of differentiation
%is determined by whether or not we transpose before differentiating.
     N1 =  floor((N-1)/2);           % Set up wavenumbers           
     N2 = (-N/2)*(rem(m,2)==0)*ones(rem(N,2)==0);
     wave = [(0:N1)  N2 (-N1:-1)]';     %wave is a column vector

   % ((1i*wave).^m).*fft(f) is a column vector
   
Dmf = ifft(((1i*wave).^m).*fft(f));   % Transform to Fourier space, take deriv,
                                     % and return to physical space.

if max(abs(imag(f))) == 0; Dmf = real(Dmf); end  % Real data in, real derivative out
