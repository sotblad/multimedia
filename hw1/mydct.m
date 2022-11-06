function mydct = mydct()
  printf("aaaaaaaaaaaa\n");
endfunction
N = 10;
x = 0:N-1;

u1 = x;
function w = w(u1)
  global N
  w = sqrt(2/N);
  ind = u1 == 0;
  w(ind) = 1/sqrt(N);
endfunction

u2 = 0:((2*N)-1);
function Wn = Wn()
  global N
  Wn = e^(-j*((2*pi)/N));
endfunction

function g = g(x)
  if(x >= 0 && x <= N-1)
    g = f(x);
  elseif(x >= N && x <= (2*N)-1)
    g = f((2*N)-1-x);
  endif
endfunction
