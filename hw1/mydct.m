% Sotirios Panagiotou, 4456

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
  for u = 1:columns(f)
    u = u-1;
    wa = w(u, N);
    mydct(u+1) = (wa*G(u+1)*(e^((-j*pi*u)/(2*N))))/2;
  endfor
  F = mydct;
  printf("F(u) =\n");
  F
endfunction

function g = g(f)
  N = size(f)(2);

  g = [f];
  for i = N:-1:1 % mirroring gia ton 2o klado
    g = [g f(i)];
  endfor
endfunction

function w = w(u,N)
  w = sqrt(2/N);
  ind = u == 0;
  w(ind) = 1/sqrt(N);
endfunction
