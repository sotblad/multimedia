function mydctRun = mydctRun()
  pkg load image;
  pkg load signal;
  random8x8 = rand(8);

  printf("mydct2 =\n");
  mydct2(random8x8)
  printf("dct2 =\n");
  dct2(random8x8)
endfunction