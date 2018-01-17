
clear;
close all;
clc;

S3_64 = zeros(300, 41);  % DFSA-Vogt ��ǩ�����㷨ϵͳ������
S3_128 = zeros(300, 41);
S3_256 = zeros(300, 41);

S3_avr_64 = zeros(1, 41);  % ϵͳƽ��������
S3_avr_128 = zeros(1, 41);
S3_avr_256 = zeros(1, 41);

for cycle = 1:300  % �ظ�����300�η������
    for TagsNum = 10:10:400
        SlotNum = 0;  % ͳ��ʶ����ȫ����ǩ����Ҫ����ʱ϶��
        N = 64;  % ���ó�ʼ֡��Ϊ64
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

for cycle = 1:300  % �ظ�����300�η������
    for TagsNum = 10:10:400
        SlotNum = 0;  % ͳ��ʶ����ȫ����ǩ����Ҫ����ʱ϶��
        N = 128;  % ���ó�ʼ֡��Ϊ128
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

for cycle = 1:300  % �ظ�����300�η������
    for TagsNum = 10:10:400
        SlotNum = 0;  % ͳ��ʶ����ȫ����ǩ����Ҫ����ʱ϶��
        N = 256;  % ���ó�ʼ֡��Ϊ256
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
title('DFSA-Vogt ��ǩ�����㷨����');
legend('��ʼ֡����64', '��ʼ֡����128', '��ʼ֡����256', 'location', 'best');
xlabel('N����ʶ���ǩ��');
ylabel('S��������');
grid on;

