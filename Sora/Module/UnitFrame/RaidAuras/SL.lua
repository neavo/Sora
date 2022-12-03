-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local debuffs = {
	-- [] = { --
	--     ["general"] = {

	--     },
	--     [] = { --

	--     },
	-- },

	[1192] = {
		-- 暗影界
		[2430] = {},
		[2431] = {
			-- 莫塔尼斯
			338851 -- 尖啸头骨
		},
		[2432] = {},
		[2433] = {},
		[2456] = {},
		[2468] = {}
	},
	[1190] = {
		-- 纳斯利亚堡
		["general"] = {
			341863
		},
		[2393] = {
			-- 啸翼
			342077, -- 回声定位
			341684, -- 猩红灯笼
			346301, -- 血光
			343365, -- 极度恐怖
			328897, -- 抽干
			330713, -- 裂耳尖啸
			340324, -- 鲜血脓液
			345397 -- 赤红声浪
		},
		[2429] = {
			-- 猎手阿尔迪莫
			338615, -- 邪恶箭
			334945, -- 凶恶猛扑
			334852, -- 石化嚎叫
			335111, -- 猎手印记
			335114, -- 寻罪箭
			334971, -- 锯齿利爪
			334708, -- 致命咆哮
			334893, -- 尖石裂片
			334960 -- 恶毒之伤
		},
		[2422] = {
			-- 太阳之王的救赎
			325873, -- 燃烬风暴
			341473, -- 猩红乱舞
			328889, -- 至高惩戒
			333002, -- 劣民印记
			325442, -- 征服
			326456, -- 炽燃残骸
			326430, -- 残留余烬
			328479, -- 锁定目标
			328579, -- 阴燃余烬
			339251 -- 干涸之魂
		},
		[2418] = {
			-- 圣物匠赛·墨克斯
			340860, -- 枯萎之触
			325361, -- 毁灭符文
			327414, -- 附身
			326302, -- 静滞陷阱
			328448, -- 空间撕裂
			327902, -- 锁定
			340533 -- 奥术易伤
			-- 340870, -- 恐怖光环
		},
		[2428] = {
			-- 饥饿的毁灭者
			329298, -- 暴食瘴气
			334755, -- 精华滴液
			334228 -- 不稳定的喷发
		},
		[2420] = {
			-- 伊涅瓦·暗脉女勋爵
			324982, -- 共受苦难
			325908, -- 共享认知
			332664, -- 浓缩心能
			340477, -- 高度浓缩心能
			325382, -- 扭曲欲望
			340452, -- 变心
			331573, -- 无边悔罪
			326538, -- 心能之网
			325718 -- 残留心能
		},
		[2426] = {
			-- 猩红议会
			346651, -- 吸取精华
			347350, -- 舞力全开
			327619, -- 鲜血华尔兹
			331636, -- 黑暗伴舞
			346681, -- 灵魂尖刺
			346690, -- 决斗者的还击
			327503, -- 回闪步
			337110, -- 惊骇箭雨
			346945, -- 痛苦具象
			346932, -- 蹩脚舞步
			330848 -- 跳错了
		},
		[2394] = {
			-- 泥拳
			335470, -- 锁链猛击
			339189, -- 锁链渗血
			342419, -- 锁起来！
			335300, -- 锁链联结
			335295, -- 粉碎锁链
			331209, -- 怨恨凝视
			332572, -- 碎石飞落
			335361 -- 石震
			-- 332197, -- 地基坍塌
			-- 332443, -- 震动的地基
		},
		[2425] = {
			-- 顽石军团干将
			334765, -- 裂心击
			334771, -- 溢血之心
			333377, -- 邪恶印记
			339690, -- 晶化
			339693, -- 晶体爆炸
			344655, -- 震荡易伤
			342735, -- 贪婪盛宴
			342425, -- 石拳
			343881, -- 锯齿撕裂
			333913, -- 邪恶撕裂
			344502, -- 立足不稳
			334498, -- 地震岩层
			343063 -- 大地之刺
		},
		[2424] = {
			-- 德纳修斯大帝
			327796, -- 午夜猎手
			327039, -- 喂食时间
			329951, -- 穿刺
			332794, -- 致命灵巧
			332797, -- 致命灵巧
			328276, -- 悔悟之行
			329906, -- 屠戮
			329181, -- 毁灭痛苦
			327842, -- 黑夜之触
			332619, -- 粉碎痛苦
			338683, -- 纳斯利亚赞歌-罪灼
			338685, -- 纳斯利亚赞歌-恒影
			338686, -- 纳斯利亚赞歌-暮虚
			338688, -- 纳斯利亚赞歌-晦纱
			335873, -- 积恨
			327992, -- 荒芜
			332585, -- 蔑视
			326851, -- 血债
			332734 -- 盛怒
			-- 326699, -- 罪孽烦扰
		}
	},
	[1193] = {
		-- 统御圣所
		["general"] = {
			358699, -- 致命的命运
			355212, -- 恐怖怒嚎
			357553, -- 活动炸弹
			357128, -- 狱卒锁链
			358748, -- 重拳猛击
			357288, -- 冥河之握
			355063, -- 碎裂打击
			357565 -- 烈焰护手
		},
		[2435] = {
			-- 塔拉格鲁
			347269, -- 永恒锁链
			347286, -- 不散之惧
			357431, -- 死亡攫握
			347283, -- 捕食者之嚎
			346985, -- 压制
			346986 -- 粉碎护甲
		},
		[2442] = {
			-- 典狱长之眼
			358610, -- 凄凉光波
			350713, -- 倦怠腐化
			351827, -- 蔓延痛苦
			354004, -- 破裂灵魂
			348074, -- 痛击长枪
			351143, -- 死亡锁链
			349979, -- 牵引锁链
			350604 -- 绝望倦怠
			-- 351826, -- 苦难
			-- 348969, -- 即刻屠灭
		},
		[2439] = {
			-- 九武神
			350542, -- 命运残片
			350039, -- 阿尔苏拉的粉碎凝视
			350184, -- 达丝琪拉的威猛冲击
			350109, -- 布琳佳的悲恸挽歌
			350202, -- 无尽之击
			350475, -- 灵魂穿透
			350482, -- 联结精华
			350555 -- 命运碎片
			-- 350287, -- 终约之歌
		},
		[2444] = {
			-- 耐奥祖的残迹
			350469, -- 怨毒
			350388, -- 悲伤前行
			350489, -- 怨毒残迹
			354534, -- 怨恨
			349890, -- 苦难
			"350073" -- 折磨
		},
		[2445] = {
			-- 裂魂者多尔玛赞
			350647, -- 折磨烙印
			348987, -- 好战者枷锁
			350422, -- 毁灭之刃
			"350217", -- 折磨
			350851 -- 聚魂之河
			-- 354231, -- 灵魂镣铐
		},
		[2443] = {
			-- 痛楚工匠莱兹纳尔
			355506, -- 影铸锁链
			348456, -- 烈焰套索陷阱
			-- 356472, -- 萦绕烈焰
			355568, -- 十字刃斧
			348508, -- 震颤铁锤
			355778, -- 双刃镰刀
			348363, -- 尖刺铁球
			355526, -- 尖刺
			355786 -- 黑化护甲
		},
		[2446] = {
			-- 初诞者的卫士
			350496, -- 净除威胁
			352833, -- 分解
			350732, -- 破甲
			355357, -- 湮灭
			347359 -- 压制力场
			-- 352394, -- 光辉能量
		},
		[2447] = {
			-- 命运撰写师罗-卡洛
			354964, -- 符文亲和
			356065, -- 永恒之唤
			353162, -- 宿命残片
			357144, -- 绝望
			351680, -- 祈求宿命
			353432, -- 命运重担
			353931, -- 扭曲命运
			350355 -- 宿命联结
			-- 353435, -- 不堪重负
		},
		[2440] = {
			-- 克尔苏加德
			"348760", -- 冰霜冲击
			347292, -- 湮灭回响
			355389, -- 无情追击
			357298, -- 冻结之缚
			"348978", -- 灵魂疲惫
			352381, -- 冻结冲击
			355058, -- 冰川之风
			353808, -- 冰川之怒
			354639, -- 深度冻结
			354208 -- 咆哮风暴
			-- 354289, -- 险恶瘴气
		},
		[2441] = {
			-- 希尔瓦娜斯·风行者
			358704, -- 黑蚀箭
			358711, -- 怒气
			351562, -- 驱逐
			351589, -- 污秽
			348064, -- 哀恸箭
			353929, -- 女妖的灾厄
			351117, -- 恐惧压迫
			347704, -- 黑暗帷幕
			349458, -- 统御锁链
			351091, -- 动荡能量
			351180, -- 闪袭创伤
			351870, -- 索命妖魂
			347607, -- 女妖的印记
			347670, -- 暗影匕首
			347807, -- 倒刺之箭
			356651 -- 悲哀
		}
	},
	[1195] = {
		-- 初诞者圣墓
		["general"] = {},
		[2458] = {
			-- 警戒卫士
			359610, -- 移除解析
			360458, -- 不稳定的核心
			367571, -- 烧灼
			366393, -- 烧灼消融
			364904, -- 反物质
			364881, -- 物质分解 (T)
			"364447", -- 不谐 (T)
			360414 -- 气动冲击 (T)
			-- 360202, -- 造物尖刺
		}, -- [1]
		[2465] = {
			-- 司垢莱克斯，无穷噬灭者
			360448, -- 呕吐
			364522, -- 吞噬之血
			360098, -- 折跃恶感
			359976, -- 裂隙之喉 (T)
			359981 -- 撕裂 (T)
			-- 359778, -- 幻磷之尘
		}, -- [2]
		[2470] = {
			-- 圣物匠赛·墨克斯
			362614, -- 空间撕裂
			363413, -- 源生法环
			362850, -- 凌光火花新星
			362732, -- 重组
			362882, -- 静滞陷阱
			364030, -- 衰弱射线
			362803, -- 位移雕文 (T)
			362837, -- 奥术易伤 (T)
			365681 -- 巨力冲击
			-- 363114, -- 源生超新星
		}, -- [3]
		[2459] = {
			-- 道茜歌妮，堕落先知
			"361018", -- 震颤弹幕
			365720, -- 统御之握
			361751, -- 衰变光环
			361966, -- 注能打击 (T)
			362008, -- 注能易伤 (T)
			361225, -- 侵蚀统御
			"-364289" -- 震颤弹幕 (易伤)
		}, -- [4]
		[2460] = {
			-- 死亡万神殿原型体
			361745, -- 午夜猎手
			361067, -- 晋升堡垒的结界
			360687, -- 刻符者的死亡之触
			364839, -- 罪孽投影
			362352, -- 被压制
			362383, -- 心能箭矢
			360259, -- 幽影箭
			365269, -- 挫心打击 (T)
			361689, -- 毁灭痛苦 (T)
			361784, -- 黑夜之触 (易伤)
			360618, -- 坏疽
			366232 -- 心能风暴
			-- 361608, -- 罪孽烦扰
			-- 365306, -- 振奋之花
		}, -- [5]
		[2461] = {
			-- 首席造物师利许威姆
			364073, -- 退化
			362622, -- 不稳定的微粒
			360869, -- 被征用 -- REVIEW:
			366012, -- 终结微粒
			363795, -- 解构能量
			363538, -- 原生体耀光
			363681, -- 解构冲击 (T)
			368024, -- 动能共振 (T)
			368025, -- 碎裂共振 (T)
			368740, -- 旋律对接
			368738 -- 谐波对接
		}, -- [6]
		[2463] = {
			-- 回收者黑伦度斯
			361675, -- 碎地者飞弹
			368347, -- 欧米茄铭文
			365297, -- 挤压棱镜
			361309, -- 碎光射线 (T)
			368961, -- 炸弹暴露
			367838, -- 幻磷裂隙
			361597 -- 幻磷喷发
			-- 365976, -- 幻磷爆发
		}, -- [7]
		[2469] = {
			-- 安度因·乌瑞恩
			364020, -- 诅咒进军
			365021, -- 邪恶之星
			367632, -- 强化邪恶之星
			361992, -- 自负
			361993, -- 无望
			366849, -- 御言术-痛
			365008, -- 心灵惊怖
			362774, -- 灵魂收割 (T)
			362394, -- 绝望之雨
			"365300" -- 亵渎 -- REVIEW:
			-- 363024, -- 通灵引爆
			-- 362055, -- 失落之魂
			-- 365445, -- 创伤之魂
		}, -- [8]
		[2457] = {
			-- 恐惧双王
			360241, -- 不安梦境
			360012, -- 腐臭之云
			360146, -- 恐惧战栗
			366551, -- 开裂静脉 (T)
			360287, -- 苦痛打击 (T)
			364985 -- 啃噬伤口
			-- 360418, -- 妄念
		}, -- [9]
		[2467] = {
			-- 莱葛隆
			362417, -- 侵蚀性伪本影
			364386, -- 引力坍缩
			362206, -- 事件视界
			364381, -- 星辰凋零
			362088, -- 宇宙失常
			362081, -- 宇宙喷射
			366379, -- 星辰遮蔽
			362384, -- 永恒辐射
			362081, -- 宇宙喷射
			366731, -- 弧光喷射
			361548, -- 黑暗之蚀
			363110, -- 天界终结者
			362137 -- 腐蚀伤口 (T)
		}, -- [10]
		[2464] = {
			-- 典狱长
			360281, -- 咒罚符文
			366285, -- 强迫符文
			365150, -- 统御符文
			"365219", -- 痛苦之链
			"365222", -- 痛苦之链
			366020, -- 残暴印记
			366132, -- 残暴
			363886, -- 禁锢
			363893, -- 殉难 (T)
			359868, -- 粉碎冲击 (T)
			366545, -- 残害 (T)
			362192, -- 无情哀难 (易伤)
			"365174", -- 亵渎
			362397, -- 强迫
			362075 -- 统御
			-- 365153, -- 统御意志
			-- 362401, -- 折磨
			-- 362631, -- 压迫之链
			-- 365385, -- 厌恶号叫
			-- 362194, -- 苦痛
		} -- [11]
	},
	[1187] = {
		-- 伤逝剧场
		["general"] = {
			340143, -- 破胆怒吼
			331288, -- 巨人打击
			330810, -- 束缚灵魂
			330700, -- 腐烂凋零
			330532, -- 锯齿箭
			333845, -- 失衡重击
			323825, -- 攫取裂隙
			330562, -- 挫志怒吼
			341949, -- 枯萎凋零
			330700, -- 腐烂凋零
			333861, -- 回旋利刃
			342675, -- 骨矛
			330725, -- 暗影易伤
			333708, -- 灵魂腐蚀
			333299, -- 荒芜诅咒
			330784, -- 通灵箭
			330868 -- 通灵箭雨
		},
		[2397] = {
			-- 狭路相逢
			333540, -- 机会打击
			326892, -- 锁定
			320069, -- 致死打击
			320248, -- 基因变异
			333231 -- 灼热之陨
		},
		[2401] = {
			-- 斩血
			323406 -- 锯齿创口
		},
		[2390] = {
			-- 无堕者哈夫
			320287, -- 鲜血与荣耀
			331606 -- 压制战旗
		},
		[2389] = {
			-- 库尔萨洛克
			319626, -- 幻影寄生
			319521, -- 抽取灵魂
			319531, -- 抽取灵魂
			319539, -- 无魂者
			333567, -- 占据
			330810, -- 束缚灵魂
			342691, -- 攫取之手
			319669 -- 幽灵界域
		},
		[2417] = {
			-- 无尽女皇莫德蕾莎
			323831, -- 死亡之攫
			324449 -- 死亡具象
		}
	},
	[1183] = {
		-- 凋魂之殇
		["general"] = {
			334926, -- 猥琐痰液
			328501, -- 魔药炸弹
			319070, -- 腐蚀泥胶
			320512, -- 侵蚀爪击
			320542, -- 荒芜凋零
			327515, -- 腐沼钉刺
			328429, -- 窒息勒压
			319898, -- 邪恶喷吐
			328180, -- 攫握感染
			328409, -- 纠结缠网
			328986, -- 剧烈爆炸
			335882, -- 附身感染
			328395 -- 剧毒打击
		},
		[2419] = {
			-- 酤团
			324652, -- 衰弱魔药
			326242 -- 软泥浪潮
		},
		[2403] = {
			-- 伊库斯博士
			329110, -- 软泥注射
			322358, -- 燃灼菌株
			322410 -- 凋零污秽
		},
		[2423] = {
			-- 多米娜·毒刃
			325552, -- 毒性裂击
			336306, -- 裹体之网
			331818, -- 暗影伏击
			336258, -- 落单狩猎
			333353, -- 暗影伏击
			333406 -- 伏击
		},
		[2404] = {
			-- 斯特拉达玛侯爵
			331399, -- 感染毒雨
			322492 -- 魔药溃烂
		}
	},
	[1194] = {
		-- 塔扎维什，帷纱集市
		["general"] = {
			356031, -- 静滞射线
			351960, -- 静电附着
			351956, -- 高价值目标
			347716, -- 开信刀
			355832, -- 迅斩
			355480, -- 致命武力
			357281, -- 能量挥砍
			357029, -- 超光速炸弹
			355476, -- 震荡地雷
			358131, -- 闪电新星
			358168, -- 休克
			356324, -- 强化约束雕文
			355915, -- 约束雕文
			355641, -- 闪烁
			357019, -- 光尘闪回
			355502, -- 震光屏障
			356943, -- 封锁
			356548, -- 辐射脉冲
			356011, -- 光线切分者
			355581, -- 连环爆裂
			358947, -- 燃烧沥青
			-347728 -- 群殴！
		},
		[2437] = {
			-- 哨卫佐·菲克斯
			347949, -- 审讯
			345990, -- 监禁室
			345770, -- 扣押违禁品
			348366 -- 武装安保
		},
		[2454] = {
			-- 卖品会
			349954, -- 净化协议
			350101, -- 诅咒锁链
			349627 -- 暴食
		},
		[2436] = {
			-- 收发室乱战
			346962, -- 现金汇款
			346844, -- 炼金残渣
			346297, -- 动荡爆炸
			356374, -- 不稳定的货物
			346329 -- 四溅液体
		},
		[2452] = {
			-- 麦扎的绿洲
			353835, -- 压制
			355439, -- 压制冲击
			357485, -- 音乐痴迷
			357404 -- 刺耳歌唱
		},
		[2451] = {
			-- 索·阿兹密
			347150, -- 三重秘术
			357188, -- 双重秘术
			347481, -- 奥能手里波
			347744 -- 迅斩
		},
		[2448] = {
			-- 希尔布兰德
			348437, -- 旁路代码：赫尔威提
			348447, -- 旁路代码：里斯
			348450, -- 旁路代码：福莱瑟
			348451, -- 旁路代码：摩尔科
			346961, -- 净化之地
			347094, -- 泰坦粉碎
			355360 -- 符文反馈
		},
		[2449] = {
			-- 时空船长钩尾
			352345, -- 船锚射击
			354334, -- 被钩住！
			347149, -- 永恒吐息
			347850 -- 时间延缓
		},
		[2455] = {
			-- 索·莉亚
			351101, -- 能量裂片
			357190, -- 星辰易伤
			351119, -- 闪击手里剑
			350804, -- 坍缩能量
			350885 -- 超光速震荡
		}
	},
	[1184] = {
		-- 塞兹仙林的迷雾
		["general"] = {
			324859, -- 木棘缠绕
			325418, -- 不稳定的酸液
			322968, -- 濒死之息
			322557, -- 灵魂分裂
			326092, -- 衰弱毒药
			325224, -- 心能注入
			322487, -- 过度生长
			322939, -- 收割精魂
			325021, -- 纱雾撕裂
			323043, -- 放血
			331721, -- 长矛乱舞
			325027, -- 荆棘爆发
			340300, -- 毒舌鞭笞
			340208 -- 碎甲
		},
		[2400] = {
			-- 英格拉·马洛克
			328756, -- 憎恨之容
			323146, -- 死亡之拥
			323250 -- 心能泥浆
		},
		[2402] = {
			-- 唤雾者
			321891, -- 鬼抓人锁定
			321893, -- 冻结爆发
			321828 -- 肉饼蛋糕
		},
		[2405] = {
			-- 特雷德奥瓦
			337220, -- 寄生平静
			337251, -- 寄生瘫痪
			337253, -- 寄生占据
			322648, -- 心灵连接
			-- 331172, -- 心灵连接
			322563, -- 被标记的猎物
			326309 -- 腐烂酸液
		}
	},
	[1188] = {
		-- 彼界
		["general"] = {
			332605, -- 妖术
			332678, -- 龟裂创伤
			334505, -- 光尘之梦
			334493, -- 催眠光粉
			331847, -- W-00F
			333250, -- 放血之击
			334535, -- 啄裂
			333711, -- 衰弱之咬
			332707, -- 暗言术：痛
			331008, -- 黏黏弹
			331379 -- 润滑剂
		},
		[2408] = {
			-- 夺灵者哈卡
			322746, -- 堕落之血
			328987, -- 狂热
			323118 -- 鲜血弹幕
		},
		[2409] = {
			-- 法力风暴夫妇
			320786, -- 势不可挡
			323877, -- 反射手指型激光发射器究极版
			324010, -- 发射
			320144, -- 电锯
			320147, -- 流血
			320142, -- 末日魔王！
			320132, -- 暗影之怒
			320008 -- 寒冰箭
		},
		[2398] = {
			-- 商人赛·艾柯莎
			323687, -- 奥术闪电
			342961, -- 定向爆破计谋
			320232, -- 爆破计谋
			323692 -- 奥术易伤
		},
		[2410] = {
			-- 穆厄扎拉
			325725, -- 寰宇操控
			327649, -- 粉碎灵魂
			334913 -- 死亡之主
		}
	},
	[1186] = {
		-- 晋升高塔
		["general"] = {
			334721, -- 目标锁定故障
			317661, -- 险恶毒液
			327648, -- 内爆
			323744, -- 突袭
			27638, -- 斜掠
			317963, -- 知识烦扰
			328331, -- 严刑逼供
			"328434", -- 胁迫
			328453, -- 压迫
			323739 -- 残留冲击
		},
		[2399] = {
			-- 金-塔拉
			327481, -- 黑暗长枪
			324662, -- 离子电浆
			331251 -- 深度联结
		},
		[2416] = {
			-- 雯图纳柯丝
			324154, -- 暗影迅步
			324205 -- 炫目闪光
		},
		[2414] = {
			-- 奥莱芙莉安
			338731, -- 充能心能
			331997, -- 心能澎湃
			323195, -- 净化冲击波
			323792 -- 心能力场
		},
		[2412] = {
			-- 疑虑圣杰德沃丝
			322818, -- 失去信心
			322817 -- 疑云密布
		}
	},
	[1185] = {
		-- 赎罪大厅
		["general"] = {
			325876, -- 湮灭诅咒
			326874, -- 脚踝撕咬
			326891, -- 痛楚
			325701, -- 生命虹吸
			325700, -- 收集罪恶
			344993, -- 锯齿横扫
			326632, -- 石化血脉
			326617, -- 变为石头
			326638, -- 投掷战刃
			340446 -- 嫉妒之印
		},
		[2406] = {
			-- 哈尔吉亚斯，罪污巨像
			323001, -- 玻璃裂片
			-- 322977, -- 罪光幻象
			339237 -- 罪光幻象
		},
		[2387] = {
			-- 艾谢朗
			319603, -- 羁石诅咒
			344874, -- 粉碎
			319703, -- 鲜血洪流
			319611 -- 变成石头
		},
		[2411] = {
			-- 高阶裁决官阿丽兹
			323650 -- 萦绕锁定
		},
		[2413] = {
			-- 宫务大臣
			323437, -- 傲慢罪印
			335338 -- 哀伤仪式
		}
	},
	[1189] = {
		-- 赤红深渊
		["general"] = {
			334653, -- 饱餐
			322429, -- 撕裂切割
			321038, -- 灵魂损毁
			326836, -- 镇压诅咒
			322212, -- 滋长猜忌
			326827, -- 恐惧之缚
			336277, -- 愤怒爆炸
			335306, -- 尖刺镣铐
			330055 -- 爆扣！
			-- 326826, -- 压制气场
		},
		[2388] = {},
		[2415] = {
			-- 执行者塔沃德
			322554, -- 严惩
			328494, -- 罪触心能
			323573 -- 残渣
		},
		[2421] = {
			-- 大学监贝律莉娅
			328593, -- 苦痛刑罚
			325254, -- 钢铁尖刺
			325885 -- 苦恨痛哭
		},
		[2407] = {
			-- 卡尔将军
			323845, -- 邪恶冲刺
			331415 -- 邪恶创口
			-- 322796, -- 邪恶创口
			-- 327814, -- 邪恶创口
		}
	},
	[1182] = {
		-- 通灵战潮
		["general"] = {
			334748, -- 排干体液
			323471, -- 切肉飞刀
			321821, -- 作呕喷吐
			338353, -- 瘀液喷撒
			320717, -- 鲜血饥渴
			327396, -- 严酷命运
			334610, -- 无脑锁定
			321807, -- 白骨剥离
			338357, -- 暴捶
			324293, -- 刺耳尖啸
			333485, -- 疾病之云
			333477, -- 内脏切割
			320573, -- 暗影之井
			320462 -- 通灵箭
		},
		[2395] = {
			-- 凋骨
			320631, -- 腐肉爆发
			320596, -- 深重呕吐
			320646 -- 恶臭气体
		},
		[2391] = {
			-- 收割者阿玛厄斯
			333492, -- 通灵粘液
			333489, -- 通灵吐息
			320170, -- 通灵箭
			328664 -- 冰冻
		},
		[2392] = {
			-- 外科医生缝肉
			322681, -- 肉钩
			320200, -- 缝针
			320366, -- 防腐剂
			343556 -- 病态凝视
		},
		[2396] = {
			-- 缚霜者纳尔佐
			328181, -- 冷冽之寒
			323198, -- 黑暗放逐
			-- 320788, -- 冻结之缚
			323730, -- 冻结之缚
			-- 321956, -- 彗星风暴
			320784, -- 彗星风暴
			321755 -- 冰缚之盾
		}
	}
}

-- Event
local function OnInitialize(self, event, ...)
	C.UnitFrame = C.UnitFrame or {}
	C.UnitFrame.RaidAuras = C.UnitFrame.RaidAuras or {}
end

local function OnPlayerLogin(self, event, ...)
	local num = 19999
	local auras = C.UnitFrame.RaidAuras
	local k1, v1, k2, v2, k3, v3 = nil, nil, nil, nil, nil, nil

	for k1, v1 in pairs(debuffs) do
		for k2, v2 in pairs(v1) do
			for k3, v3 in pairs(v2) do
				num = num - 1
				auras[v3] = num
			end
		end
	end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.INITIALIZE = OnInitialize
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
