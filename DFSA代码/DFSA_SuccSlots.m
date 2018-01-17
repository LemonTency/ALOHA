% 仿真说明：取不同帧长度时，不同标签执行 -> 一帧 <- 后对应的成功识别的时隙数（仿真耗时较长，请耐心等待）
% 参考论文：《基于动态帧时隙ALOHA的标签防碰撞算法研究》——河北工业大学 .张晶
% （Y50p+4G：300次仿真约5分钟；500次仿真约8分钟）

clear;
close all;
clc;

N1 = 16;  % 设置5种初始帧长情况
N2 = 32;
N3 = 64;
N4 = 128;
N5 = 256;

S1_succ = zeros(300, 301);  % 系统成功识别时隙数
S2_succ = zeros(300, 301);
S3_succ = zeros(300, 301);
S4_succ = zeros(300, 301);
S5_succ = zeros(300, 301);

S1_succ_avr = zeros(1, 301);  % 系统平均成功识别时隙数
S2_succ_avr = zeros(1, 301);
S3_succ_avr = zeros(1, 301);
S4_succ_avr = zeros(1, 301);
S5_succ_avr = zeros(1, 301);

for cycle = 1:300  % 重复进行300次仿真测试

    for TagsNum = 1:300  % 标签数目设置为1—300
        [ succ1 ] = DFSA_anti ( TagsNum , N1 );
        S1_succ( cycle , TagsNum+1 ) = succ1;
        
        [ succ2 ] = DFSA_anti ( TagsNum , N2 );
        S2_succ( cycle , TagsNum+1 ) = succ2;
        
        [ succ3 ] = DFSA_anti ( TagsNum , N3 );
        S3_succ( cycle , TagsNum+1 ) = succ3;
        
        [ succ4 ] = DFSA_anti ( TagsNum , N4 );
        S4_succ( cycle , TagsNum+1 ) = succ4;
        
        [ succ5 ] = DFSA_anti ( TagsNum , N5 );
        S5_succ( cycle , TagsNum+1 ) = succ5;
        
    end
end

for i = 2:301  % 求平均值
    S1_succ_avr(i) = sum(S1_succ(:, i))/300;
    S2_succ_avr(i) = sum(S2_succ(:, i))/300;
    S3_succ_avr(i) = sum(S3_succ(:, i))/300;
    S4_succ_avr(i) = sum(S4_succ(:, i))/300;
    S5_succ_avr(i) = sum(S5_succ(:, i))/300;
end

i = 1:301;
figure(1)
plot(i, S1_succ_avr, 'k', i, S2_succ_avr, 'r', i, S3_succ_avr, 'b', i, S4_succ_avr, 'g', i, S5_succ_avr, 'm');
xlim([0 300]);
title('Dynamic Framed-Slotted ALOHA 算法仿真');
legend('N=16', 'N=32', 'N=64', 'N=128', 'N=256', 'location', 'best');
xlabel('标签数N');
ylabel('成功识别的时隙数');
grid on;

% 仿真结果说明------------------------------------------------------------------------------------------------
% 
% 在标签数相同情况下，初始设置的帧长度不同产生的成功识别的时隙数也是不同的。
% 当初始帧长度设为 16 时，标签增多时成功识别的时隙数很少，时隙内碰撞情况十分严重；
% 当帧长度设为 256 时，成功识别的时隙数快速增加，但是系统的负载相对应的也增加了，
% 而且标签数很少时会造成时隙的严重浪费。因此，选取合适的帧长度对于提高系统性能、
% 降低碰撞率和提高识别效率具有很大的影响。此外，待识别标签的数量也影响着识别帧内碰撞时隙数的多少，
% 所以，识别前对待识别标签数量的准确估计是 DFSA 算法的关键。
% 
% Aug-17-2016-By-Jason.P-----------------------------------------------------------------------------------