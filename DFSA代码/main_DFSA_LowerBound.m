




% 动态帧时隙 ALOHA（Dynamic Framed-Slotted ALOHA，DFSA）算法仿真（基于 Lower Bound 标签估算算法）
% DFSA 是在 FSA 算法的基础上，提出帧长 N 要随着标签数 n 动态变化，使得系统效率接近最优值。
% 仿真时设置第1帧（初始帧）帧长=64，128，256。1 帧结束后由相关数学理论公式推出下一帧的帧长，
% 直至某一帧中不再产生碰撞时隙（即该帧中待读标签均成功识别）算法结束。

% Lower Bound 估算算法说明-----------------------------------------------------------------------------------
% 
% 当一帧某个时隙内至少存在两个标签时，这个时隙就发生了碰撞。
% Lower Bound 估算算法直接取了标签碰撞个数的下限值，即认为在每个碰撞的时隙内仅有两个标签。
% 则在读写器识别范围内剩余的标签个数：n = 2*C(coll)
% 式中：C(coll)——固定一帧内出现碰撞时隙的总数。
% Lower Bound 估算算法仅仅是对一帧内发生碰撞标签个数的下限值进行估算。当标签个数较小时，
% 标签估算的准确率比较高。当标签个数很大时，成功识别的时隙数变少，碰撞时隙数急剧增加，
% 而每个碰撞时隙数内发生碰撞的标签会远大于两个，此时采用该方法进行标签数估算就会变得不精确，
% 标签估算值与实际剩余的标签个数相比存在很大的误差，故此算法不适用于标签数量多的场合。
% 
% END----------------------------------------------------------------------------------------------------------

clear;
close all;
clc;

S1_64 = zeros(300, 41);  % DFSA-Lower Bound 标签估算算法系统吞吐率
S1_128 = zeros(300, 41);
S1_256 = zeros(300, 41);

S1_avr_64 = zeros(1, 41);  % 系统平均吞吐率
S1_avr_128 = zeros(1, 41);
S1_avr_256 = zeros(1, 41);

for cycle = 1:300  % 重复进行300次仿真测试
    for TagsNum = 10:10:400
        SlotNum = 0;  % 统计识别完全部标签所需要的总时隙数
        N = 64;  % 设置初始帧长为64
        temp = TagsNum;
        while temp > 0
            SlotNum=SlotNum+N;
            [ succ , idle , coll ] = DFSA_anti ( temp , N );
            N = 2*coll;
            temp = temp - succ;
        end
        S1_64(cycle, TagsNum/10+1)=TagsNum/SlotNum;
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
            N = 2*coll;
            temp = temp - succ;
        end
        S1_128(cycle, TagsNum/10+1)=TagsNum/SlotNum;
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
            N = 2*coll;
            temp = temp - succ;
        end
        S1_256(cycle, TagsNum/10+1)=TagsNum/SlotNum;
    end
end

for i = 2:41
    S1_avr_64(i) = sum(S1_64(:, i))/300;
    S1_avr_128(i) = sum(S1_128(:, i))/300;
    S1_avr_256(i) = sum(S1_256(:, i))/300;
end

i = 0:10:400;
figure(1)
plot(i, S1_avr_64, 'kd-', i, S1_avr_128, 'rd-', i, S1_avr_256, 'bd-');
xlim([0 400]);
title('DFSA-Lower Bound 标签估算算法仿真');
legend('初始帧长：64', '初始帧长：128', '初始帧长：256', 'location', 'best');
xlabel('N：待识别标签数');
ylabel('S：吞吐率');
grid on;

% 仿真结果说明--------------------------------------------------------------------------------------------------------
% 
% 考虑到阅读器在初始状态下无法估计其通信范围内标签的数目，在实际的算法执行过程中，阅读器需要经过多帧的调整
% 才能达到帧长与待读标签数相接近，因此，在这个过程中就浪费了大量的时隙（或空闲或碰撞），算法效率有所降低。
% 本次仿真分析了取不同初始帧长（N=64，N=128，N=256），采用碰撞标签数量下限估计系统吞吐率。
% 帧长与待读标签数量越接近，调整帧长所需的时隙越少，算法效率越高。
% 
% Aug-18-2016-By-Jason.P------------------------------------------------------------------------------------------