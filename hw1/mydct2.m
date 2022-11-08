function mydct2 = mydct2(f)
  mydct2 = [];
  
  mydct2rows = [];
  for i = 1:rows(f)
    mydct2rows = [mydct2rows; mydct1d(f(i,:))];
  endfor
  
  
  mydct2columns = [];
  for i = 1:columns(mydct2rows)
    mydct2columns = [mydct2columns; mydct1d(mydct2rows(:,i)')];
  endfor
  mydct2 = mydct2columns';
endfunction