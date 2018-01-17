% 帧时隙 ALOHA（Framed-Slotted ALOHA，FSA）算法仿真

clear;
close all;
clc;

N1 = 32;  % 设置5种帧长情况
N2 = 64;
N3 = 96;
N4 = 128;
N5 = 256;

S1 = zeros(500, 501);  % 系统吞吐率
S2 = zeros(500, 501);
S3 = zeros(500, 501);
S4 = zeros(500, 501);
S5 = zeros(500, 501);

S1_avr = zeros(1, 501);  % 系统平均吞吐率
S2_avr = zeros(1, 501);
S3_avr = zeros(1, 501);
S4_avr = zeros(1, 501);
S5_avr = zeros(1, 501);

S1_coll = zeros(500, 501);  % 系统时隙碰撞率
S2_coll = zeros(500, 501);
S3_coll = zeros(500, 501);
S4_coll = zeros(500, 501);
S5_coll = zeros(500, 501);

S1_coll_avr = zeros(1, 501);  % 系统平均时隙碰撞率
S2_coll_avr = zeros(1, 501);
S3_coll_avr = zeros(1, 501);
S4_coll_avr = zeros(1, 501);
S5_coll_avr = zeros(1, 501);

S1_idle = ones(500, 501);  % 初始帧长度为32时的空时隙率

S1_idle_avr = ones(1, 501);  % 初始帧长度为32时的平均空时隙率


for cycle = 1:500  % 重复进行500次仿真测试
    for TagsNum = 1:500  % 标签数目设置为1—500
        
        [ succ1 , idle1 , coll1 ] = FSA_anti ( TagsNum , N1 );  % succ1：成功时隙数；idle1：空闲时隙数；
        S1(cycle, TagsNum+1) = succ1/N1;  % coll1：碰撞时隙数
        S1_idle(cycle, TagsNum+1) = idle1/N1;
        S1_coll(cycle, TagsNum+1) = coll1/N1;
        
        [ succ2 , idle2 , coll2 ] = FSA_anti ( TagsNum , N2 );
        S2(cycle, TagsNum+1) = succ2/N2;
        S2_coll(cycle, TagsNum+1) = coll2/N2;
        
        [ succ3 , idle3 , coll3 ] = FSA_anti ( TagsNum , N3 );
        S3(cycle, TagsNum+1) = succ3/N3;
        S3_coll(cycle, TagsNum+1) = coll3/N3;
        
        [ succ4 , idle4 , coll4 ] = FSA_anti ( TagsNum , N4 );
        S4(cycle, TagsNum+1) = succ4/N4;
        S4_coll(cycle, TagsNum+1) = coll4/N4;
        
        [ succ5 , idle5 , coll5 ] = FSA_anti ( TagsNum , N5 );
        S5(cycle, TagsNum+1) = succ5/N5;
        S5_coll(cycle, TagsNum+1) = coll5/N5;
        
    end
end

for i = 2:501  % 求平均值
    S1_avr(i)=sum(S1(:, i))/500;
    S2_avr(i)=sum(S2(:, i))/500;
    S3_avr(i)=sum(S3(:, i))/500;
    S4_avr(i)=sum(S4(:, i))/500;
    S5_avr(i)=sum(S5(:, i))/500;
    S1_coll_avr(i)=sum(S1_coll(:, i))/500;
    S2_coll_avr(i)=sum(S2_coll(:, i))/500;
    S3_coll_avr(i)=sum(S3_coll(:, i))/500;
    S4_coll_avr(i)=sum(S4_coll(:, i))/500;
    S5_coll_avr(i)=sum(S5_coll(:, i))/500;
    S1_idle_avr(i)=sum(S1_idle(:, i))/500;
end

i=1:501;
figure(1)
plot(i, S1_avr, 'k', i, S2_avr, 'r', i, S3_avr, 'b', i, S4_avr, 'g', i, S5_avr, 'm');
xlim([0 500]);
title('Framed-Slotted ALOHA 算法仿真');
legend('N=32', 'N=64', 'N=96', 'N=128', 'N=256', 'location', 'best');
xlabel('n：待识别的标签数量');
ylabel('S：吞吐率');
grid on;

figure(2)
plot(i, S1_coll_avr, 'k', i, S2_coll_avr, 'r', i, S3_coll_avr, 'b', i, S4_coll_avr, 'g', i, S5_coll_avr, 'm');
xlim([0 500]);
title('Framed-Slotted ALOHA 算法仿真');
legend('N=32', 'N=64', 'N=96', 'N=128', 'N=256', 'location', 'best');
xlabel('n：待识别的标签数量');
ylabel('时隙碰撞率');
grid on;

figure(3)
plot(i, S1_avr, 'k', i, S1_coll_avr, 'r', i, S1_idle_avr, 'b');
xlim([0 500]);
title('FSA 算法仿真（帧长=32）');
legend('成功时隙率P(s)', '碰撞时隙率P(c)', '空闲时隙率P(i)', 'location', 'best');
xlabel('标签数目');
ylabel('效率');
grid on;

