%
close all;
% clear all;
clear;
clc;

hosts =500;
pkts = 1000;

[G1, S1, Q1] = aloha(hosts, pkts);
[G2, S2, Q2] = s_aloha(hosts, pkts);

plot(G1, S1, 'r',G2, S2, 'b',G1, Q1, 'k', G2, Q2, 'g');
title('slotted ALOHA�㷨����');
legend('slotted ALOHA');
gtext('��ALOHA���ͳɹ���');
gtext('ʱ϶ALOHA���ͳɹ���');
xlabel('G(ƽ��ÿ֡ʱ������)');
ylabel('S(ƽ��ÿ֡ʱ������)');
axis([0 2 0 1]);
grid on;

%save aloha  %���浱ǰ���������������ݣ�Ĭ�ϸ�ʽΪ ***.MAT
%dlmwrite('paloha_G1_data.txt',G1,'delimiter', '\t','precision', '%.4f','newline', 'pc')
%dlmwrite(filename, M, 'attrib1', value1, 'attrib2', value2, ...)
%����dlmwrite һ��ֻ�ܱ���һ������ֵM�����ɵ��ļ����ü��±�����Word�ĵ��򿪲鿴
