% ʱ϶ALOHA�㷨�ǰ�ʱ��ֳɶ����ɢ��ʱ϶��ÿ��ʱ϶�ĳ��ȵ��ڻ��Դ���һ��֡��
% ��ǩֻ����ÿ��ʱ϶�Ŀ�ʼ���������ݣ�������ǩ��ɹ����ͻ�����ȫ��ײ��
% ������ALOHA�㷨�Ĳ�����ײ��ʹ��ײ���ڼ��룬������ŵ��������ʡ�

function slot_length = slotted(M, deta)
s = size(M); % s=[pktNum,frameTime]  %deta =0.005
slot_length = zeros(s(1), s(2));
for i = 1:s(2)
    for j = 1:s(1)
        if M(j, i)/deta ~= floor(M(j, i)/deta) % ����floor��ʾ����ȡ������ floor(3.8)  ans=3�� "~"��ʾ�����ڣ���
            slot_length(j, i) = (floor(M(j, i)/deta)+1)*deta; % ÿ��ʱ϶�ĳ���Ҫ����ڱ�ǩ�ظ������ݳ���deta
        end
    end
end
end
