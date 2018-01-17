% Vogt �����㷨
% Vogt �㷨��ͨ����һ֡�ı�ǩʶ��״��������ʣ��ı�ǩ������
% �������ʵ����һ֡������ʱ϶���ֵĳɹ�ʶ��ı�ǩʱ϶������ǩ��ײʱ϶���Լ���ʱ϶����
% Ȼ������һ֡������ʱ϶���ֵĳɹ�ʶ���ǩʱ϶������ǩ��ײʱ϶���Լ���ʱ϶��������ֵ��
% ������������ֱ����������ͨ����������������Ŀռ�������ʣ��ı�ǩ������
% ����Ҫ����������ռ������Сֵ������ȷ����д����Ӧ��Χ�ڵı�ǩ����������ͨ���ռ�������Сֵ����
% ͨ������£���[ S_succ+2*S_coll , 2*(S_succ+2*S_coll) ]������ѡȡ��ǩ����ȷ�������ռ�������Сֵ��

function [ N_estimate ] = Vogt ( S_succ , S_coll , S_idle , FrameLength )

E_succ = [ ];
E_idle = [ ];
E_coll = [ ];

d = zeros(1, S_succ + 2*S_coll + 1);

for i = ( S_succ + 2*S_coll ) : 2*( S_succ + 2*S_coll )
    succ = i*(1-1/FrameLength)^(i-1);  % ����ɹ�ʶ���ǩʱ϶��������ֵ
    E_succ = [E_succ , succ];
    idle = FrameLength*(1-1/FrameLength)^i;  % �����ʱ϶��������ֵ
    E_idle = [E_idle , idle];
    coll = FrameLength - succ - idle;  % �����ǩ��ײʱ϶��������ֵ
    E_coll = [E_coll , coll];
end

for n = 1:(S_succ + 2*S_coll + 1)  % ���������ռ����
    d(n) = sqrt((E_succ(n)-S_succ)^2+(E_idle(n)-S_idle)^2+(E_coll(n)-S_coll)^2);
end

minimum = min(d);  % ���������ռ������Сֵ
location = find(minimum == d);

N_estimate = location + S_succ + 2*S_coll - 1;  % ͨ���ռ�������Сֵ������ʣ��ı�ǩ����

end

