% ֡ʱ϶ ALOHA��Framed-Slotted ALOHA��FSA���㷨����ײ������

function [ S_succ , S_idle , S_coll ] = FSA_anti ( TagsNum , FrameLength )

S_succ = 0;  % �ɹ�ʱ϶��
S_idle = 0;  % ����ʱ϶��
S_coll = 0;  % ��ײʱ϶��

SlotCounter = randi( [0 , FrameLength - 1] , 1 , TagsNum );
% ��ǩ�� 0-��FrameLength-1�������ѡ��һ����������ʱ϶����������Ϊ�������ݵ�ʱ϶��

SlotCheck = zeros(1, FrameLength);  % ���ÿ֡������ʱ϶��������ɹ�/����/��ײ��

for i = 1:FrameLength
    for n = 1:TagsNum
        if (i-1) == SlotCounter(n)
            SlotCheck(i) = SlotCheck(i) + 1;
            if SlotCheck(i) == 2
                break
            end
        end
    end
end

for i = 1:FrameLength
    if SlotCheck(i) == 1
        S_succ = S_succ +1;
    elseif SlotCheck(i) == 0
        S_idle = S_idle +1;
    else
        S_coll = S_coll + 1;
    end
end
end

