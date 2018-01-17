% 动态帧时隙 ALOHA（Dynamic Framed-Slotted ALOHA，DFSA）算法的碰撞处理函数

function [ S_succ , S_idle , S_coll ] = DFSA_anti ( TagsNum , FrameLength )

S_succ = 0;  % 成功时隙数
S_idle = 0;  % 空闲时隙数
S_coll = 0;  % 碰撞时隙数

RandSlot = randi( [ 1 , FrameLength ] , 1 , TagsNum );   %每个标签在1-Framelenth中随机选一个时隙进行发送
SlotCounter = ones( 1, TagsNum );
% 处于待识别状态的标签随机的从帧长度 1-N 内选择一个时隙来传送数据，
% 这个数值是通过自身携带的伪随机数发生器随机产生的，并且同时将自身的时隙计数器置 1

SlotCheck = zeros( 1, FrameLength );  % 检测每帧中所有时隙的情况（成功/空闲/碰撞）

for i = 1:FrameLength  % 开始帧内时隙的查询
    Remove = [ ];  % 存储发生碰撞/正确识别的标签序号
    for n = 1:TagsNum
        if RandSlot(n) == SlotCounter(n)  % 开始帧内时隙的查询，每个标签将随机选择的时隙号与自身时隙计数器的号码进行比对
            SlotCheck(i) = SlotCheck(i) + 1;  % 当两者相等时标签响应阅读器，并在此时隙内开始传送数据信息
            Remove = [ Remove , n ];  % 将符合判断条件的标签序号存储到行向量 Remove 中
        end  % 当两者不等时，标签不再传送数据信息而是保留此时隙号，并等待阅读器下一次的时隙查询命令
    end
    
    % 在此阶段中，时隙内存在以下三种情况：
    
    if SlotCheck(i) == 0  % 阅读器未检测到标签的数据信息，也就是无标签在此时隙内传输，此时阅读器结束此时隙的查询
        SlotCounter = SlotCounter +1;  % 并且所有标签将自身时隙计数器进行加 1 操作
        S_idle = S_idle + 1;  % 该时隙为空闲时隙
        
    elseif SlotCheck(i) == 1  % 阅读器检测到数据信息并正确识别，也就是此时时隙内只有一个标签在传送消息
        RandSlot(Remove(1)) = [ ];  % 阅读器接收到标签信息后会向标签发送一休眠指令，使标签进入休眠状态，
        SlotCounter(Remove(1)) = [ ];  % 不再响应阅读器的任何指令。我们将其从 RandSlot 和 SlotCounter 矩阵中删除即可
        SlotCounter = SlotCounter +1;  % 其他还处于待识别状态的标签将自身时隙计数器进行加 1 操作，等待阅读器下一时隙查询命令
        TagsNum = TagsNum - 1;  % 更新本帧内待查询的标签数
        S_succ = S_succ + 1;  % 该时隙为成功时隙
        
    else  % 阅读器检测到数据信息但无法正确识别出来，也就是此时隙内有多个标签在传送信息
        for m = 1:length(Remove)  % 阅读器命令该时隙内的标签等待下一帧查询周期再发送数据
            RandSlot( Remove(m)-(m-1) ) = [ ];
            SlotCounter( Remove(m)-(m-1) ) = [ ];
        end
        SlotCounter = SlotCounter +1;  % 同时其余标签将自身时隙计数器进行加 1 操作
        TagsNum = TagsNum - length(Remove);  % 更新本帧内待查询的标签数
        S_coll = S_coll + 1;  % 该时隙为碰撞时隙
    end
end  % 当查询的时隙数与初始规定的帧长度 N 相等时，阅读器发送结束本帧的查询，
end  % 并根据这一帧的 S_succ、S_idle 和 S_coll 来估计下一帧未被识别的标签数，以此调整下一帧的查询帧长度

