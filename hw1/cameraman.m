function cameraman = cameraman(n)
  pkg load image
  pkg load signal
  runCameraman(1);
  runCameraman(3);
  runCameraman(5);
endfunction

function runCameraman = runCameraman(n)
  Q = n*[16 11 10 16 24 40 51 61;
       12 12 14 19 26 58 60 55;
       14 13 16 24 40 57 69 56;
       14 17 22 29 51 87 80 62;
       18 22 37 56 68 109 103 77;
       24 35 55 64 81 104 113 92;
       49 64 78 87 103 121 120 101;
       72 92 95 98 112 100 103 99];
  % 2.1
  f = imread('cameraman.tif');
  % 2.2
  e = entropy(f);
  imsize = size(f);
  % 2.3
  [arr1, arr2] = ndgrid([1:8:256],[1:8:256]);
  blocks = arrayfun(@(x,y) f(x:x+7,y:y+7), arr1, arr2, 'uniform', 0);
  blocksMat = cell2mat(blocks);
  % 2.4
  DCT = dct(blocks);
  % 2.5
  Fbar = Fbar(DCT, Q);
  FbarMat = cell2mat(Fbar);
  % 2.6
  Fabs = Fabs(Fbar);
  FabsMat = cell2mat(Fabs);
  printf("Entropy of absolute Fbar: %d\n", entropy(FabsMat));
  % 2.7
  printf("Zeros after quantization: %d\n", sum(FabsMat(:) == 0));
  % 2.8
  Ftilde = Ftilde(Fbar, Q);
  FtildeMat = cell2mat(Ftilde);
  % 2.9
  IDCT2 = IDCT2(Ftilde);
  % 2.10
  Fuint8 = convert2uint8(IDCT2);
  Fuinit8Mat = cell2mat(Fuint8);
  % 2.11
  psnr = psnr(f,Fuinit8Mat)
  colormap(gray);
  imagesc(Fuinit8Mat);
endfunction

function Fbar = Fbar(blocks, Q)
  Fbar = blocks;

  for i = 1:rows(blocks)
    for j = 1:columns(blocks)
      tmp = Fbar(i,j){1,1};
      
      for k = 1:(size(Q)(1)*size(Q)(2))
        tmp(k) = round(tmp(k)/Q(k));
      endfor
      Fbar(i,j) = tmp;
    endfor
  endfor
endfunction

function DCT = dct(blocks)
  DCT = blocks;

  for i = 1:rows(blocks)
    for j = 1:columns(blocks)
      DCT(i,j) = dct2(blocks(i,j){1,1});
    endfor
  endfor
endfunction

function Fabs = Fabs(blocks)
  Fabs = blocks;

  for i = 1:rows(blocks)
    for j = 1:columns(blocks)
      tmp = Fabs(i,j){1,1};
      
      for k = 1:(size(tmp)(1)*size(tmp)(2))
        tmp(k) = abs(tmp(k));
      endfor
      Fabs(i,j) = tmp;
    endfor
  endfor
endfunction

function Ftilde = Ftilde(blocks, Q)
  Ftilde = blocks;
  Fbar = blocks;

  for i = 1:rows(blocks)
    for j = 1:columns(blocks)
      tmp = Fbar(i,j){1,1};
      
      for k = 1:(size(Q)(1)*size(Q)(2))
        tmp(k) = tmp(k)*Q(k);
      endfor
      Ftilde(i,j) = tmp;
    endfor
  endfor
endfunction

function IDCT2 = IDCT2(blocks)
  IDCT2 = blocks;

  for i = 1:rows(blocks)
    for j = 1:columns(blocks)
      IDCT2(i,j) = idct2(blocks(i,j){1,1});
    endfor
  endfor
endfunction

function convert2uint8 = convert2uint8(blocks)
  convert2uint8 = blocks;

  for i = 1:rows(blocks)
    for j = 1:columns(blocks)
      tmp = convert2uint8(i,j){1,1};
      
      for k = 1:(size(tmp)(1)*size(tmp)(2))
        switch(tmp(k))
          case tmp(k) < 0
            tmp(k) = uint8(0);
          case tmp(k) > 255
            tmp(k) = uint8(255);
          otherwise
            tmp(k) = uint8(tmp(k));
        endswitch
      endfor
      convert2uint8(i,j) = uint8(tmp);
    endfor
  endfor
endfunction