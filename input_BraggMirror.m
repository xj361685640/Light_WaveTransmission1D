%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Bragg Mirror structure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nL=3;
nR=3;

n1=3;
n2=3.6;
lambda0=800e-9;      % Central wavelength

l1=lambda0/(4*abs(n1));   % thickness at lambda/4
l2=lambda0/(4*abs(n2));   % thickness at lambda/4

alpha1=4*pi*imag(n1)./lambda;
alpha2=4*pi*imag(n2)./lambda;


layer=[

5*l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
l1   n1
l2   n2
];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r12=(n1-n2)/(n1+n2);
r21=(n2-n1)/(n1+n2);

t12=2*n1/(n1+n2);
t21=2*n2/(n1+n2);


D1(1,1,:)= exp(+1i*2*pi*n1*l1./lambda);       %% take care on the sign here
D1(2,2,:)= exp(-1i*2*pi*n1*l1./lambda);       %% take care on the sign here

D2(1,1,:)= exp(+1i*2*pi*n2*l2./lambda);       %% take care on the sign here
D2(2,2,:)= exp(-1i*2*pi*n2*l2./lambda);       %% take care on the sign here

P1=(1/t12)*[1 r12 ; r12 1];
P2=(1/t21)*[1 r21 ; r21 1];

for j=1:length(lambda)
  S(:,:,j)=D2(:,:,j)*P2*D1(:,:,j)*P1;
end

Nperiod=length(layer(:,1))/2;
for j=1:length(lambda)
  SN(:,:,j)=S(:,:,j)^Nperiod;
end

for j=1:length(lambda)
  Rf(j) = ( abs( SN(1,2,j)/SN(2,2,j) ) )^2;
  Tf(j) = nR/nL * ( abs(1/SN(2,2,j)) )^2;
end
