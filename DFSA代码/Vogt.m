% Vogt 估算算法
% Vogt 算法是通过上一帧的标签识别状况来估计剩余的标签个数。
% 首先求得实际中一帧内所有时隙出现的成功识别的标签时隙数、标签碰撞时隙数以及空时隙数，
% 然后计算出一帧内所有时隙出现的成功识别标签时隙数、标签碰撞时隙数以及空时隙数的期望值，
% 最后将这两组数分别组成向量，通过求得这两组向量的空间距离求出剩余的标签个数。
% 但是要想求出向量空间距离最小值，必须确定读写器响应范围内的标签个数，最终通过空间距离的最小值来求。
% 通常情况下，在[ S_succ+2*S_coll , 2*(S_succ+2*S_coll) ]区间内选取标签个数确定向量空间距离的最小值。

function [ N_estimate ] = Vogt ( S_succ , S_coll , S_idle , FrameLength )

E_succ = [ ];
E_idle = [ ];
E_coll = [ ];

d = zeros(1, S_succ + 2*S_coll + 1);

for i = ( S_succ + 2*S_coll ) : 2*( S_succ + 2*S_coll )
    succ = i*(1-1/FrameLength)^(i-1);  % 计算成功识别标签时隙数的期望值
    E_succ = [E_succ , succ];
    idle = FrameLength*(1-1/FrameLength)^i;  % 计算空时隙数的期望值
    E_idle = [E_idle , idle];
    coll = FrameLength - succ - idle;  % 计算标签碰撞时隙数的期望值
    E_coll = [E_coll , coll];
end

for n = 1:(S_succ + 2*S_coll + 1)  % 计算向量空间距离
    d(n) = sqrt((E_succ(n)-S_succ)^2+(E_idle(n)-S_idle)^2+(E_coll(n)-S_coll)^2);
end

minimum = min(d);  % 查找向量空间距离最小值
location = find(minimum == d);

N_estimate = location + S_succ + 2*S_coll - 1;  % 通过空间距离的最小值来估计剩余的标签个数

end

