clear all
clc
M = .335; % Mass of cart in kilograms
m = .149; % Mass of pendulum in kilograms
L = 0.32; % Length of the pendulum CG
l = 0.4; % Length of the track
I = (m*(2*L)^2)/12 ;% Mass moment of inertia about the pivot point Kgm2
g = 9.8; % Gravitational Constant
b = .1 ; %damping i believe?
Rm = 12.5; % Motor Constant for something, check PDF
kb = 0.031; % 
kt = 0.031; %
r = .006; %verify what this means!!!!
q = (M+m)*(I+m*l^2)-(m*l)^2; %Simplified equation for easy access

G_pend = tf([m*L/q, 0],[1, b*(I+(m*L^2)), -(M+m)*m*g*L/q, -(b*m*g*L)/q]);
G_cart = tf([(I+(m*L^2))/q,0,-g*m*L/q],[1, (b*(I+m*L^2))/q, -((M+m)*m*g*L)/q, -(b*m*g*L/q)]);

p = I*(M+m)+M*m*L^2;
A = [0      1              0           0;
     0 -(I+m*L^2)*b/p  (m^2*g*L^2)/p   0;
     0      0              0           1;
     0 -(m*L*b)/p       m*g*L*(M+m)/p  0];
B = [     0;
     (I+m*L^2)/p;
          0;
        m*L/p];

C = [1 0 0 0;
     0 0 1 0];
D = [0;
     0];

Q=[1 0 0 0;
    0 1 0 0;
    0 0 100 0;
    0 0 0 1000];
R = 0.001;
K = lqr(A,B,Q,R);
