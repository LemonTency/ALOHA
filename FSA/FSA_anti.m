% 帧时隙 ALOHA（Framed-Slotted ALOHA，FSA）算法的碰撞处理函数

function [ S_succ , S_idle , S_coll ] = FSA_anti ( TagsNum , FrameLength )

S_succ = 0;  % 成功时隙数
S_idle = 0;  % 空闲时隙数
S_coll = 0;  % 碰撞时隙数

SlotCounter = randi( [0 , FrameLength - 1] , 1 , TagsNum );
% 标签从 0-（FrameLength-1）中随机选择一个整数存入时隙计数器，作为发送数据的时隙数

SlotCheck = zeros(1, FrameLength);  % 检测每帧中所有时隙的情况（成功/空闲/碰撞）

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

