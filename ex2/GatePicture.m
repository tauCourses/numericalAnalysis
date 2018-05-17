gate = rgb2gray(imread('gate.jpg'));

n_rows = size(gate, 1);
n_cols = size(gate, 2);
ratio = 10;

figure
subplot(2,2,1);
imshow(gate);
title('original')

badGate = gate(1:ratio:end,:,:);

subplot(2,2,2);
imshow(badGate);
title('bad Gate')

LinearGate = zeros(n_rows, n_cols);
for ii=1:n_cols
    LinearGate(:,ii) = PWLinear(1:ratio:n_rows, badGate(:,ii), 1:n_rows);
end

subplot(2,2,3);
imshow(uint8(LinearGate));
title('Linear Interpolation')

LagrangeGate = zeros(n_rows, n_cols);
for ii=1:n_cols
    LagrangeGate(:,ii) = LagrangeInterp(1:ratio:n_rows, double(badGate(:,ii)), 1:n_rows);
end

subplot(2,2,4);
imshow(uint8(LagrangeGate));
title('Lagrange Interpolation')
