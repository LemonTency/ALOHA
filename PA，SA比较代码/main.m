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
title('slotted ALOHA算法仿真');
legend('slotted ALOHA');
gtext('纯ALOHA发送成功率');
gtext('时隙ALOHA发送成功率');
xlabel('G(平均每帧时负载量)');
ylabel('S(平均每帧时吞吐量)');
axis([0 2 0 1]);
grid on;

%save aloha  %保存当前工作区的所有数据，默认格式为 ***.MAT
%dlmwrite('paloha_G1_data.txt',G1,'delimiter', '\t','precision', '%.4f','newline', 'pc')
%dlmwrite(filename, M, 'attrib1', value1, 'attrib2', value2, ...)
%函数dlmwrite 一次只能保存一个变量值M，生成的文件可用记事本或者Word文档打开查看
