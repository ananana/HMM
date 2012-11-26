function test(miu, sigma,alpha)

% x=randn(1,10000);
% % xmin=min(x);
% % xmax=max(x);
% N = hist(x,20);
% figure(1)
% plot(N)
% axis([ 0 20 0 2000])
% z=x*sigma+miu;
% figure(2)
% plot(z,1:10000,'.r');
N=10000;
z=zeros(1,N);

for i=1:N
    j=indice(alpha);
    z(i)=randn(1)*sigma(j)+miu(j);
end

H = hist(z,20);
figure(1)
plot(H);
axis([ 0 20 0 2000]);

figure(2)
plot(z,1:N,'.r');

end

function j=indice(alpha)
L=length(alpha);
u=rand(1);

i=1;
p=alpha(i);
while u > p
    i=i+1;
    p=p+alpha(i);
end
j=i;

end




