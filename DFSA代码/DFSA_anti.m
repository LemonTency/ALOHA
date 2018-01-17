% ��̬֡ʱ϶ ALOHA��Dynamic Framed-Slotted ALOHA��DFSA���㷨����ײ������

function [ S_succ , S_idle , S_coll ] = DFSA_anti ( TagsNum , FrameLength )

S_succ = 0;  % �ɹ�ʱ϶��
S_idle = 0;  % ����ʱ϶��
S_coll = 0;  % ��ײʱ϶��

RandSlot = randi( [ 1 , FrameLength ] , 1 , TagsNum );   %ÿ����ǩ��1-Framelenth�����ѡһ��ʱ϶���з���
SlotCounter = ones( 1, TagsNum );
% ���ڴ�ʶ��״̬�ı�ǩ����Ĵ�֡���� 1-N ��ѡ��һ��ʱ϶���������ݣ�
% �����ֵ��ͨ������Я����α�������������������ģ�����ͬʱ�������ʱ϶�������� 1

SlotCheck = zeros( 1, FrameLength );  % ���ÿ֡������ʱ϶��������ɹ�/����/��ײ��

for i = 1:FrameLength  % ��ʼ֡��ʱ϶�Ĳ�ѯ
    Remove = [ ];  % �洢������ײ/��ȷʶ��ı�ǩ���
    for n = 1:TagsNum
        if RandSlot(n) == SlotCounter(n)  % ��ʼ֡��ʱ϶�Ĳ�ѯ��ÿ����ǩ�����ѡ���ʱ϶��������ʱ϶�������ĺ�����бȶ�
            SlotCheck(i) = SlotCheck(i) + 1;  % ���������ʱ��ǩ��Ӧ�Ķ��������ڴ�ʱ϶�ڿ�ʼ����������Ϣ
            Remove = [ Remove , n ];  % �������ж������ı�ǩ��Ŵ洢�������� Remove ��
        end  % �����߲���ʱ����ǩ���ٴ���������Ϣ���Ǳ�����ʱ϶�ţ����ȴ��Ķ�����һ�ε�ʱ϶��ѯ����
    end
    
    % �ڴ˽׶��У�ʱ϶�ڴ����������������
    
    if SlotCheck(i) == 0  % �Ķ���δ��⵽��ǩ��������Ϣ��Ҳ�����ޱ�ǩ�ڴ�ʱ϶�ڴ��䣬��ʱ�Ķ���������ʱ϶�Ĳ�ѯ
        SlotCounter = SlotCounter +1;  % �������б�ǩ������ʱ϶���������м� 1 ����
        S_idle = S_idle + 1;  % ��ʱ϶Ϊ����ʱ϶
        
    elseif SlotCheck(i) == 1  % �Ķ�����⵽������Ϣ����ȷʶ��Ҳ���Ǵ�ʱʱ϶��ֻ��һ����ǩ�ڴ�����Ϣ
        RandSlot(Remove(1)) = [ ];  % �Ķ������յ���ǩ��Ϣ������ǩ����һ����ָ�ʹ��ǩ��������״̬��
        SlotCounter(Remove(1)) = [ ];  % ������Ӧ�Ķ������κ�ָ����ǽ���� RandSlot �� SlotCounter ������ɾ������
        SlotCounter = SlotCounter +1;  % ���������ڴ�ʶ��״̬�ı�ǩ������ʱ϶���������м� 1 �������ȴ��Ķ�����һʱ϶��ѯ����
        TagsNum = TagsNum - 1;  % ���±�֡�ڴ���ѯ�ı�ǩ��
        S_succ = S_succ + 1;  % ��ʱ϶Ϊ�ɹ�ʱ϶
        
    else  % �Ķ�����⵽������Ϣ���޷���ȷʶ�������Ҳ���Ǵ�ʱ϶���ж����ǩ�ڴ�����Ϣ
        for m = 1:length(Remove)  % �Ķ��������ʱ϶�ڵı�ǩ�ȴ���һ֡��ѯ�����ٷ�������
            RandSlot( Remove(m)-(m-1) ) = [ ];
            SlotCounter( Remove(m)-(m-1) ) = [ ];
        end
        SlotCounter = SlotCounter +1;  % ͬʱ�����ǩ������ʱ϶���������м� 1 ����
        TagsNum = TagsNum - length(Remove);  % ���±�֡�ڴ���ѯ�ı�ǩ��
        S_coll = S_coll + 1;  % ��ʱ϶Ϊ��ײʱ϶
    end
end  % ����ѯ��ʱ϶�����ʼ�涨��֡���� N ���ʱ���Ķ������ͽ�����֡�Ĳ�ѯ��
end  % ��������һ֡�� S_succ��S_idle �� S_coll ��������һ֡δ��ʶ��ı�ǩ�����Դ˵�����һ֡�Ĳ�ѯ֡����

