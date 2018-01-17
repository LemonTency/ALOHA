% ����˵����ȡ��ͬ֡����ʱ����ͬ��ǩִ�� -> һ֡ <- ���Ӧ�ĳɹ�ʶ���ʱ϶���������ʱ�ϳ��������ĵȴ���
% �ο����ģ������ڶ�̬֡ʱ϶ALOHA�ı�ǩ����ײ�㷨�о��������ӱ���ҵ��ѧ .�ž�
% ��Y50p+4G��300�η���Լ5���ӣ�500�η���Լ8���ӣ�

clear;
close all;
clc;

N1 = 16;  % ����5�ֳ�ʼ֡�����
N2 = 32;
N3 = 64;
N4 = 128;
N5 = 256;

S1_succ = zeros(300, 301);  % ϵͳ�ɹ�ʶ��ʱ϶��
S2_succ = zeros(300, 301);
S3_succ = zeros(300, 301);
S4_succ = zeros(300, 301);
S5_succ = zeros(300, 301);

S1_succ_avr = zeros(1, 301);  % ϵͳƽ���ɹ�ʶ��ʱ϶��
S2_succ_avr = zeros(1, 301);
S3_succ_avr = zeros(1, 301);
S4_succ_avr = zeros(1, 301);
S5_succ_avr = zeros(1, 301);

for cycle = 1:300  % �ظ�����300�η������

    for TagsNum = 1:300  % ��ǩ��Ŀ����Ϊ1��300
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

for i = 2:301  % ��ƽ��ֵ
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
title('Dynamic Framed-Slotted ALOHA �㷨����');
legend('N=16', 'N=32', 'N=64', 'N=128', 'N=256', 'location', 'best');
xlabel('��ǩ��N');
ylabel('�ɹ�ʶ���ʱ϶��');
grid on;

% ������˵��------------------------------------------------------------------------------------------------
% 
% �ڱ�ǩ����ͬ����£���ʼ���õ�֡���Ȳ�ͬ�����ĳɹ�ʶ���ʱ϶��Ҳ�ǲ�ͬ�ġ�
% ����ʼ֡������Ϊ 16 ʱ����ǩ����ʱ�ɹ�ʶ���ʱ϶�����٣�ʱ϶����ײ���ʮ�����أ�
% ��֡������Ϊ 256 ʱ���ɹ�ʶ���ʱ϶���������ӣ�����ϵͳ�ĸ������Ӧ��Ҳ�����ˣ�
% ���ұ�ǩ������ʱ�����ʱ϶�������˷ѡ���ˣ�ѡȡ���ʵ�֡���ȶ������ϵͳ���ܡ�
% ������ײ�ʺ����ʶ��Ч�ʾ��кܴ��Ӱ�졣���⣬��ʶ���ǩ������ҲӰ����ʶ��֡����ײʱ϶���Ķ��٣�
% ���ԣ�ʶ��ǰ�Դ�ʶ���ǩ������׼ȷ������ DFSA �㷨�Ĺؼ���
% 
% Aug-17-2016-By-Jason.P-----------------------------------------------------------------------------------