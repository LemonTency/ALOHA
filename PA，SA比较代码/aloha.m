% pure aloha 算法仿真
% 注：帧=数据帧=数据包（定长）

function [G, S, Q] = aloha(hostNum, pktNum)  % hostNum表示最大标签数，pktNum表示每个标签需传送数据包的个数
                                                                               % pktNum也可理解为重发次数

if hostNum < 2  % 要发生标签碰撞事件，标签数必须>=2
    error('hostNum must be bigger than 2');  % 若在main脚本文件里设置的 hostNum值小于2，仿真运行时则返回出错信息
end
 
    G = zeros(1, hostNum - 1);  % 负载（预分配内存空间）
    S = zeros(1, hostNum - 1);  % 平均每帧时的吞吐量，即为吞吐率（预分配内存空间）
    Q = zeros(1, hostNum - 1);  % 发送成功率（预分配内存空间）
    
    factor = 1;  % 假设随机发帧间隔等待时间服从0-1分布，故随机分布系数为1，可修改
    
for hosts = 2:hostNum  % 函数运行时会产生一个临时工作区，函数运行完成后，自动将该临时工作区删除。中间变量hosts最终值等于hostNum
    timePoint = cumsum(factor*rand(pktNum, hosts));  % 随机矩阵表示随机发帧时间，矩阵‘cumsum’运算是列相加
    observedTime = timePoint(pktNum, 1);            % 设立观察时间
     
    sequence = zeros(1, hosts*pktNum);  % 将矩阵 timePoint的所有数据存入行向量 sequence里，首先定义 sequence
    for i = 1:pktNum                                   % 类似C语言的int a，声明一个整形变量a，使其占用内存的一个空间（预分配内存）
        sequence(1, (i-1)*hosts+1 : i*hosts) = timePoint(i, :); % timePoint 矩阵有 pktNum行，hostNum列
    end         % 上述赋值方法↑很简洁，适当做一下笔记         % 共 pktNum*hostNum 个元素
    sequence = sort(sequence);  % 按时间顺序排列各个发帧时间（从左到右依次递增排序）
     
    total = 0;          % 总帧数
    success = 0;        % 无冲突帧数
    frameTime = 0.004;  % 帧时/帧长（设传输1帧需要4毫秒）（相当于1帧信息的长度为T0=0.004s）（即每个数据包的宽度）
    interval = diff(sequence); % 帧间隔时间（对数组元素采用diff函数是差分的意思，就是说 dy(n)=y(n+1)-y(n)）
    for i = 1:hosts*pktNum - 1;  % 所以得到的 interval数组会比 sequence数组少一个
        if sequence(i+1) > observedTime 
            break;   % 忽略观察时间以外的帧，break
        end
        total = total + 1;   % 当 t0-T0<=t1<=t0+T0 时发生碰撞。设起始时间为t0，一帧信息的长度为T0，另一帧的起始时间设为t1
        if (i == 1 || i == ( hosts*pktNum -1 ) ) && interval(1, i) >= frameTime % 第一个和最后一个帧（数据包），只需考虑时间间隔大等于帧时
            success = success + 1;                                                                 %第一个数据帧只考虑尾部时间间隔；最后一个则只考虑前部时间间隔
        end
        if i ~= 1 && i ~= ( hosts*pktNum -1 ) && interval(1, i) >= frameTime && interval(1, i-1) >= frameTime % 帧的前后间隔都应大等于帧时
            success = success + 1;
        end
    end
    G(hosts-1) = frameTime/observedTime*total;      % 计算负载
    S(hosts-1) = frameTime/observedTime*success;    % 计算平均每帧时的吞吐量（吞吐率）
    Q(hosts-1) = S/G;  % 计算发送成功率
end
end  % function aloha 结束

