% pure aloha �㷨����
% ע��֡=����֡=���ݰ���������

function [G, S, Q] = aloha(hostNum, pktNum)  % hostNum��ʾ����ǩ����pktNum��ʾÿ����ǩ�贫�����ݰ��ĸ���
                                                                               % pktNumҲ�����Ϊ�ط�����

if hostNum < 2  % Ҫ������ǩ��ײ�¼�����ǩ������>=2
    error('hostNum must be bigger than 2');  % ����main�ű��ļ������õ� hostNumֵС��2����������ʱ�򷵻س�����Ϣ
end
 
    G = zeros(1, hostNum - 1);  % ���أ�Ԥ�����ڴ�ռ䣩
    S = zeros(1, hostNum - 1);  % ƽ��ÿ֡ʱ������������Ϊ�����ʣ�Ԥ�����ڴ�ռ䣩
    Q = zeros(1, hostNum - 1);  % ���ͳɹ��ʣ�Ԥ�����ڴ�ռ䣩
    
    factor = 1;  % ���������֡����ȴ�ʱ�����0-1�ֲ���������ֲ�ϵ��Ϊ1�����޸�
    
for hosts = 2:hostNum  % ��������ʱ�����һ����ʱ������������������ɺ��Զ�������ʱ������ɾ�����м����hosts����ֵ����hostNum
    timePoint = cumsum(factor*rand(pktNum, hosts));  % ��������ʾ�����֡ʱ�䣬����cumsum�������������
    observedTime = timePoint(pktNum, 1);            % �����۲�ʱ��
     
    sequence = zeros(1, hosts*pktNum);  % ������ timePoint���������ݴ��������� sequence����ȶ��� sequence
    for i = 1:pktNum                                   % ����C���Ե�int a������һ�����α���a��ʹ��ռ���ڴ��һ���ռ䣨Ԥ�����ڴ棩
        sequence(1, (i-1)*hosts+1 : i*hosts) = timePoint(i, :); % timePoint ������ pktNum�У�hostNum��
    end         % ������ֵ�������ܼ�࣬�ʵ���һ�±ʼ�         % �� pktNum*hostNum ��Ԫ��
    sequence = sort(sequence);  % ��ʱ��˳�����и�����֡ʱ�䣨���������ε�������
     
    total = 0;          % ��֡��
    success = 0;        % �޳�ͻ֡��
    frameTime = 0.004;  % ֡ʱ/֡�����贫��1֡��Ҫ4���룩���൱��1֡��Ϣ�ĳ���ΪT0=0.004s������ÿ�����ݰ��Ŀ�ȣ�
    interval = diff(sequence); % ֡���ʱ�䣨������Ԫ�ز���diff�����ǲ�ֵ���˼������˵ dy(n)=y(n+1)-y(n)��
    for i = 1:hosts*pktNum - 1;  % ���Եõ��� interval������ sequence������һ��
        if sequence(i+1) > observedTime 
            break;   % ���Թ۲�ʱ�������֡��break
        end
        total = total + 1;   % �� t0-T0<=t1<=t0+T0 ʱ������ײ������ʼʱ��Ϊt0��һ֡��Ϣ�ĳ���ΪT0����һ֡����ʼʱ����Ϊt1
        if (i == 1 || i == ( hosts*pktNum -1 ) ) && interval(1, i) >= frameTime % ��һ�������һ��֡�����ݰ�����ֻ�迼��ʱ���������֡ʱ
            success = success + 1;                                                                 %��һ������ֻ֡����β��ʱ���������һ����ֻ����ǰ��ʱ����
        end
        if i ~= 1 && i ~= ( hosts*pktNum -1 ) && interval(1, i) >= frameTime && interval(1, i-1) >= frameTime % ֡��ǰ������Ӧ�����֡ʱ
            success = success + 1;
        end
    end
    G(hosts-1) = frameTime/observedTime*total;      % ���㸺��
    S(hosts-1) = frameTime/observedTime*success;    % ����ƽ��ÿ֡ʱ���������������ʣ�
    Q(hosts-1) = S/G;  % ���㷢�ͳɹ���
end
end  % function aloha ����

