
clear;
close all;
clc;

S3_64 = zeros(300, 41);  % DFSA-Vogt 标签估算算法系统吞吐率
S3_128 = zeros(300, 41);
S3_256 = zeros(300, 41);

S3_avr_64 = zeros(1, 41);  % 系统平均吞吐率
S3_avr_128 = zeros(1, 41);
S3_avr_256 = zeros(1, 41);

for cycle = 1:300  % 重复进行300次仿真测试
    for TagsNum = 10:10:400
        SlotNum = 0;  % 统计识别完全部标签所需要的总时隙数
        N = 64;  % 设置初始帧长为64
        temp = TagsNum;
        while temp > 0
            SlotNum = SlotNum + N;
            [ succ , idle , coll ] = DFSA_anti ( temp , N );
            [ N ] = Vogt ( succ , coll , idle , N );
            temp = temp - succ;
        end
        S3_64(cycle, TagsNum/10+1)=TagsNum/SlotNum;
    end
end

for cycle = 1:300  % 重复进行300次仿真测试
    for TagsNum = 10:10:400
        SlotNum = 0;  % 统计识别完全部标签所需要的总时隙数
        N = 128;  % 设置初始帧长为128
        temp = TagsNum;
        while temp > 0
            SlotNum = SlotNum + N;
            [ succ , idle , coll ] = DFSA_anti ( temp , N );
            [ N ] = Vogt ( succ , coll , idle , N );
            temp = temp - succ;
        end
        S3_128(cycle, TagsNum/10+1)=TagsNum/SlotNum;
    end
end

for cycle = 1:300  % 重复进行300次仿真测试
    for TagsNum = 10:10:400
        SlotNum = 0;  % 统计识别完全部标签所需要的总时隙数
        N = 256;  % 设置初始帧长为256
        temp = TagsNum;
        while temp > 0
            SlotNum = SlotNum + N;
            [ succ , idle , coll ] = DFSA_anti ( temp , N );
            [ N ] = Vogt ( succ , coll , idle , N );
            temp = temp - succ;
        end
        S3_256(cycle, TagsNum/10+1)=TagsNum/SlotNum;
    end
end  

for i = 2:41
    S3_avr_64(i) = sum(S3_64(:, i))/300;
    S3_avr_128(i) = sum(S3_128(:, i))/300;
    S3_avr_256(i) = sum(S3_256(:, i))/300;
end

i = 0:10:400;
figure(1)
plot(i, S3_avr_64, 'ks-', i, S3_avr_128, 'rs-', i, S3_avr_256, 'bs-');
xlim([0 400]);
title('DFSA-Vogt 标签估算算法仿真');
legend('初始帧长：64', '初始帧长：128', '初始帧长：256', 'location', 'best');
xlabel('N：待识别标签数');
ylabel('S：吞吐率');
grid on;

