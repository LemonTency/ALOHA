% ��̬֡ʱ϶ ALOHA��Dynamic Framed-Slotted ALOHA��DFSA���㷨���棨���� Schoute ��ǩ�����㷨��

% Schoute �����㷨˵��-------------------------------------------------------------------------------------------
% 
% Schoute �㷨������������ϵͳЧ�ʵ�ǰ���½��й���ġ������ʱ϶������ʱ��һ����
% ��ϵͳЧ�ʿ����ɳɹ�ʶ��ʱ϶�ĸ�������ʾ����ʱ����ײʱ϶��Ϊ��P(coll) = 0.418��
% ��ĳ��ʱ϶ i �ڷ�����ײ�ı�ǩ������������������ֵΪ��1/P(coll) = 2.3922��
% ����ʣ���ʶ��ı�ǩ��Ϊ��n = 2.3922*C(coll)������ʱ����Ҫȡ����������ȡ��Ϊ��n = ceil(2.3922*C(coll))
% ʽ�У�C(coll)�����̶�һ֡�ڳ�����ײʱ϶��������
% Schoute ���㷨�� Lower Bound ���������ƣ�����ǩ���ܶ�ʱ��ÿ����ײʱ϶�ڵ�ƽ����ǩ����Զ���� 2.39 ����
% ����Ҳ������������󣬹��㲻��ȷ��ȱ�㣬ͬ���˷���Ҳ�������ڱ�ǩ���϶�ĳ��ϡ�
% 
% END-------------------------------------------------------------------------------------------------------------

clear;
close all;
clc;

S2_64 = zeros(300, 41);  % DFSA-Schoute ��ǩ�����㷨ϵͳ������
S2_128 = zeros(300, 41);
S2_256 = zeros(300, 41);

S2_avr_64 = zeros(1, 41);  % ϵͳƽ��������
S2_avr_128 = zeros(1, 41);
S2_avr_256 = zeros(1, 41);

for cycle = 1:300  % �ظ�����300�η������
    for TagsNum = 10:10:400
        SlotNum = 0;  % ͳ��ʶ����ȫ����ǩ����Ҫ����ʱ϶��
        N = 64;  % ���ó�ʼ֡��Ϊ64
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

for cycle = 1:300  % �ظ�����300�η������
    for TagsNum = 10:10:400
        SlotNum = 0;  % ͳ��ʶ����ȫ����ǩ����Ҫ����ʱ϶��
        N = 128;  % ���ó�ʼ֡��Ϊ128
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

for cycle = 1:300  % �ظ�����300�η������
    for TagsNum = 10:10:400
        SlotNum = 0;  % ͳ��ʶ����ȫ����ǩ����Ҫ����ʱ϶��
        N = 256;  % ���ó�ʼ֡��Ϊ256
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
title('DFSA-Schoute ��ǩ�����㷨����');
legend('��ʼ֡����64', '��ʼ֡����128', '��ʼ֡����256', 'location', 'best');
xlabel('N����ʶ���ǩ��');
ylabel('S��������');
grid on;

