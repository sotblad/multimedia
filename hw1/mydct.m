function mydct = mydct(f)
  % g(x)
  g = g(f);
  printf("g(x) =\n");
  g
  % G(u)
  G = fft(g);
  printf("G(u) =\n");
  G
  
  N = columns(f);
  mydct = zeros(N);
  for u = 1:columns(f)
    u = u-1;
    wa = w(u, N);
    mydct(u+1) = (wa*G(u+1)*(e^((-j*pi*u)/(2*N))))/2;
  endfor
  F = mydct;
  printf("F(u) =\n");
  F
endfunction

function mydct = mydctRun(x)
  N = length(x);
  mydct = zeros(rows(x),columns(x));
  for i = 1:rows(x)
    for j = 1:columns(x)
      w = 0;
      if i-1 == 0
        w = 1/sqrt(N);
      else
        w = sqrt(2/N);
      endif
      mydct(i,j) = w*cos((((2*(j-1))+1)*pi*(i-1))/(2*N));
    endfor
  endfor
endfunction

function w = w(u,N)
  w = sqrt(2/N);
  ind = u == 0;
  w(ind) = 1/sqrt(N);
endfunction

function g = g(f)
  N = size(f)(2);
  
  % g(x)
  g = [f];
  for i = N:-1:1
    g = [g f(i)];
  endfor
endfunction
