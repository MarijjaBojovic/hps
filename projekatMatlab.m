clear; close all; clc

%inicijalizacija parametara koef.

Bp=30;       % koef viskoznog prigusenja
K=0;         % koef unutrasnje krutosti aktuatora
Ap=3e-3;   % povrsina klipa
Mt=13;       % masa klipa sa klipnjacom
Vt=4e-3;   % zapremina cilindra
Kc=1.8e-12;  % koef protok-pritisak
Ctp=2e-13;   % koef totalnog curenja
Kq=1;       % koef protok-pomeraj ventila
Kt=8.84e-3;  % konstanta momenta motora
Kf=1.2e3;    % krutost povratne opruge
R=10;        % otpornost namotaja
r=0.01;      % duzina povratne sprege
Be=13e8;     % koef stisljivosti fluida
m=40;      % masa tockova
k=8e5;
b=150;


% matrica A

a21 = k/(5*m);
a22 = b/(5*m);
a23 = -k/(5*m);
a24 = -b/(5*m);

a41= -k/Mt;
a42= -b/Mt;
a43=  k/Mt;
a44= -(Bp+b)/Mt;
a45=  Ap/Mt;

a54= -4*Be*Ap/Vt;
a55= -(Ctp+Kc)*4*Be/Vt;

A=[0 1 0 0 0; a21 a22 a23 a24 0; 0 0 0 1 0; a41 a42 a43 a44 a45; 0 0 0 a54 a55];

% matrica B

b51=Kq*4*Be*Kt/(Vt*r*R*Kf);

B=[0; 0; 0; 0; b51];

% matrica C

C = [1 0 0 0 0];

% transfer function
s = tf('s');
G = C*(s*eye(5)-A)^(-1)*B

figure()
pzmap(G)

figure()
step(G/(1+G)) % iscrtavanje step odziva za sistem za zatvorenom jedinicnom povratnom spregom

%na tri nacina preko dif jednacina, preo a b c i preko funkcije prenosa
