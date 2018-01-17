% 动态帧时隙 ALOHA（Dynamic Framed-Slotted ALOHA，DFSA）算法仿真（基于 Schoute 标签估算算法）

% Schoute 估算算法说明-------------------------------------------------------------------------------------------
% 
% Schoute 算法是在理想的最大系统效率的前提下进行估算的。假设各时隙持续的时间一样，
% 则系统效率可以由成功识别时隙的概率来表示，此时，碰撞时隙率为：P(coll) = 0.418，
% 则某个时隙 i 内发生碰撞的标签个数的条件概率期望值为：1/P(coll) = 2.3922，
% 所以剩余待识别的标签数为：n = 2.3922*C(coll)。仿真时由于要取整，故向上取整为：n = ceil(2.3922*C(coll))
% 式中：C(coll)——固定一帧内出现碰撞时隙的总数。
% Schoute 估算法与 Lower Bound 估算相类似，当标签数很多时，每个碰撞时隙内的平均标签数会远大于 2.39 个，
% 所以也会产生估算误差大，估算不精确的缺点，同样此方法也不适用于标签数较多的场合。
% 
% END-------------------------------------------------------------------------------------------------------------

clear;
close all;
clc;

S2_64 = zeros(300, 41);  % DFSA-Schoute 标签估算算法系统吞吐率
S2_128 = zeros(300, 41);
S2_256 = zeros(300, 41);

S2_avr_64 = zeros(1, 41);  % 系统平均吞吐率
S2_avr_128 = zeros(1, 41);
S2_avr_256 = zeros(1, 41);

for cycle = 1:300  % 重复进行300次仿真测试
    for TagsNum = 10:10:400
        SlotNum = 0;  % 统计识别完全部标签所需要的总时隙数
        N = 64;  % 设置初始帧长为64
        temp = TagsNum;
        while temp > 0
            SlotNum=SlotNum+N;
            [ succ , idle , coll ] = DFSA_anti ( temp , N );
            N = ceil(2.3922*coll);
            temp = temp - succ;
        end
        S2_64(cycle, TagsNum/10+1)=TagsNum/SlotNum;
    end
end

for cycle = 1:300  % 重复进行300次仿真测试
    for TagsNum = 10:10:400
        SlotNum = 0;  % 统计识别完全部标签所需要的总时隙数
        N = 128;  % 设置初始帧长为128
        temp = TagsNum;
        while temp > 0
            SlotNum=SlotNum+N;
            [ succ , idle , coll ] = DFSA_anti ( temp , N );
            N = ceil(2.3922*coll);
            temp = temp - succ;
        end
        S2_128(cycle, TagsNum/10+1)=TagsNum/SlotNum;
    end
end

for cycle = 1:300  % 重复进行300次仿真测试
    for TagsNum = 10:10:400
        SlotNum = 0;  % 统计识别完全部标签所需要的总时隙数
        N = 256;  % 设置初始帧长为256
        temp = TagsNum;
        while temp > 0
            SlotNum=SlotNum+N;
            [ succ , idle , coll ] = DFSA_anti ( temp , N );
            N = ceil(2.3922*coll);
            temp = temp - succ;
        end
        S2_256(cycle, TagsNum/10+1)=TagsNum/SlotNum;
    end
end  

for i = 2:41
    S2_avr_64(i) = sum(S2_64(:, i))/300;
    S2_avr_128(i) = sum(S2_128(:, i))/300;
    S2_avr_256(i) = sum(S2_256(:, i))/300;
end

i = 0:10:400;
figure(1)
plot(i, S2_avr_64, 'kv-', i, S2_avr_128, 'rv-', i, S2_avr_256, 'bv-');
xlim([0 400]);
title('DFSA-Schoute 标签估算算法仿真');
legend('初始帧长：64', '初始帧长：128', '初始帧长：256', 'location', 'best');
xlabel('N：待识别标签数');
ylabel('S：吞吐率');
grid on;

