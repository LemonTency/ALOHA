% 时隙ALOHA算法是把时间分成多个离散的时隙，每个时隙的长度等于或稍大于一个帧，
% 标签只能在每个时隙的开始处发送数据，这样标签或成功发送或者完全碰撞，
% 避免了ALOHA算法的部分碰撞，使碰撞周期减半，提高了信道的利用率。

function slot_length = slotted(M, deta)
s = size(M); % s=[pktNum,frameTime]  %deta =0.005
slot_length = zeros(s(1), s(2));
for i = 1:s(2)
    for j = 1:s(1)
        if M(j, i)/deta ~= floor(M(j, i)/deta) % 函数floor表示向下取整，如 floor(3.8)  ans=3； "~"表示不等于，非
            slot_length(j, i) = (floor(M(j, i)/deta)+1)*deta; % 每个时隙的长度要大等于标签回复的数据长度deta
        end
    end
end
end
