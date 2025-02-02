//
//  SkinChooserView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/29.
//

import SwiftUI

struct SkinChooserView: View {
    let skinsPath = [
        "#EveOneCat": "https://darock.top/meowbili/res/skin/#EveOneCat/#EveOneCat_package.zip",
        "12周年夏日狂欢": "https://darock.top/meowbili/res/skin/12周年夏日狂欢/12周年夏日狂欢_package.zip",
        "2020拜年祭": "https://darock.top/meowbili/res/skin/2020拜年祭/2020拜年祭_package.zip",
        "2021拜年祭": "https://darock.top/meowbili/res/skin/2021拜年祭/2021拜年祭_package.zip",
        "2021最美的夜魔法": "https://darock.top/meowbili/res/skin/2021最美的夜魔法/2021最美的夜魔法_package.zip",
        "2021最美的夜赛博": "https://darock.top/meowbili/res/skin/2021最美的夜赛博/2021最美的夜赛博_package.zip",
        "2022拜年纪": "https://darock.top/meowbili/res/skin/2022拜年纪/2022拜年纪_package.zip",
        "2022王者荣耀世冠": "https://darock.top/meowbili/res/skin/2022王者荣耀世冠/2022王者荣耀世冠_package.zip",
        "2023拜年纪": "https://darock.top/meowbili/res/skin/2023拜年纪/2023拜年纪_package.zip",
        "2233暗黑童话": "https://darock.top/meowbili/res/skin/#EveOneCat/2233暗黑童话_package.zip",
        "2233白色情人节": "https://darock.top/meowbili/res/skin/2233白色情人节/2233白色情人节_package.zip",
        "2233不思议之旅": "https://darock.top/meowbili/res/skin/2233不思议之旅/不思议之旅_package.zip",
        "2233电子喵": "https://darock.top/meowbili/res/skin/2233电子喵/电子喵_package.zip",
        "2233幻星集": "https://darock.top/meowbili/res/skin/2233幻星集/2233幻星集_package.zip",
        "2233魔法学院": "https://darock.top/meowbili/res/skin/2233魔法学院/魔法学院.zip",
        "2233人生百戏-花木兰": "https://darock.top/meowbili/res/skin/2233人生百戏-花木兰/2233人生百戏-花木兰_package.zip",
        "2233人生百戏·白蛇传": "https://darock.top/meowbili/res/skin/2233人生百戏·白蛇传/2233人生百戏·白蛇传_package.zip",
        "2233人生百戏·梁祝": "https://darock.top/meowbili/res/skin/2233人生百戏·梁祝/2233人生百戏·梁祝_package.zip",
        "2233人生百戏·牡丹亭": "https://darock.top/meowbili/res/skin/2233人生百戏·牡丹亭/2233人生百戏·牡丹亭_package.zip",
        "2233赛博朋克": "https://darock.top/meowbili/res/skin/2233赛博朋克/2233赛博朋克_package.zip",
        "2233山海故事": "https://darock.top/meowbili/res/skin/2233山海故事/2233山海故事_package.zip",
        "2233十一周年纪念": "https://darock.top/meowbili/res/skin/2233十一周年纪念/2233十一周年纪_package.zip",
        "2233夏日冰品": "https://darock.top/meowbili/res/skin/2233夏日冰品/2233夏日冰品_package.zip",
        "阿狸·冬日来信": "https://darock.top/meowbili/res/skin/阿狸·冬日来信/阿狸·冬日来信_package.zip",
        "阿萨Aza": "https://darock.top/meowbili/res/skin/阿萨Aza/阿萨Aza_package.zip",
        "阿萨Aza-多面体": "https://darock.top/meowbili/res/skin/阿萨Aza-多面体/阿萨Aza-多面体_package.zip",
        "阿山和他的朋友们": "https://darock.top/meowbili/res/skin/阿山和他的朋友们/阿山和他的朋友们_package.zip",
        "阿巳与小铃铛": "https://darock.top/meowbili/res/skin/阿巳与小铃铛/阿巳与小铃铛_package.zip",
        "阿梓从小就很可爱": "https://darock.top/meowbili/res/skin/阿梓从小就很可爱/阿梓从小就很可爱_package.zip",
        "阿梓从小就很可爱新装扮": "https://darock.top/meowbili/res/skin/阿梓从小就很可爱新装扮/阿梓从小就很可爱新装扮_package.zip",
        "爱宠大机密·喜迎兔兔": "https://darock.top/meowbili/res/skin/爱宠大机密·喜迎兔兔/爱宠大机密·喜迎兔兔_package.zip",
        "凹凸世界": "https://darock.top/meowbili/res/skin/凹凸世界/凹凸世界_package.zip",
        "凹凸世界第二弹": "https://darock.top/meowbili/res/skin/凹凸世界第二弹/凹凸世界第二弹_package.zip",
        "奥特曼系列": "https://darock.top/meowbili/res/skin/奥特曼系列/奥特曼系列_package.zip",
        "爸妈来自二次元": "https://darock.top/meowbili/res/skin/爸妈来自二次元/爸妈来自二次元_package.zip",
        "白蛇2：青蛇劫起": "https://darock.top/meowbili/res/skin/白蛇2：青蛇劫起/白蛇2：青蛇劫起_package.zip",
        "白神遥Haruka": "https://darock.top/meowbili/res/skin/白神遥Haruka/白神遥Haruka_package.zip",
        "百变星瞳": "https://darock.top/meowbili/res/skin/百变星瞳/百变星瞳_package.zip",
        "百鬼幼儿园": "https://darock.top/meowbili/res/skin/百鬼幼儿园/百鬼幼儿园_package.zip",
        "百妖谱": "https://darock.top/meowbili/res/skin/百妖谱/百妖谱_package.zip",
        "百妖谱第二季": "https://darock.top/meowbili/res/skin/百妖谱第二季/百妖谱第二季_package.zip",
        "绊爱第二弹": "https://darock.top/meowbili/res/skin/绊爱第二弹/绊爱第二弹_package.zip",
        "贝拉个性装扮2.0": "https://darock.top/meowbili/res/skin/贝拉个性装扮2.0/贝拉个性装扮2.0_package.zip",
        "贝拉kira": "https://darock.top/meowbili/res/skin/贝拉kira/贝拉kira_package.zip",
        "崩坏3·光辉矢愿": "https://darock.top/meowbili/res/skin/崩坏3·光辉矢愿/崩坏3·光辉矢愿_package.zip",
        "崩坏3·雷鸣彻空": "https://darock.top/meowbili/res/skin/崩坏3·雷鸣彻空/崩坏3·雷鸣彻空_package.zip",
        "崩坏3·天穹流星": "https://darock.top/meowbili/res/skin/崩坏3·天穹流星/崩坏3·天穹流星_package.zip",
        "崩坏3·终焉归始": "https://darock.top/meowbili/res/skin/崩坏3·终焉归始/崩坏3·终焉归始_package.zip",
        "崩坏学园2": "https://darock.top/meowbili/res/skin/崩坏学园2/崩坏学园2_package.zip",
        "哔哩哔哩舞蹈嘉年华": "https://darock.top/meowbili/res/skin/哔哩哔哩舞蹈嘉年华/哔哩哔哩舞蹈嘉年华_package.zip",
        "碧蓝航线2020": "https://darock.top/meowbili/res/skin/碧蓝航线2020/碧蓝航线2020_package.zip",
        "冰糖IO 蜕变·闪耀": "https://darock.top/meowbili/res/skin/冰糖IO 蜕变·闪耀/冰糖IO 蜕变·闪耀_package.zip",
        "博柏利：无尽探索": "https://darock.top/meowbili/res/skin/博柏利：无尽探索/博柏利：无尽探索_package.zip",
        "菜菜子": "https://darock.top/meowbili/res/skin/菜菜子/菜菜子_package.zip",
        "草莓大福": "https://darock.top/meowbili/res/skin/草莓大福/草莓大福_package.zip",
        "测不准的阿波连同学": "https://darock.top/meowbili/res/skin/测不准的阿波连同学/测不准的阿波连同学_package.zip",
        "查理苏": "https://darock.top/meowbili/res/skin/查理苏/查理苏_package.zip",
        "茶啊二中居居男孩日常": "https://darock.top/meowbili/res/skin/茶啊二中居居男孩日常/茶啊二中居居男孩日常_package.zip",
        "茶茶龙": "https://darock.top/meowbili/res/skin/茶茶龙/茶茶龙_package.zip",
        "沉默寡言白河愁": "https://darock.top/meowbili/res/skin/沉默寡言白河愁/沉默寡言白河愁_package.zip",
        "出游季": "https://darock.top/meowbili/res/skin/出游季/出游季_package.zip",
        "初音未来-日版": "https://darock.top/meowbili/res/skin/初音未来-日版/初音未来-日版_package.zip",
        "初音未来-夜版": "https://darock.top/meowbili/res/skin/初音未来-夜版/初音未来-夜版_package.zip",
        "初音未来圣诞快乐": "https://darock.top/meowbili/res/skin/初音未来圣诞快乐/初音未来圣诞快乐_package.zip",
        "初音未来周年纪念": "https://darock.top/meowbili/res/skin/初音未来周年纪念/初音未来周年纪念_package.zip",
        "初音未来V4C五周年": "https://darock.top/meowbili/res/skin/初音未来V4C五周年/初音未来V4C五周年_package.zip",
        "穿越西元3000后": "https://darock.top/meowbili/res/skin/穿越西元3000后/穿越西元3000后_package.zip",
        "传武": "https://darock.top/meowbili/res/skin/传武/传武_package.zip",
        "椎名菜羽": "https://darock.top/meowbili/res/skin/椎名菜羽/椎名菜羽_package.zip",
        "春季特辑·二月律动": "https://darock.top/meowbili/res/skin/春季特辑·二月律动/春季特辑·二月律动_package.zip",
        "春季特辑·鹿鹿套装": "https://darock.top/meowbili/res/skin/春季特辑·鹿鹿套装/春季特辑·鹿鹿套装_package.zip",
        "春季特辑·暖春双人游": "https://darock.top/meowbili/res/skin/春季特辑·暖春双人游/春季特辑·暖春双人游_package.zip",
        "春节许愿": "https://darock.top/meowbili/res/skin/春节许愿/春节许愿_package.zip",
        "春日限定花园蜜语": "https://darock.top/meowbili/res/skin/春日限定花园蜜语/春日限定花园蜜语_package.zip",
        "刺客信条15周年": "https://darock.top/meowbili/res/skin/刺客信条15周年/刺客信条15周年_package.zip",
        "湊-阿库娅": "https://darock.top/meowbili/res/skin/湊-阿库娅/湊-阿库娅_package.zip",
        "大炒面制造者CEN": "https://darock.top/meowbili/res/skin/大炒面制造者CEN/大炒面制造者CEN_package.zip",
        "大航海韩小沐": "https://darock.top/meowbili/res/skin/大航海韩小沐/大航海韩小沐_package.zip",
        "大航海嘉然": "https://darock.top/meowbili/res/skin/大航海嘉然/大航海嘉然_package.zip",
        "大航海舰长": "https://darock.top/meowbili/res/skin/大航海舰长/大航海舰长_package.zip",
        "大航海提督": "https://darock.top/meowbili/res/skin/大航海提督/大航海提督_package.zip",
        "大航海逍遥散人": "https://darock.top/meowbili/res/skin/大航海逍遥散人/大航海逍遥散人_package.zip",
        "大航海总督": "https://darock.top/meowbili/res/skin/大航海总督/大航海总督_package.zip",
        "大会员5周年": "https://darock.top/meowbili/res/skin/大会员5周年/大会员5周年_package.zip",
        "大理寺日志": "https://darock.top/meowbili/res/skin/大理寺日志/大理寺日志_package.zip",
        "大王不高兴": "https://darock.top/meowbili/res/skin/大王不高兴/大王不高兴_package.zip",
        "呆呆小可爱": "https://darock.top/meowbili/res/skin/呆呆小可爱/呆呆小可爱_package.zip",
        "蛋酒一家": "https://darock.top/meowbili/res/skin/蛋酒一家/蛋酒一家_package.zip",
        "登乐V计划": "https://darock.top/meowbili/res/skin/登乐V计划/登乐V计划_package.zip",
        "第五人格": "https://darock.top/meowbili/res/skin/第五人格/第五人格_package.zip",
        "东爱璃Lovely": "https://darock.top/meowbili/res/skin/东爱璃Lovely/东爱璃Lovely_package.zip",
        "冬日颂歌欧皇套装": "https://darock.top/meowbili/res/skin/冬日颂歌欧皇套装/冬日颂歌欧皇套装_package.zip",
        "東雪蓮": "https://darock.top/meowbili/res/skin/東雪蓮/東雪蓮_package.zip",
        "杜松子_Gin": "https://darock.top/meowbili/res/skin/杜松子_Gin/杜松子_Gin_package.zip",
        "多多poi": "https://darock.top/meowbili/res/skin/多多poi/多多poi_package.zip",
        "凡人修仙传": "https://darock.top/meowbili/res/skin/凡人修仙传/凡人修仙传_package.zip",
        "饭粒猫与包子鸭": "https://darock.top/meowbili/res/skin/饭粒猫与包子鸭/饭粒猫与包子鸭_package.zip",
        "非人哉": "https://darock.top/meowbili/res/skin/非人哉/非人哉_package.zip",
        "绯赤艾莉欧": "https://darock.top/meowbili/res/skin/绯赤艾莉欧/绯赤艾莉欧_package.zip",
        "肥肥鲨": "https://darock.top/meowbili/res/skin/肥肥鲨/肥肥鲨_package.zip",
        "肥肥鲨打工人": "https://darock.top/meowbili/res/skin/肥肥鲨打工人/肥肥鲨打工人_package.zip",
        "粉红兔子": "https://darock.top/meowbili/res/skin/粉红兔子/粉红兔子_package.zip",
        "疯狂兔子宇宙博物馆": "https://darock.top/meowbili/res/skin/疯狂兔子宇宙博物馆/疯狂兔子宇宙博物馆_package.zip",
        "扶桑大红花": "https://darock.top/meowbili/res/skin/扶桑大红花/扶桑大红花_package.zip",
        "干物妹！小埋": "https://darock.top/meowbili/res/skin/干物妹！小埋/干物妹！小埋_package.zip",
        "高能手办团": "https://darock.top/meowbili/res/skin/高能手办团/高能手办团_package.zip",
        "工作细胞": "https://darock.top/meowbili/res/skin/工作细胞/工作细胞_package.zip",
        "古守血遊": "https://darock.top/meowbili/res/skin/古守血遊/古守血遊_package.zip",
        "怪盗基德": "https://darock.top/meowbili/res/skin/怪盗基德/怪盗基德_package.zip",
        "莞儿睡不醒": "https://darock.top/meowbili/res/skin/莞儿睡不醒/莞儿睡不醒_package.zip",
        "桂客盈门": "https://darock.top/meowbili/res/skin/桂客盈门/桂客盈门_package.zip",
        "还有醒着的么": "https://darock.top/meowbili/res/skin/还有醒着的么/还有醒着的么_package.zip",
        "还有醒着的么2.0": "https://darock.top/meowbili/res/skin/还有醒着的么2.0/还有醒着的么2.0_package.zip",
        "海伊": "https://darock.top/meowbili/res/skin/海伊/海伊_package.zip",
        "黑潮之上": "https://darock.top/meowbili/res/skin/黑潮之上/黑潮之上_package.zip",
        "黑猫大少爷": "https://darock.top/meowbili/res/skin/黑猫大少爷/黑猫大少爷_package.zip",
        "黑门": "https://darock.top/meowbili/res/skin/黑门/黑门_package.zip",
        "黑鸦鸦": "https://darock.top/meowbili/res/skin/黑鸦鸦/黑鸦鸦_package.zip",
        "黑泽诺亚NOIR": "https://darock.top/meowbili/res/skin/黑泽诺亚NOIR/黑泽诺亚NOIR_package.zip",
        "黑之召唤士": "https://darock.top/meowbili/res/skin/黑之召唤士/黑之召唤士_package.zip",
        "胡桃Usa": "https://darock.top/meowbili/res/skin/胡桃Usa/胡桃Usa_package.zip",
        "虎皮喵一家": "https://darock.top/meowbili/res/skin/虎皮喵一家/虎皮喵一家_package.zip",
        "花花雪精灵": "https://darock.top/meowbili/res/skin/花花雪精灵/花花雪精灵_package.zip",
        "花卷羊": "https://darock.top/meowbili/res/skin/花卷羊/花卷羊_package.zip",
        "花丸晴琉": "https://darock.top/meowbili/res/skin/花丸晴琉/花丸晴琉_package.zip",
        "花园Serena": "https://darock.top/meowbili/res/skin/花园Serena/花园Serena_package.zip",
        "幻塔": "https://darock.top/meowbili/res/skin/幻塔/幻塔_package.zip",
        "黄绿合战5th": "https://darock.top/meowbili/res/skin/黄绿合战5th/黄绿合战5th_package.zip",
        "黄油小狗": "https://darock.top/meowbili/res/skin/黄油小狗/黄油小狗_package.zip",
        "姬拉Kira": "https://darock.top/meowbili/res/skin/姬拉Kira/姬拉Kira_package.zip",
        "珈乐Carol": "https://darock.top/meowbili/res/skin/珈乐Carol/珈乐Carol_package.zip",
        "嘉然个性装扮2.0": "https://darock.top/meowbili/res/skin/嘉然个性装扮2.0/嘉然个性装扮2.0_package.zip",
        "嘉然今天吃什么": "https://darock.top/meowbili/res/skin/嘉然今天吃什么/嘉然今天吃什么_package.zip",
        "剑网3·侠肝义胆沈剑心": "https://darock.top/meowbili/res/skin/剑网3·侠肝义胆沈剑心/剑网3·侠肝义胆沈剑心_package.zip",
        "剑与远征": "https://darock.top/meowbili/res/skin/剑与远征/剑与远征_package.zip",
        "今天鸽子球咕咕了吗": "https://darock.top/meowbili/res/skin/今天鸽子球咕咕了吗/今天鸽子球咕咕了吗_package.zip",
        "进化之实": "https://darock.top/meowbili/res/skin/进化之实/进化之实_package.zip",
        "进化之实 踏上胜利的人生": "https://darock.top/meowbili/res/skin/进化之实 踏上胜利的人生/进化之实 踏上胜利的人生_package.zip",
        "进击的冰糖": "https://darock.top/meowbili/res/skin/进击的冰糖/进击的冰糖_package.zip",
        "旌旗卷平川": "https://darock.top/meowbili/res/skin/旌旗卷平川/旌旗卷平川_package.zip",
        "镜音铃·连": "https://darock.top/meowbili/res/skin/镜音铃·连/镜音铃·连_package.zip",
        "九重紫": "https://darock.top/meowbili/res/skin/九重紫/九重紫_package.zip",
        "决战！平安京-灯影戏梦": "https://darock.top/meowbili/res/skin/决战！平安京-灯影戏梦/决战！平安京-灯影戏梦_package.zip",
        "君有云": "https://darock.top/meowbili/res/skin/君有云/君有云_package.zip",
        "咖喱饭": "https://darock.top/meowbili/res/skin/咖喱饭/咖喱饭_package.zip",
        "卡慕SaMa": "https://darock.top/meowbili/res/skin/卡慕SaMa/卡慕SaMa_package.zip",
        "坎公骑冠剑": "https://darock.top/meowbili/res/skin/坎公骑冠剑/坎公骑冠剑_package.zip",
        "靠你啦！战神系统": "https://darock.top/meowbili/res/skin/靠你啦！战神系统/靠你啦！战神系统_package.zip",
        "柯南万圣节的新娘": "https://darock.top/meowbili/res/skin/柯南万圣节的新娘/柯南万圣节的新娘_package.zip",
        "可爱联盟-新年特辑": "https://darock.top/meowbili/res/skin/可爱联盟-新年特辑/可爱联盟-新年特辑_package.zip",
        "可爱团子": "https://darock.top/meowbili/res/skin/可爱团子/可爱团子_package.zip",
        "瀬兎一也": "https://darock.top/meowbili/res/skin/瀬兎一也/瀬兎一也_package.zip",
        "兰音Reine": "https://darock.top/meowbili/res/skin/兰音Reine/兰音Reine_package.zip",
        "蓝色时期": "https://darock.top/meowbili/res/skin/蓝色时期/蓝色时期_package.zip",
        "蓝溪镇": "https://darock.top/meowbili/res/skin/蓝溪镇/蓝溪镇_package.zip",
        "懒懒兔": "https://darock.top/meowbili/res/skin/懒懒兔/懒懒兔_package.zip",
        "狼行者": "https://darock.top/meowbili/res/skin/狼行者/狼行者_package.zip",
        "老E": "https://darock.top/meowbili/res/skin/老E/老E_package.zip",
        "乐正绫五周年纪念": "https://darock.top/meowbili/res/skin/乐正绫五周年纪念/乐正绫五周年纪念_package.zip",
        "乐正龙牙": "https://darock.top/meowbili/res/skin/乐正龙牙/乐正龙牙_package.zip",
        "蕾尔娜Leona": "https://darock.top/meowbili/res/skin/蕾尔娜Leona/蕾尔娜Leona_package.zip",
        "蕾蕾大表哥": "https://darock.top/meowbili/res/skin/蕾蕾大表哥/蕾蕾大表哥_package.zip",
        "冷兔宝宝": "https://darock.top/meowbili/res/skin/冷兔宝宝/冷兔宝宝_package.zip",
        "狸喵唤太子": "https://darock.top/meowbili/res/skin/狸喵唤太子/狸喵唤太子_package.zip",
        "例行纵火": "https://darock.top/meowbili/res/skin/例行纵火/例行纵火_package.zip",
        "炼气练了3000年": "https://darock.top/meowbili/res/skin/炼气练了3000年/炼气练了3000年_package.zip",
        "恋乃夜舞": "https://darock.top/meowbili/res/skin/恋乃夜舞/恋乃夜舞_package.zip",
        "良辰美景·不问天": "https://darock.top/meowbili/res/skin/良辰美景·不问天/良辰美景·不问天_package.zip",
        "两不疑": "https://darock.top/meowbili/res/skin/两不疑/两不疑_package.zip",
        "两不疑第二季": "https://darock.top/meowbili/res/skin/两不疑第二季/两不疑第二季_package.zip",
        "两米兔和两斤兔": "https://darock.top/meowbili/res/skin/两米兔和两斤兔/两米兔和两斤兔_package.zip",
        "量子少年-慕宇": "https://darock.top/meowbili/res/skin/量子少年-慕宇/量子少年-慕宇_package.zip",
        "烈火浇愁": "https://darock.top/meowbili/res/skin/烈火浇愁/烈火浇愁_package.zip",
        "灵魂潮汐周年庆典": "https://darock.top/meowbili/res/skin/灵魂潮汐周年庆典/灵魂潮汐周年庆典_package.zip",
        "泠鸢登门喜鹊": "https://darock.top/meowbili/res/skin/泠鸢登门喜鹊/泠鸢登门喜鹊_package.zip",
        "泠鸢yousa": "https://darock.top/meowbili/res/skin/泠鸢yousa/泠鸢yousa_package.zip",
        "泠鸢yousa十周年": "https://darock.top/meowbili/res/skin/泠鸢yousa十周年/泠鸢yousa十周年_package.zip",
        "铃宫铃": "https://darock.top/meowbili/res/skin/铃宫铃/铃宫铃_package.zip",
        "琉绮Ruki": "https://darock.top/meowbili/res/skin/琉绮Ruki/琉绮Ruki_package.zip",
        "陆沉": "https://darock.top/meowbili/res/skin/陆沉/陆沉_package.zip",
        "陆夫人的Flag园": "https://darock.top/meowbili/res/skin/陆夫人的Flag园/陆夫人的Flag园_package.zip",
        "陆鳐LuLu": "https://darock.top/meowbili/res/skin/陆鳐LuLu/陆鳐LuLu_package.zip",
        "鹿乃": "https://darock.top/meowbili/res/skin/鹿乃/鹿乃_package.zip",
        "鹿乃桜帆": "https://darock.top/meowbili/res/skin/鹿乃桜帆/鹿乃桜帆_package.zip",
        "露早GOGO": "https://darock.top/meowbili/res/skin/露早GOGO/露早GOGO_package.zip",
        "罗小黑战记": "https://darock.top/meowbili/res/skin/罗小黑战记/罗小黑战记_package.zip",
        "罗伊": "https://darock.top/meowbili/res/skin/罗伊/罗伊_package.zip",
        "洛少爷": "https://darock.top/meowbili/res/skin/洛少爷/洛少爷_package.zip",
        "洛天依·最美的夜": "https://darock.top/meowbili/res/skin/洛天依·最美的夜/洛天依·最美的夜_package.zip",
        "洛天依8th生日纪念": "https://darock.top/meowbili/res/skin/洛天依8th生日纪念/洛天依8th生日纪念_package.zip",
        "洛天依9th生日纪念": "https://darock.top/meowbili/res/skin/洛天依9th生日纪念/洛天依9th生日纪念_package.zip",
        "洛天依十周年": "https://darock.top/meowbili/res/skin/洛天依十周年/洛天依十周年_package.zip",
        "马里奥红叔": "https://darock.top/meowbili/res/skin/马里奥红叔/马里奥红叔_package.zip",
        "猫不理咖啡": "https://darock.top/meowbili/res/skin/猫不理咖啡/猫不理咖啡_package.zip",
        "猫雷Nyaru": "https://darock.top/meowbili/res/skin/猫雷Nyaru/猫雷Nyaru_package.zip",
        "猫灵相册": "https://darock.top/meowbili/res/skin/猫灵相册/猫灵相册_package.zip",
        "猫诺装扮套装": "https://darock.top/meowbili/res/skin/猫诺装扮套装/猫诺装扮套装_package.zip",
        "猫之茗": "https://darock.top/meowbili/res/skin/猫之茗/猫之茗_package.zip",
        "美波七海": "https://darock.top/meowbili/res/skin/美波七海/美波七海_package.zip",
        "美月もも": "https://darock.top/meowbili/res/skin/美月もも/美月もも_package.zip",
        "美妆妖精COSELF": "https://darock.top/meowbili/res/skin/美妆妖精COSELF/美妆妖精COSELF_package.zip",
        "妹子与科学": "https://darock.top/meowbili/res/skin/妹子与科学/妹子与科学_package.zip",
        "萌宠狗狗": "https://darock.top/meowbili/res/skin/萌宠狗狗/萌宠狗狗_package.zip",
        "萌宠橘猫": "https://darock.top/meowbili/res/skin/萌宠橘猫/萌宠橘猫_package.zip",
        "萌宠小兔": "https://darock.top/meowbili/res/skin/萌宠小兔/萌宠小兔_package.zip",
        "萌宠小熊": "https://darock.top/meowbili/res/skin/萌宠小熊/萌宠小熊_package.zip",
        "萌节六周年装扮": "https://darock.top/meowbili/res/skin/萌节六周年装扮/萌节六周年装扮_package.zip",
        "萌妹": "https://darock.top/meowbili/res/skin/萌妹/萌妹_package.zip",
        "萌妻食神": "https://darock.top/meowbili/res/skin/萌妻食神/萌妻食神_package.zip",
        "萌妻食神2": "https://darock.top/meowbili/res/skin/萌妻食神2/萌妻食神2_package.zip",
        "梦音茶糯": "https://darock.top/meowbili/res/skin/梦音茶糯/梦音茶糯_package.zip",
        "米洛与米姐姐的冒险": "https://darock.top/meowbili/res/skin/米洛与米姐姐的冒险/米洛与米姐姐的冒险_package.zip",
        "米诺高分少女": "https://darock.top/meowbili/res/skin/米诺高分少女/米诺高分少女_package.zip",
        "喵铃铛": "https://darock.top/meowbili/res/skin/喵铃铛/喵铃铛_package.zip",
        "喵铃铛 · 轻松一刻": "https://darock.top/meowbili/res/skin/喵铃铛 · 轻松一刻/喵铃铛 · 轻松一刻_package.zip",
        "咩栗": "https://darock.top/meowbili/res/skin/咩栗/咩栗_package.zip",
        "明前奶绿": "https://darock.top/meowbili/res/skin/明前奶绿/明前奶绿_package.zip",
        "明日方舟": "https://darock.top/meowbili/res/skin/明日方舟/明日方舟_package.zip",
        "明日方舟-灯下定影": "https://darock.top/meowbili/res/skin/明日方舟-灯下定影/明日方舟-灯下定影_package.zip",
        "冥冥meichan": "https://darock.top/meowbili/res/skin/冥冥meichan/冥冥meichan_package.zip",
        "魔道祖师动画": "https://darock.top/meowbili/res/skin/魔道祖师动画/魔道祖师动画_package.zip",
        "魔法美少女ZC": "https://darock.top/meowbili/res/skin/魔法美少女ZC/魔法美少女ZC_package.zip",
        "魔法学院": "https://darock.top/meowbili/res/skin/魔法学院/魔法学院_package.zip",
        "魔狼咪莉娅": "https://darock.top/meowbili/res/skin/魔狼咪莉娅/魔狼咪莉娅_package.zip",
        "姆明": "https://darock.top/meowbili/res/skin/姆明/姆明_package.zip",
        "牧场少女谬可可": "https://darock.top/meowbili/res/skin/牧场少女谬可可/牧场少女谬可可_package.zip",
        "幕末替身传说": "https://darock.top/meowbili/res/skin/幕末替身传说/幕末替身传说_package.zip",
        "穆小泠": "https://darock.top/meowbili/res/skin/穆小泠/穆小泠_package.zip",
        "雫るる": "https://darock.top/meowbili/res/skin/雫るる/雫るる_package.zip",
        "雫るる制服ver": "https://darock.top/meowbili/res/skin/雫るる制服ver/雫るる制服ver._package.zip",
        "纳豆 nado": "https://darock.top/meowbili/res/skin/纳豆 nado/纳豆 nado_package.zip",
        "乃琳个性装扮2.0": "https://darock.top/meowbili/res/skin/乃琳个性装扮2.0/乃琳个性装扮2.0_package.zip",
        "乃琳Queen": "https://darock.top/meowbili/res/skin/乃琳Queen/乃琳Queen_package.zip",
        "奶油兔": "https://darock.top/meowbili/res/skin/奶油兔/奶油兔_package.zip",
        "奈姬niki": "https://darock.top/meowbili/res/skin/奈姬niki/奈姬niki_package.zip",
        "奈奈莉娅": "https://darock.top/meowbili/res/skin/奈奈莉娅/奈奈莉娅_package.zip",
        "尼奈": "https://darock.top/meowbili/res/skin/尼奈/尼奈_package.zip",
        "暖雪": "https://darock.top/meowbili/res/skin/暖雪/暖雪_package.zip",
        "偶像梦幻祭2": "https://darock.top/meowbili/res/skin/偶像梦幻祭2/偶像梦幻祭2_package.zip",
        "帕里": "https://darock.top/meowbili/res/skin/帕里/帕里_package.zip",
        "配音演员小N": "https://darock.top/meowbili/res/skin/配音演员小N/配音演员小N_package.zip",
        "七海地雷套装": "https://darock.top/meowbili/res/skin/七海地雷套装/七海地雷套装_package.zip",
        "七海演唱会": "https://darock.top/meowbili/res/skin/七海演唱会/七海演唱会_package.zip",
        "七海Nana7mi": "https://darock.top/meowbili/res/skin/七海Nana7mi/七海Nana7mi_package.zip",
        "七濑胡桃": "https://darock.top/meowbili/res/skin/七濑胡桃/七濑胡桃_package.zip",
        "齐司礼": "https://darock.top/meowbili/res/skin/齐司礼/齐司礼_package.zip",
        "千从狩": "https://darock.top/meowbili/res/skin/千从狩/千从狩_package.zip",
        "切茜娅Chelsea": "https://darock.top/meowbili/res/skin/切茜娅Chelsea/切茜娅Chelsea_package.zip",
        "秦淮八艳-小宛": "https://darock.top/meowbili/res/skin/秦淮八艳-小宛/秦淮八艳-小宛_package.zip",
        "轻视频羊咩咩": "https://darock.top/meowbili/res/skin/轻视频羊咩咩/轻视频羊咩咩_package.zip",
        "全职高手": "https://darock.top/meowbili/res/skin/全职高手/全职高手_package.zip",
        "入幕之臣": "https://darock.top/meowbili/res/skin/入幕之臣/入幕之臣_package.zip",
        "三周年恋曲": "https://darock.top/meowbili/res/skin/三周年恋曲/三周年恋曲_package.zip",
        "扇宝": "https://darock.top/meowbili/res/skin/扇宝/扇宝_package.zip",
        "神都夜行录": "https://darock.top/meowbili/res/skin/神都夜行录/神都夜行录_package.zip",
        "神乐七奈": "https://darock.top/meowbili/res/skin/神乐七奈/神乐七奈_package.zip",
        "神楽Mea": "https://darock.top/meowbili/res/skin/神楽Mea/神楽Mea_package.zip",
        "时空之隙": "https://darock.top/meowbili/res/skin/时空之隙/时空之隙_package.zip",
        "拾忆长安·明月几时有": "https://darock.top/meowbili/res/skin/拾忆长安·明月几时有/拾忆长安·明月几时有_package.zip",
        "食草老龙": "https://darock.top/meowbili/res/skin/食草老龙/食草老龙_package.zip",
        "双生幻想": "https://darock.top/meowbili/res/skin/双生幻想/双生幻想_package.zip",
        "双生视界·花嫁": "https://darock.top/meowbili/res/skin/双生视界·花嫁/双生视界·花嫁_package.zip",
        "斯特拉和戴安娜": "https://darock.top/meowbili/res/skin/斯特拉和戴安娜/斯特拉和戴安娜_package.zip",
        "塔克": "https://darock.top/meowbili/res/skin/塔克/塔克_package.zip",
        "泰蕾莎": "https://darock.top/meowbili/res/skin/泰蕾莎/泰蕾莎_package.zip",
        "汤圆酱": "https://darock.top/meowbili/res/skin/汤圆酱/汤圆酱_package.zip",
        "桃桃喵和荔枝喵": "https://darock.top/meowbili/res/skin/桃桃喵和荔枝喵/桃桃喵和荔枝喵_package.zip",
        "天宝伏妖录": "https://darock.top/meowbili/res/skin/天宝伏妖录/天宝伏妖录_package.zip",
        "天官赐福·花怜生日快乐": "https://darock.top/meowbili/res/skin/天官赐福·花怜生日快乐/天官赐福·花怜生日快乐_package.zip",
        "天官赐福动画": "https://darock.top/meowbili/res/skin/天官赐福动画/天官赐福动画_package.zip",
        "天气愈报": "https://darock.top/meowbili/res/skin/天气愈报/天气愈报_package.zip",
        "天涯明月刀从龙": "https://darock.top/meowbili/res/skin/天涯明月刀从龙/天涯明月刀从龙_package.zip",
        "天涯明月刀伙伴": "https://darock.top/meowbili/res/skin/天涯明月刀伙伴/天涯明月刀伙伴_package.zip",
        "天涯明月刀移花": "https://darock.top/meowbili/res/skin/天涯明月刀移花/天涯明月刀移花_package.zip",
        "天曰小雏圣诞": "https://darock.top/meowbili/res/skin/天曰小雏圣诞/天曰小雏圣诞_package.zip",
        "田中姬铃木雏": "https://darock.top/meowbili/res/skin/田中姬铃木雏/田中姬铃木雏_package.zip",
        "甜心nono狗": "https://darock.top/meowbili/res/skin/甜心nono狗/甜心nono狗_package.zip",
        "童话系列·阿拉丁": "https://darock.top/meowbili/res/skin/童话系列·阿拉丁/童话系列·阿拉丁_package.zip",
        "童话系列·胡桃夹子": "https://darock.top/meowbili/res/skin/童话系列·胡桃夹子/童话系列·胡桃夹子_package.zip",
        "童话系列·豌豆公主": "https://darock.top/meowbili/res/skin/童话系列·豌豆公主/童话系列·豌豆公主_package.zip",
        "兔年吉祥東雪蓮": "https://darock.top/meowbili/res/skin/兔年吉祥東雪蓮/兔年吉祥東雪蓮_package.zip",
        "兔崽大长腿": "https://darock.top/meowbili/res/skin/兔崽大长腿/兔崽大长腿_package.zip",
        "兔崽一米八": "https://darock.top/meowbili/res/skin/兔崽一米八/兔崽一米八_package.zip",
        "团团猫": "https://darock.top/meowbili/res/skin/团团猫/团团猫_package.zip",
        "团团奇米莫": "https://darock.top/meowbili/res/skin/团团奇米莫/团团奇米莫_package.zip",
        "万圣街": "https://darock.top/meowbili/res/skin/万圣街/万圣街_package.zip",
        "王牌御史": "https://darock.top/meowbili/res/skin/王牌御史/王牌御史_package.zip",
        "忘川 · 旌旗卷平川": "https://darock.top/meowbili/res/skin/忘川 · 旌旗卷平川/忘川 · 旌旗卷平川_package.zip",
        "未来有你5周年": "https://darock.top/meowbili/res/skin/未来有你5周年/未来有你5周年_package.zip",
        "我开动物园那些年": "https://darock.top/meowbili/res/skin/我开动物园那些年/我开动物园那些年_package.zip",
        "我是大神仙": "https://darock.top/meowbili/res/skin/我是大神仙/我是大神仙_package.zip",
        "呜米": "https://darock.top/meowbili/res/skin/呜米/呜米_package.zip",
        "吾皇巴扎黑": "https://darock.top/meowbili/res/skin/吾皇巴扎黑/吾皇巴扎黑_package.zip",
        "五橙喵 · 玉兔迎春": "https://darock.top/meowbili/res/skin/五橙喵 · 玉兔迎春/五橙喵 · 玉兔迎春_package.zip",
        "武炼巅峰": "https://darock.top/meowbili/res/skin/武炼巅峰/武炼巅峰_package.zip",
        "物述有栖": "https://darock.top/meowbili/res/skin/物述有栖/物述有栖_package.zip",
        "雾山五行": "https://darock.top/meowbili/res/skin/雾山五行/雾山五行_package.zip",
        "希萝Hiiro": "https://darock.top/meowbili/res/skin/希萝Hiiro/希萝Hiiro_package.zip",
        "希月萌奈": "https://darock.top/meowbili/res/skin/希月萌奈/希月萌奈_package.zip",
        "夏鸣星": "https://darock.top/meowbili/res/skin/夏鸣星/夏鸣星_package.zip",
        "夏诺雅": "https://darock.top/meowbili/res/skin/夏诺雅/夏诺雅_package.zip",
        "仙王的日常生活": "https://darock.top/meowbili/res/skin/仙王的日常生活/仙王的日常生活_package.zip",
        "仙王的日常生活第二弹": "https://darock.top/meowbili/res/skin/仙王的日常生活第二弹/仙王的日常生活第二弹_package.zip",
        "向晚大魔王": "https://darock.top/meowbili/res/skin/向晚大魔王/向晚大魔王_package.zip",
        "向晚个性装扮2.0": "https://darock.top/meowbili/res/skin/向晚个性装扮2.0/向晚个性装扮2.0_package.zip",
        "小可学妹": "https://darock.top/meowbili/res/skin/小可学妹/小可学妹_package.zip",
        "小柔Channel": "https://darock.top/meowbili/res/skin/小柔Channel/小柔Channel_package.zip",
        "小希小桃": "https://darock.top/meowbili/res/skin/小希小桃/小希小桃_package.zip",
        "小小约yoo": "https://darock.top/meowbili/res/skin/小小约yoo/小小约yoo_package.zip",
        "小熊奶黄包": "https://darock.top/meowbili/res/skin/小熊奶黄包/小熊奶黄包_package.zip",
        "小丫丫": "https://darock.top/meowbili/res/skin/小丫丫/小丫丫_package.zip",
        "新科娘": "https://darock.top/meowbili/res/skin/新科娘/新科娘_package.zip",
        "新神榜：杨戬": "https://darock.top/meowbili/res/skin/新神榜：杨戬/新神榜：杨戬_package.zip",
        "星宮汐": "https://darock.top/meowbili/res/skin/星宮汐/星宮汐_package.zip",
        "星律动": "https://darock.top/meowbili/res/skin/星律动/星律动_package.zip",
        "星瞳": "https://darock.top/meowbili/res/skin/星瞳/星瞳_package.zip",
        "星汐seki": "https://darock.top/meowbili/res/skin/星汐seki/星汐seki_package.zip",
        "雪狐桑": "https://darock.top/meowbili/res/skin/雪狐桑/雪狐桑_package.zip",
        "雪未来": "https://darock.top/meowbili/res/skin/雪未来/雪未来_package.zip",
        "巡音流歌": "https://darock.top/meowbili/res/skin/巡音流歌/巡音流歌_package.zip",
        "言和7th生日纪念": "https://darock.top/meowbili/res/skin/言和7th生日纪念/言和7th生日纪念_package.zip",
        "异想少女": "https://darock.top/meowbili/res/skin/异想少女/异想少女_package.zip",
        "银河之心": "https://darock.top/meowbili/res/skin/银河之心/银河之心_package.zip",
        "银杏鎏金": "https://darock.top/meowbili/res/skin/银杏鎏金/银杏鎏金_package.zip",
        "永雏塔菲": "https://darock.top/meowbili/res/skin/永雏塔菲/永雏塔菲_package.zip",
        "永雏塔菲·1883": "https://darock.top/meowbili/res/skin/永雏塔菲·1883/永雏塔菲·1883_package.zip",
        "有栖mana": "https://darock.top/meowbili/res/skin/有栖mana/有栖mana_package.zip",
        "柚恩不加糖": "https://darock.top/meowbili/res/skin/柚恩不加糖/柚恩不加糖_package.zip",
        "虞莫MOMO": "https://darock.top/meowbili/res/skin/虞莫MOMO/虞莫MOMO_package.zip",
        "早稻叽": "https://darock.top/meowbili/res/skin/早稻叽/早稻叽_package.zip",
        "早稻叽潮妹": "https://darock.top/meowbili/res/skin/早稻叽潮妹/早稻叽潮妹_package.zip",
        "早见咲": "https://darock.top/meowbili/res/skin/早见咲/早见咲_package.zip",
        "战双帕弥什": "https://darock.top/meowbili/res/skin/战双帕弥什/战双帕弥什_package.zip",
        "战双帕弥什·夏日派对": "https://darock.top/meowbili/res/skin/战双帕弥什·夏日派对/战双帕弥什·夏日派对_package.zip",
        "张京华": "https://darock.top/meowbili/res/skin/张京华/张京华_package.zip",
        "长草颜团子": "https://darock.top/meowbili/res/skin/长草颜团子/长草颜团子_package.zip",
        "眞白花音": "https://darock.top/meowbili/res/skin/眞白花音/眞白花音_package.zip",
        "装扮小姐姐·梦幻冬季": "https://darock.top/meowbili/res/skin/装扮小姐姐·梦幻冬季/装扮小姐姐·梦幻冬季_package.zip",
        "装扮小姐姐·偶像舞台": "https://darock.top/meowbili/res/skin/装扮小姐姐·偶像舞台/装扮小姐姐·偶像舞台_package.zip",
        "装扮小姐姐·秋日午后": "https://darock.top/meowbili/res/skin/装扮小姐姐·秋日午后/装扮小姐姐·秋日午后_package.zip",
        "装扮小姐姐红墙踏雪": "https://darock.top/meowbili/res/skin/装扮小姐姐红墙踏雪/装扮小姐姐红墙踏雪_package.zip",
        "装扮小姐姐梦幻冬季": "https://darock.top/meowbili/res/skin/装扮小姐姐梦幻冬季/装扮小姐姐梦幻冬季_package.zip",
        "adogsama秋": "https://darock.top/meowbili/res/skin/adogsama秋/adogsama秋_package.zip",
        "Akie秋绘": "https://darock.top/meowbili/res/skin/Akie秋绘/Akie秋绘_package.zip",
        "C酱兔兔纪念装扮": "https://darock.top/meowbili/res/skin/C酱兔兔纪念装扮/C酱兔兔纪念装扮_package.zip",
        "C酱です": "https://darock.top/meowbili/res/skin/C酱です/C酱です_package.zip",
        "hanser": "https://darock.top/meowbili/res/skin/hanser/hanser_package.zip",
        "hanser动物套装": "https://darock.top/meowbili/res/skin/hanser动物套装/hanser动物套装_package.zip",
        "Hiiro二周年": "https://darock.top/meowbili/res/skin/Hiiro二周年/Hiiro二周年_package.zip",
        "Ike Eveland": "https://darock.top/meowbili/res/skin/Ike Eveland/Ike Eveland_package.zip",
        "Luca": "https://darock.top/meowbili/res/skin/Luca/Luca_package.zip",
        "M木糖M": "https://darock.top/meowbili/res/skin/M木糖M/M木糖M_package.zip",
        "MEIKO": "https://darock.top/meowbili/res/skin/MEIKO/MEIKO_package.zip",
        "Mysta Rias": "https://darock.top/meowbili/res/skin/Mysta Rias/Mysta Rias_package.zip",
        "NoWorld": "https://darock.top/meowbili/res/skin/NoWorld/NoWorld_package.zip",
        "shoto": "https://darock.top/meowbili/res/skin/shoto/shoto_package.zip",
        "Shu Yamino": "https://darock.top/meowbili/res/skin/Shu Yamino/Shu Yamino_package.zip",
        "Uzi": "https://darock.top/meowbili/res/skin/Uzi/Uzi_package.zip",
        "V我套餐": "https://darock.top/meowbili/res/skin/V我套餐/V我套餐_package.zip"
    ]
    @State var listSearchCache = ""
    var filteredSkins: [String: String] {
        if listSearchCache.isEmpty {
            return skinsPath
        } else {
            return skinsPath.filter { key, value in
                key.localizedCaseInsensitiveContains(listSearchCache)
            }
        }
    }
    
    var body: some View {
        List {
            Section {
                ForEach(filteredSkins.sorted(by: <), id: \.key) { key, value in
                    NavigationLink(destination: {SkinDownloadView(name: key, link: value)}, label: {
                        Text(key)
                    })
                }
            }
        }
        .searchable(text: $listSearchCache, placement: .automatic, prompt: "Home.search")
        .navigationTitle("Skin.add")
    }
}

struct SkinChooserView_Previews: PreviewProvider {
    static var previews: some View {
        SkinChooserView()
    }
}
