% ֡ʱ϶ ALOHA��Framed-Slotted ALOHA��FSA���㷨����

clear;
close all;
clc;

N1 = 32;  % ����5��֡�����
N2 = 64;
N3 = 96;
N4 = 128;
N5 = 256;

S1 = zeros(500, 501);  % ϵͳ������
S2 = zeros(500, 501);
S3 = zeros(500, 501);
S4 = zeros(500, 501);
S5 = zeros(500, 501);

S1_avr = zeros(1, 501);  % ϵͳƽ��������
S2_avr = zeros(1, 501);
S3_avr = zeros(1, 501);
S4_avr = zeros(1, 501);
S5_avr = zeros(1, 501);

S1_coll = zeros(500, 501);  % ϵͳʱ϶��ײ��
S2_coll = zeros(500, 501);
S3_coll = zeros(500, 501);
S4_coll = zeros(500, 501);
S5_coll = zeros(500, 501);

S1_coll_avr = zeros(1, 501);  % ϵͳƽ��ʱ϶��ײ��
S2_coll_avr = zeros(1, 501);
S3_coll_avr = zeros(1, 501);
S4_coll_avr = zeros(1, 501);
S5_coll_avr = zeros(1, 501);

S1_idle = ones(500, 501);  % ��ʼ֡����Ϊ32ʱ�Ŀ�ʱ϶��

S1_idle_avr = ones(1, 501);  % ��ʼ֡����Ϊ32ʱ��ƽ����ʱ϶��


for cycle = 1:500  % �ظ�����500�η������
    for TagsNum = 1:500  % ��ǩ��Ŀ����Ϊ1��500
        
        [ succ1 , idle1 , coll1 ] = FSA_anti ( TagsNum , N1 );  % succ1���ɹ�ʱ϶����idle1������ʱ϶����
        S1(cycle, TagsNum+1) = succ1/N1;  % coll1����ײʱ϶��
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

for i = 2:501  % ��ƽ��ֵ
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
title('Framed-Slotted ALOHA �㷨����');
legend('N=32', 'N=64', 'N=96', 'N=128', 'N=256', 'location', 'best');
xlabel('n����ʶ��ı�ǩ����');
ylabel('S��������');
grid on;

figure(2)
plot(i, S1_coll_avr, 'k', i, S2_coll_avr, 'r', i, S3_coll_avr, 'b', i, S4_coll_avr, 'g', i, S5_coll_avr, 'm');
xlim([0 500]);
title('Framed-Slotted ALOHA �㷨����');
legend('N=32', 'N=64', 'N=96', 'N=128', 'N=256', 'location', 'best');
xlabel('n����ʶ��ı�ǩ����');
ylabel('ʱ϶��ײ��');
grid on;

figure(3)
plot(i, S1_avr, 'k', i, S1_coll_avr, 'r', i, S1_idle_avr, 'b');
xlim([0 500]);
title('FSA �㷨���棨֡��=32��');
legend('�ɹ�ʱ϶��P(s)', '��ײʱ϶��P(c)', '����ʱ϶��P(i)', 'location', 'best');
xlabel('��ǩ��Ŀ');
ylabel('Ч��');
grid on;

