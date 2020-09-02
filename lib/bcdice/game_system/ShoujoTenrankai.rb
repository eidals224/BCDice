# -*- coding: utf-8 -*-
# frozen_string_literal: true

module BCDice
  module GameSystem
    class ShoujoTenrankai < Base
      # ゲームシステムの識別子
      ID = 'ShoujoTenrankai'

      # ゲームシステム名
      NAME = '少女展爛会TRPG'

      # ゲームシステム名の読みがな
      SORT_KEY = 'しようしよてんらんかいTRPG'

      # ダイスボットの使い方
      HELP_MESSAGE = <<MESSAGETEXT
出来事表：
・季節
　SPRING  春／SUMMER  夏／AUTUMN  秋／WINTER  冬
・時刻
　MORNING  朝／NOON  昼／AFTERNOON  昼下がり／
　TWILIGHT  黄昏／NIGHT  夜中／MIDNIGHT  夜更け
・棲み処
　NORBLE  貴族趣味／MARCHEN  メルヒェン／COLONIAL  コロニアル／
　SHELF  本棚のある場所／LITTLE  小さな妹の部屋／
　ELDER  素敵なお姉さまの部屋／ATERIEL  アトリエ／OPEN  集まれる場所／
　HAUNTED  SIMPLE  侘び住まい
・いろいろな場所
　LARGE  広い場所／CORRIDOR  廊下／STAIRS  階段／
　COSY  居心地のいい場所／TERRACE  テラス・ベランダ／
　GARRET  屋根裏／KITCHEN  台所／BATH  浴室／REST  化粧室／
　CELLER  地下倉庫／LUMBER  物置／GARDEN  庭園／WASTED  廃園／
　RUIN  廃屋／SHORE  水のほとり
MESSAGETEXT

      setPrefixes(["SPRING", "SUMMER", "AUTUMN", "WINTER", "MORNING", "NOON", "AFTERNOON", "TWILIGHT", "NIGHT", "MIDNIGHT", "NORBLE", "MARCHEN", "COLONIAL", "SHELF", "LITTLE", "ELDER", "ATERIEL", "OPEN", "HAUNTED", "SIMPLE", "LARGE", "CORRIDOR", "STAIRS", "COSY", "TERRACE", "GARRET", "KITCHEN", "BATH", "REST", "CELLER", "LUMBER", "GARDEN", "WASTED", "RUIN", "SHORE"])

      def rollDiceCommand(command)
        info = EVENT_TABLES[command.upcase]

        return nil if info.nil?

        name = info[:name]
        table = info[:table]

        text, number1, number2 = getEventTableResult(table)
        tensionText = getTensionText(number1, number2)

        result = "出来事表：#{name}([#{number1},#{number2}]) ＞ #{text}#{tensionText}"

        return result
      end

      def getTensionText(number1, number2)
        diff = (number1 - number2).abs
        return "" if diff == 0

        return "（テンション＋#{diff}）"
      end

      def getEventTableResult(table)
        number1, = roll(1, 6)
        number2, = roll(1, 6)

        isOdd = number1.even?

        index = number2 - 1
        index += 6 if isOdd

        text = getTableValue(table[index])

        return nil if text.nil?

        return text, number1, number2
      end

      EVENT_TABLES =
        {
          "SPRING" => {
            :name => "春",
            :table => %w{
              【奇・1】【花びら（純従）】(グッズ）が舞い込んで来ます。蝶だったかもしれません。
              【奇・2】【初めて見る花（純察）】（グッズ）が咲いています。
              【奇・3】春の香りがふと、強くただよいます。（ロマンティック＋1）
              【奇・4】春の嵐が窓を打ち付けています。（ルナティック＋1）
              【奇・5】鳥のさえずりが聞こえてきます。
              【奇・6】軽く汗ばむほどの陽気です。
              【偶・1】春霞がぼんやりと景色を包み込んでいます。（カタストロフ＋1）
              【偶・2】花が散りました。
              【偶・3】しんしんと花冷えがします。
              【偶・4】春の雨が銀の紗をかけた様にさらさらと降っています。
              【偶・5】開け放した窓のカーテンを春風がやさしく揺らしています。（ハートフル＋1）
              【偶・6】気持ちよさそうにしている生き物（【コンパニオン】から任意）がいます。
            },
          },
          "SUMMER" => {
            :name => "夏",
            :table => %w{
              【奇・1】建物の中に蔓草が入り込んでいます。（カタストロフ＋1）
              【奇・2】大きな虹がかかっています。（ハートフル＋1）
              【奇・3】稲妻が空を裂きます。
              【奇・4】むくむくの入道雲が遠くに見えます。
              【奇・5】虫の声が辺りを満たしています。
              【奇・6】激しい嵐が屋敷を揺すっています。（ロマンティック＋1）
              【偶・1】雲の影がゆっくりと庭を横切っていきます。
              【偶・2】【夏の花（支純）】（グッズ）が咲き誇っています。
              【偶・3】風もなく、ひどく蒸し暑い日です。
              【偶・4】虫が一生懸命動き回っています。
              【偶・5】物陰からふと、涼しい風が吹いてきました。
              【偶・6】焼け付く日差しの中、黒々とした影が落ちています。（ルナティック＋1）
            },
          },
          "AUTUMN" => {
            :name => "秋",
            :table => %w{
              【奇・1】たわわに実った果物があります。
              【奇・2】鳥の声が鋭く響き渡ります。（カタストロフ＋1）
              【奇・3】芯の冷えた木枯らしが通り過ぎていきます。
              【奇・4】鬱々と長い秋の雨が降り続いています。
              【奇・5】空が不思議に紫がかって見えます。
              【奇・6】木々が鮮やかな色に染まっています。
              【偶・1】【秋の花（従純）】（グッズ）がひと群れになって咲いています。
              【偶・2】見事な夕焼けが辺り一面を染め上げます。（ロマンティック＋1）
              【偶・3】ぱたりと物音がやみ、しんと静まりかえります。（ルナティック＋1）
              【偶・4】吸い込まれるような青い空が高く広がっています。（ハートフル＋1）
              【偶・5】【初めて見る木の実（純察）】（グッズ）が転がっています。
              【偶・6】【枯葉（従純）】（グッズ）がさくさく、さらさらと音を立てます。
            },
          },
          "WINTER" => {
            :name => "冬",
            :table => %w{
              【奇・1】太陽（月）に暈がかかっています。
              【奇・2】風花が舞っています。
              【奇・3】雪が積もっています。
              【奇・4】恐ろしい勢いの吹雪が屋敷を埋めていきます。（ルナティック＋1）
              【奇・5】おだやかな小春日和です。（ハートフル＋1）
              【奇・6】霙がぽしゃぽしゃと降っています。
              【偶・1】冬の空と空気が、硝子のように張り詰めています。
              【偶・2】薪を焚く暖かな匂いがただよっています。（ロマンティック＋1）
              【偶・3】窓硝子が曇っています。
              【偶・4】【冬の花（従支）】（グッズ）が凛と咲いています。
              【偶・5】氷柱（霜柱、氷）が鋭い光を投げかけています。
              【偶・6】骸骨のようにそびえる冬の木の枝に、そこだけ青々とヤドリギが茂っています。（カタストロフ＋1）
            },
          },
          "MORNING" => {
            :name => "朝",
            :table => %w{
              【奇・1】起きたら涙を流していました。
              【奇・2】眠ったのとは別の場所で目覚めました。（ルナティック＋1）
              【奇・3】寝相が悪かったのか、痛い思いをして目覚めました。（ハートフル＋1）
              【奇・4】朝露が輝いています。
              【奇・5】見事な朝焼けになりました。
              【奇・6】まだかなり眠気が残っています。（ロマンティック＋1）
              【偶・1】むやみに爽快な気分です。
              【偶・2】なんだか体がこわばっていて、くたびれた感じがします。（カタストロフ＋1）
              【偶・3】ひどく喉が渇いています。
              【偶・4】白い月がまだ空に残っています。
              【偶・5】最後の星が朝の光に飲み込まれる瞬間を見ました。
              【偶・6】鳥の声が響いています。
            },
          },
          "NOON" => {
            :name => "昼",
            :table => %w{
              【奇・1】なんだかじっとしていられません。
              【奇・2】奇妙なだるさを感じています。
              【奇・3】ひどくお腹がすいています。
              【奇・4】急に厚い雲が日差しを遮りました。
              【奇・5】薄い雲の向こうに、オパールの円盤のような太陽があります。（ロマンティック＋1）
              【奇・6】なんだか無性にいらいらします。
              【偶・1】この世界に自分ひとりだけが取り残されたような気分に襲われました。（ルナティック＋1）
              【偶・2】変に草木の緑が目に付きます。（カタストロフ＋1）
              【偶・3】なんだか急に、寒気を感じました。
              【偶・4】さっぱりやる気が起きません。
              【偶・5】みんなで賑やかに遊んでいる声が聞こえてきます。
              【偶・6】目に触れるあらゆるものが輝いて見えます。（ハートフル＋1）
            },
          },
          "AFTERNOON" => {
            :name => "昼下がり",
            :table => %w{
              【奇・1】快い眠気に襲われています。
              【奇・2】まだ食べ足りない感じがします。
              【奇・3】急に天気雨が降り出しました。（ロマンティック＋1）
              【奇・4】雲の隙間から輝く光の矢が降り注いでいます。
              【奇・5】どこかから甘い匂いが漂ってきます。
              【奇・6】なんとはなしに物憂く、昼の日差しが憂鬱です。（ルナティック＋1）
              【偶・1】元気が有り余っている感じがします。
              【偶・2】今まで吹いていた風がぴたりと止まりました。
              【偶・3】お日様の匂いがします。（ハートフル＋1）
              【偶・4】一陣の風が吹きすぎてゆきました。
              【偶・5】何か重いものが落ちた音がしました。（カタストロフ＋1）
              【偶・6】視線を感じました。
            },
          },
          "TWILIGHT" => {
            :name => "黄昏",
            :table => %w{
              【奇・1】人影を見たような気がします。（ルナティック＋1）
              【奇・2】やけに色の薄い夕暮れで、なにもかもが灰色に見えます。
              【奇・3】鮮やかな夕焼けになりました。
              【奇・4】ふと、自分の影が気になって見つめてしまいました。（カタストロフ＋1）
              【奇・5】窓硝子かなにかが、夕陽を照り返して輝いています。
              【奇・6】葉ずれの音が、やけに大きくざわめいています。
              【偶・1】一番星を見つけました。（ハートフル＋1）
              【偶・2】物陰に夜の気配がわだかまっています。
              【偶・3】蝙蝠の影らしきものが音もなく舞っています。
              【偶・4】木の枝にびっしりと、鳥たちが身を寄せ合っています。
              【偶・5】むやみに月が大きく見えます。
              【偶・6】ものの境い目があいまいになり、全てが溶けて混ざり合ってしまいそうです。（ロマンティック＋1）
            },
          },
          "NIGHT" => {
            :name => "夜中",
            :table => %w{
              【奇・1】なかなか眠くなれません。
              【奇・2】ひどく眠くて、今にも寝てしまいそうです。（ハートフル＋1）
              【奇・3】赤い月が空に低くかかっています。
              【奇・4】月の青い光が降り注いでいます。（ロマンティック＋1）
              【奇・5】特に星の綺麗な夜です。
              【奇・6】灯していた明かりがざわめくように揺らいでいます。（ルナティック＋1）
              【偶・1】月を隠しながら、薄い雲が通り過ぎていきます。
              【偶・2】星一つ見えない闇夜です。
              【偶・3】どこからか談笑の声が聞こえた気がします。
              【偶・4】流れ星が流れました。
              【偶・5】コトリと硬い音がしました。（カタストロフ＋1）
              【偶・6】どこからかとても美味しそうな匂いがただよってきます。
            },
          },
          "MIDNIGHT" => {
            :name => "夜更け",
            :table => %w{
              【奇・1】時計の音がやけに大きく響いています。（カタストロフ＋1）
              【奇・2】夢から醒めましたが、どんな夢か覚えていません。
              【奇・3】足音を聞いた気がします。
              【奇・4】ぼそぼそと話す声を聞いた気がします。（ロマンティック＋1）
              【奇・5】ひどく喉が渇いています。
              【奇・6】ひどくお腹がすいています。（ハートフル＋1）
              【偶・1】寝苦しさを感じています。
              【偶・2】眠気が全く訪れません。
              【偶・3】急に月の光を浴びました。（ルナティック＋1）
              【偶・4】見慣れたものの影が全く別のものに見えました。
              【偶・5】闇がやけに深く感じられます。
              【偶・6】違和感のある香りを感じました。
            },
          },
          "NORBLE" => {
            :name => "貴族趣味",
            :table => %w{
              【奇・1】毛足の長い絨毯に足音を吸い取られてしまいました。
              【奇・2】見とれるほど豪奢な調度があります。
              【奇・3】気後れするほど豪奢な調度があります。
              【奇・4】誰かがどこかから窺っているような気がしました。（ルナティック＋1）
              【奇・5】曇り一つ無いところに思わず手をついてしまいました。
              【奇・6】窮屈なくらい、気品にあふれています。
              【偶・1】仰々しすぎて、ちょっと嫌味に思えなくもありません。
              【偶・2】豪華でよそ行きな雰囲気の中に、生活の気配がちょっとだけ、混ざりこんでいます。（ハートフル＋1）
              【偶・3】【素敵なオブジェ（支押）】（グッズ）が飾られています。
              【偶・4】わけもなく空しさが募りました。（ロマンティック＋1）
              【偶・5】飾り縁のような窓に切り取られた外の景色が、ひどく遠く見えます。（カタストロフ＋1）
              【偶・6】いつか聞いたお話の、お姫様を思い出しました。
            },
          },
          "MARCHEN" => {
            :name => "メルヒェン",
            :table => %w{
              【奇・1】懐かしさを覚える木の香りがします。（カタストロフ＋1）
              【奇・2】周りにあるのはなんの変哲もないものばかりです。
              【奇・3】部屋のどこかがきしみました。
              【奇・4】小さな音がします。
              【奇・5】生活のぬくもりが、確かに刻まれています。（ハートフル＋1）
              【奇・6】どこかで読んだお話の記憶と、目の前の風景が重なりました。
              【偶・1】もったりとした野暮ったさにあふれています。
              【偶・2】よく乾いたハーブと干草の香りがわずかに漂っています。（ロマンティック＋1）
              【偶・3】飾り気がなくとも使いやすそうな調度が、存在感を放っています。
              【偶・4】おいしそうな匂いが一度だけ、鼻をくすぐりました。
              【偶・5】歩くと、床がことことと足音をたてます。
              【偶・6】なにかがひとつ、足りない気がします。（ルナティック＋1）
            },
          },
          "COLONIAL" => {
            :name => "コロニアル",
            :table => %w{
              【奇・1】重厚な調度が征服欲を刺激します。
              【奇・2】床に傷を見つけてしまいました。
              【奇・3】重厚な調度に頼もしさを感じます。
              【奇・4】堅固すぎて、逆にいわく言いがたい不吉さを感じます。（カタストロフ＋1）
              【奇・5】壁になにかが架けられていた跡が残っています。
              【奇・6】ぐるっと回る椅子がなんだかすごく魅力的です。（ハートフル＋1）
              【偶・1】しっかりした錠がだらしなく開いていました。
              【偶・2】威厳を演出しすぎていて、かえって下品かもしれません。
              【偶・3】外からの光が不思議な静けさをもたらしました。（ロマンティック＋1）
              【偶・4】靴音が立ちました。（ルナティック＋1）
              【偶・5】革の匂いがかすかに漂っています。
              【偶・6】そこの頑丈そうな机は、なんだか座り心地がよさそうです。
            },
          },
          "SHELF" => {
            :name => "本棚のある場所",
            :table => %w{
              【奇・1】明らかに踏み台に使ったらしく、【大判の本（打押）】（グッズ）が積み上げてあります。（ハートフル＋1）
              【奇・2】古びた紙の匂いが辺りを満たしています。
              【奇・3】【薄い本（打察）】（グッズ）が一冊、ぱたりと音を立てて倒れました。
              【奇・4】なぜか本棚の一段がまるごと、からっぽになっています。
              【奇・5】【気になる本（純押）】（グッズ）があるのですが、本棚の天辺に乗っている上非常に重そうです。（ルナティック＋1）
              【奇・6】【破り取られた絵本の頁（支従）】（グッズ）が一葉、無残な破れ目をさらしています。
              【偶・1】【広げっぱなしの本（支押）】（グッズ）にひどい落書きがされています。
              【偶・2】全集の一冊が欠けていました。（ロマンティック＋1）
              【偶・3】棚にきちんと本が納められておらず、バラバラで乱雑に押し込まれています。
              【偶・4】本の隙間からなにかの気配を感じた気がします。
              【偶・5】インクが乾いて干からびた、【インク瓶（従察）】（グッズ）と【万年筆（打押）】（グッズ）がテーブルに乗っています。（カタストロフ＋1）
              【偶・6】【押し花（純察）】（グッズ）が一輪、落ちていました。
            },
          },
          "LITTLE" => {
            :name => "小さな妹の部屋",
            :table => %w{
              【奇・1】つまづいてしまった【玩具（従純）】（グッズ）が、ころりと可愛らしい音を立てました。
              【奇・2】シーツ（テーブルクロス）がくちゃくちゃです。
              【奇・3】とんでもないところに食べこぼしの跡を見つけました。
              【奇・4】過ぎたおいたの跡が、部屋に華々しく残っています。
              【奇・5】こっそり隠したつもりのおやつが山を成しています。
              【奇・6】脱ぎ散らかされた服が所在なさげにふて寝しています。
              【偶・1】やさしい子守歌を思い出しました。（ハートフル＋1）
              【偶・2】見る物全てがいちいち勘に障ります。（ルナティック＋1）
              【偶・3】かわいらしい【食器（純押）】（グッズ）が置いてありました。（ロマンティック＋1）
              【偶・4】わけもなく、涙がこぼれてきます。
              【偶・5】壊してしまった【がらくた（純従）】（グッズ）が、こっそり隠してありました。
              【偶・6】ふと、この棲み処の主は、どんな素敵な人になるだろう、と思いました。（カタストロフ＋1）
            },
          },
          "ELDER" => {
            :name => "素敵なお姉さまの部屋",
            :table => %w{
              【奇・1】床に映った影が、ゆっくりと動いていきます。（カタストロフ＋1）
              【奇・2】きゅっ、と音が立ちました。
              【奇・3】自然に背筋が伸びてしまいます。
              【奇・4】ふとほのかに甘い、柔らかな香りが漂いました。（ロマンティック＋1）
              【奇・5】ほのかに確かににじみ出る魅力に、ちょっと嫉妬してしまいます。
              【奇・6】素敵な【ベルト（支従）】がありました。（ルナティック＋1）
              【偶・1】お茶が冷めていました。
              【偶・2】ちょっとくたびれた【可愛らしい小物（純察）】（グッズ）が、物陰にこっそり置いてありました。
              【偶・3】衣擦れの音がしました。
              【偶・4】ダイビングにもってこいのベッドがあります。（ハートフル＋1）
              【偶・5】気後れしそうなほど完成度の高い、【手作り品（支押）】（グッズ）が無造作に置いてあります。
              【偶・6】【部屋着（従純）】（コーディネート）がハンガーにかけられています。
            },
          },
          "ATERIEL" => {
            :name => "アトリエ",
            :table => %w{
              【奇・1】棚に【道具（打支）】（グッズ）がきちんと整頓されています。
              【奇・2】【メモや図面（支押）】（グッズ）が書き散らされています。
              【奇・3】【壊れた道具（従察）】が積み上げられています。
              【奇・4】【作りかけらしい作品（純押）】（グッズ）が無造作に放置されています。
              【奇・5】めちゃくちゃに壊された作品の残骸が散乱しています。（ルナティック＋1）
              【奇・6】【見慣れない道具（打純）】（グッズ）が大切そうに置いてあります。
              【偶・1】食べかけの食事がそのままになっています。
              【偶・2】【ジャケット（打純）】（グッズ）が脱ぎ捨てられています。（ロマンティック＋1）
              【偶・3】積み上げられていたものが、派手な音を立てて崩れました。
              【偶・4】何気なく触れたところに、インク（や絵の具等）がべっとりついていました。
              【偶・5】引き出しが一つ、丸々抜き去られています。（カタストロフ＋1）
              【偶・6】「作業中、入るな！」と書かれた【紐付きのプレート（支押）】（グッズ）が手に取りやすい位置に置いてあります。（ハートフル＋1）
            },
          },
          "OPEN" => {
            :name => "集まれる場所",
            :table => %w{
              【奇・1】かつての楽しい出来事の余韻が、伝わってくるような気がします。（ハートフル＋1）
              【奇・2】テーブルクロスのしみが、涙の跡のように思えました。（ロマンティック＋1）
              【奇・3】鉄錆くさい臭いがかすかに鼻を突きます。
              【奇・4】ぜんぜん片付けられておらず、散らかり放題です。
              【奇・5】なぜか１枚だけ、【割れた皿（支押）】（グッズ）がそっくりそのまま床に放置されています。
              【奇・6】誰かが貼った「RESERVED（予約済み）」の【張り紙（支打）】（グッズ）が、堂々と居座っています。
              【偶・1】整理されすぎていて、人のぬくもりが感じられません。
              【偶・2】部屋の片隅に、布にくるまれた何か大きなモノが置いてあります。
              【偶・3】完璧な作法で【食器（従察）】（グッズ）が並べられていますが、誰も、また何も、出てくる気配はありません。
              【偶・4】壁の向こうを、大勢が賑やかに通り過ぎてゆく気配がします。（カタストロフ＋1）
              【偶・5】直前に行われたパーティで余ったらしいお菓子が、「ご自由に」の書置きとともに残されています。
              【偶・6】壁に【ナイフ（支従）】（グッズ）が突き立っています。（ルナティック＋1）
            },
          },
          "HAUNTED" => {
            :name => "精神的瑕疵物件",
            :table => %w{
              【奇・1】赤黒い染みを見つけてしまいました。
              【奇・2】叩くような、はじけるような音が断続的に聞こえるような気がします。
              【奇・3】悪寒がします。
              【奇・4】ふと手を触れた場所が、不自然に冷たく湿って感じました。
              【奇・5】何人か余分に、人の気配を感じるような気がしてしかたありません。
              【奇・6】ふっ、と辺りがいくらか暗くなって、また元に戻りました。
              【偶・1】細く開いていた隙間が閉じる瞬間を見てしまいました。（カタストロフ＋1）
              【偶・2】何かが足をするりと撫でました。（ルナティック＋1）
              【偶・3】耳元でつぶやきが聞こえました。多分。（ロマンティック＋1）
              【偶・4】出た……と思ったらものの影でした。（ハートフル＋1）
              【偶・5】空気がゆっくりと渦をまいて、肌を撫でています。
              【偶・6】うっすらと手形がついています。
            },
          },
          "SIMPLE" => {
            :name => "侘び住まい",
            :table => %w{
              【奇・1】若干、風通しがよすぎるようです。
              【奇・2】いろいろすっきりしています。
              【奇・3】壁のひびを見つけました。
              【奇・4】隅っこに穴が開いています。
              【奇・5】思わず深呼吸してしまいました。
              【奇・6】壁と柱の隙間から、外の光が細く漏れてきます。
              【偶・1】ふと気づくと、掃除したらよさそうな場所を探している自分がいます。（ハートフル＋1）
              【偶・2】ぱらっと何かこぼれた音がしました。
              【偶・3】軋んだ音がした瞬間、棲み処全体が傾いでいくような錯覚に襲われました。（ルナティック＋1）
              【偶・4】使い込まれた艶が用の美を控えめに放っています。（ロマンティック＋1）
              【偶・5】二度と落ちなさそうな汚れがこびりついています。
              【偶・6】このまま誰かの思い出の中に閉じこめられてしまいそうな気分になりました。（カタストロフ＋1）
            },
          },
          "LARGE" => {
            :name => "広い場所",
            :table => %w{
              【奇・1】がらんとした広さに、胸を衝かれました。
              【奇・2】誰かの残り香が、ほのかに甘く漂っています。（ロマンティック＋1）
              【奇・3】扉がふいに開きましたが、誰も入ってきません。（カタストロフ＋1）
              【奇・4】自分の足音がやけに大きく響き渡りました。
              【奇・5】ふともらした独り言が、広い部屋の中にぽつりと消えていきました。（ルナティック＋1）
              【奇・6】壁に素敵な絵が飾られています。
              【偶・1】部屋の片隅に、壊れたオブジェが打ち捨てられています。
              【偶・2】掃除道具が出しっぱなしです。（ハートフル＋1）
              【偶・3】床に派手な傷がついています。
              【偶・4】鉢植えが枯れています。
              【偶・5】不意に空気が揺れ動くのを感じました。
              【偶・6】天井がきしんだような気がします。
            },
          },
          "CORRIDOR" => {
            :name => "廊下",
            :table => %w{
              【奇・1】窓が開け放たれています。（カタストロフ＋1）
              【奇・2】パタン、と扉の閉まる音がしました。
              【奇・3】人影が、向こうの曲がり角に姿を消したような気がします。（ロマンティック＋1）
              【奇・4】壁のランプが落ちて割れています。
              【奇・5】天井の染みにふと目を奪われました。
              【奇・6】壁に掛けられた絵がわずかに傾いています。
              【偶・1】愛を誓うささやかな落書きがありました。（ハートフル＋1）
              【偶・2】壁紙が破れ、小さな影を作っています。
              【偶・3】絨毯が擦り切れています。
              【偶・4】自分の立てた音がやけに大きく耳に残りました。（ルナティック＋1）
              【偶・5】【誰かの落し物（打察）】（グッズ）が落ちています。
              【偶・6】空っぽの飾り棚が置かれています。
            },
          },
          "STAIRS" => {
            :name => "階段",
            :table => %w{
              【奇・1】踊り場に大きな姿見が掛けられています。（カタストロフ＋1）
              【奇・2】手すりが使い込まれたつややかな輝きを放っています。（ハートフル＋1）
              【奇・3】手すりの一部が壊れています。
              【奇・4】重いものをぶつけた痕が残っています。
              【奇・5】【片っぽだけの靴（従純）】（グッズ）残されていました。（ロマンティック＋1）
              【奇・6】段が嫌な音を立てて大きくきしみました。
              【偶・1】隅に埃がたまっています。
              【偶・2】なぜか、壊れた家具が階段の途中に積み上げてあります。
              【偶・3】上の階から誰かの足音が聞こえてきます。
              【偶・4】下の階からぼそぼそと声が聞こえたような気がします。（ルナティック＋1）
              【偶・5】差し込む日差しが段に複雑な陰影を作っています。
              【偶・6】一段踏み外しました。
            },
          },
          "COSY" => {
            :name => "居心地のいい場所",
            :table => %w{
              【奇・1】一瞬、物音が全て途絶えました。
              【奇・2】壁の模様が動いたような気がします。
              【奇・3】蔦が少しばかり這いこんでいました。（カタストロフ＋1）
              【奇・4】妙な息苦しさを覚えました。
              【奇・5】部屋のどこかがきしみました。
              【奇・6】小さな明かりがあかあかと揺れています。（ハートフル＋1）
              【偶・1】梁の向こうになにかの気配を感じました。
              【偶・2】窓が急に音を立てました。
              【偶・3】敷物のすみがわずかに盛り上がっています。（ルナティック＋1）
              【偶・4】何の前触れもなく、椅子が倒れました。
              【偶・5】わけもなく寂しさが募ります。（ロマンティック＋1）
              【偶・6】軽い眠気に教われました。
            },
          },
          "TERRACE" => {
            :name => "テラス・ベランダ",
            :table => %w{
              【奇・1】木の枝や木の葉が積もっています。
              【奇・2】【小鳥（純察）】（コンパニオン）がてすりでさえずっています。
              【奇・3】誰かの洗濯物が風に翻っています。（ハートフル＋1）
              【奇・4】てすりが壊れています。
              【奇・5】バタン、と扉（窓）の閉ざされる音がしました。
              【奇・6】テラスから覗く部屋の中が、暗く影に沈んでいます。（カタストロフ＋1）
              【偶・1】下の方から、楽しげなさざめきが聞こえた気がします。
              【偶・2】強い風が通り過ぎました。
              【偶・3】なにかの影が上を通り過ぎました。（ルナティック＋1）
              【偶・4】雨ざらしのテーブルと椅子が一揃いあります。
              【偶・5】雨樋から雫がしたたっています。（ロマンティック＋1）
              【偶・6】軒（窓、破風）の飾りが壊れ、【かけら（従察）】（グッズ）が落ちています。
            },
          },
          "GARRET" => {
            :name => "屋根裏",
            :table => %w{
              【奇・1】隙間風が【空っぽの小箱（打支）】（グッズ）を揺らして床に落としました。
              【奇・2】小さな窓から差し込む日差しの中に、埃が舞っています。（ロマンティック＋1）
              【奇・3】【古ぼけてほつれた衣装（従純）】（コーディネート）が見つかりました。（ハートフル＋1）
              【奇・4】クローゼットの扉が、ほんのわずか開いています。
              【奇・5】【片手（片足）がもげたぬいぐるみ（純支）】（グッズ）が見つかりました。
              【奇・6】【ガラスの破片（支純）】（グッズ）で小さな傷を作ってしまいました。
              【偶・1】鍵穴のない、頑丈で重たい大きな箱があります。
              【偶・2】埃だらけのクッションが積まれています。
              【偶・3】がらくたにかぶせられた埃避けの布がかすかに揺れています。（カタストロフ＋1）
              【偶・4】蜘蛛の巣がかかっています。
              【偶・5】【蛾の死骸（従察）】（グッズ）を見つけました。
              【偶・6】ねずみかなにかが壁の中を駆け抜けていく小さな物音がしました。（ルナティック＋1）
            },
          },
          "KITCHEN" => {
            :name => "台所",
            :table => %w{
              【奇・1】【よく洗われた食器（従純）】（グッズ）が輝きを放っています。（ハートフル＋1）
              【奇・2】【銀器（支打）】（グッズ）がくすんでしまっています。
              【奇・3】水の樽がほとんど空になっていました。
              【奇・4】【汚れた食器（従支）】（グッズ）が流しを占領しています。
              【奇・5】【生ごみ（従支）】（グッズ）が異臭を放っています。（ルナティック＋1）
              【奇・6】血痕が点々と散らばっています。
              【偶・1】【ジャムや砂糖漬けの瓶（純打）】が宝石の列のように並んでいます。
              【偶・2】鍋がコトコトと幸せそうな音を立てていますが、人が見当たりません。（カタストロフ＋1）
              【偶・3】ついさっきまで人が立ち働いていたらしく、ぬくもりがまだ残っています。（ロマンティック＋1）
              【偶・4】蟻の列が一生懸命おつかいに励んでいます。
              【偶・5】隅の方に【大きなナメクジ（純従）】（コンパニオン）がへばりついています。
              【偶・6】分捕り品に齧り付いている【ねずみ（支従）】（コンパニオン）と目が合ってしまいました。
            },
          },
          "BATH" => {
            :name => "浴室",
            :table => %w{
              【奇・1】盛大に滑って転んでしまいました。（ハートフル＋1）
              【奇・2】下水の饐えた匂いがします。
              【奇・3】天井から雫がやけにしたたっています。
              【奇・4】【お風呂用のおもちゃ（純従）】（グッズ）がさみしげに転がっています。（カタストロフ＋1）
              【奇・5】空のバスタブの排水溝に、湿った長い髪の毛が絡んでいます。
              【奇・6】バスタブに泡だらけのお湯が残っています。
              【偶・1】シャワーが外れたまま床を這っています。（ロマンティック＋1）
              【偶・2】床のタイルにひどいひびが入っています。
              【偶・3】ここしばらく、誰も使った形跡がなく空気が乾いてすらいます。
              【偶・4】【誰かの服（従打）】（コーディネート）がバスタブに投げ込まれ、ぐちゃぐちゃになっています。
              【偶・5】不健康にじめついていて、どこもかしこもカビだらけです。
              【偶・6】なにかが這い回ったような跡がありました。（ルナティック＋1）
            },
          },
          "REST" => {
            :name => "化粧室",
            :table => %w{
              【奇・1】鏡の中の自分が別の顔をしていたような気がします。（カタストロフ＋1）
              【奇・2】鬱陶しく虫が飛び回っています。
              【奇・3】蛇口から水がしたたっています。
              【奇・4】不快な匂いが強いようです。
              【奇・5】【清潔なタオル（純従）】（グッズ）が整えられています。（ハートフル＋1）
              【奇・6】壊れているらしい便器にガラクタがつっこんであります。
              【偶・1】閉ざされた個室の中で、ぼそぼそと声がしたような気がします。（ロマンティック＋1）
              【偶・2】誰かの【ささやかなアクセサリ（支打）】（グッズ）が置き忘れられています。
              【偶・3】【清掃用具（打従）】（グッズ）が放り出されています。
              【偶・4】扉の向こうで人の気配が立ち去りました。（ルナティック＋1）
              【偶・5】清掃用具のクローゼットの扉の下から、水が漏れ広がっています。
              【偶・6】換気窓の近くで空気がゆるく蠢いています。
            },
          },
          "CELLER" => {
            :name => "地下倉庫",
            :table => %w{
              【奇・1】なにかべとべとしたものに触ってしまいました。
              【奇・2】ひんやりとした空気がまとわりついてきます。
              【奇・3】かすかに悪臭が漂ってきます。
              【奇・4】作業台のようなものの上を、赤黒い染みが覆っています。（ルナティック＋1）
              【奇・5】【ムカデ（純支）】（コンパニオン）がじっとしています。
              【奇・6】【重たそうな麻袋（従支）】（コンテナ）が積み上げられています。
              【偶・1】灯されたランプがチリチリと小さな音を立てました。（カタストロフ＋1）
              【偶・2】積まれた石炭に、【スコップ（支押）】（グッズ）が突っ込まれています。
              【偶・3】食べ物を収めた棚があります。（ハートフル＋1）
              【偶・4】無愛想でそっけない造りの椅子が転がっています。
              【偶・5】床の一部が磨り減り、妙に滑らかになっています。
              【偶・6】梁の上から、視線を感じました。（ルナティック＋1）
            },
          },
          "LUMBER" => {
            :name => "物置",
            :table => %w{
              【奇・1】壁の隙間の向こうを何かの影が通り過ぎました。
              【奇・2】【気になる箱（従支）】（コンテナ）があるのですが、がらくたの山に埋もれて手が出せません。（ロマンティック＋1）
              【奇・3】積まれていたがらくたの一つが、目を逸らした隙に消えたような気がします。（ルナティック＋1）
              【奇・4】壊れた家具の下で、【人形（純支）】（グッズ）が潰されています。
              【奇・5】【虫の死骸（純打）】（グッズ）を見つけました。
              【奇・6】【安っぽいヒカリモノ（純打）】（グッズ）がたくさん詰まったバスケットがあります。（ハートフル＋1）
              【偶・1】【庭いじりの道具（従支）】（グッズ）が無造作に立てかけてあります。
              【偶・2】黴くさい臭いで息が詰まりそうです。
              【偶・3】どこかでがらくたが崩れ、大きな音を立てました。
              【偶・4】床の一部が抜けています。
              【偶・5】片隅の暗がりから視線を感じました。
              【偶・6】なんの前触れもなく、物置全体が小さくきしみました。（カタストロフ＋1）
            },
          },
          "GARDEN" => {
            :name => "庭園",
            :table => %w{
              【奇・1】【季節の花（純支）】（グッズ）が美しく咲き乱れています。（ハートフル＋1）
              【奇・2】せっかくの花壇が、無残に踏みにじられなぎ倒されています。
              【奇・3】【庭いじりの道具（従押）】（グッズ）が放り出してあります。
              【奇・4】物陰から小動物のような影が逃げ去っていきました。
              【奇・5】手入れが悪く、栽培物が雑草に押され気味です。
              【奇・6】枯れてしまった苗が、そのまま放置されています。（カタストロフ＋1）
              【偶・1】【虫（純従）】（コンパニオン）が悠々と這っています。
              【偶・2】ふいの強い風に、草木がざわりと不安な音を立てました。
              【偶・3】どこからともなく、鮮烈な花の香りが漂ってきます。（ロマンティック＋1）
              【偶・4】藤棚の作る蔭が、素敵に居心地よく見えます。
              【偶・5】植え込みがよく育っているのですが、茂りすぎてなんだか怖いようです。（ルナティック＋1）
              【偶・6】【花の名前を書いた札（打純）】（グッズ）が打ち棄てられています。
            },
          },
          "WASTED" => {
            :name => "廃園",
            :table => %w{
              【奇・1】伸び放題の草が風にざわざわとざわめいています。
              【奇・2】背丈よりも高い、見上げるような草むらが生い茂っています。
              【奇・3】【清楚な野の花（純従）】（グッズ）が端然と咲いています。（ハートフル＋1）
              【奇・4】草むらの中をなにかがざわざわと通り過ぎていきます。
              【奇・5】花壇の残骸に躓きました。
              【奇・6】アーチの残骸に絡む枯れた蔓草の上から、元気な蔓草が巻きついています。（ロマンティック＋1）
              【偶・1】枯れた噴水があります。
              【偶・2】でこぼこに割れた敷石の隙間から、雑草が茂っています。
              【偶・3】全く草の生えていない一角があります。（カタストロフ＋1）
              【偶・4】綺麗な彫刻の、半分くらいに割れた【かけら（従察）】（グッズ）があります。
              【偶・5】大きな虫瘤があります。
              【偶・6】虫が素早く、石の下に這いこんでいきました。（ルナティック＋1）
            },
          },
          "RUIN" => {
            :name => "廃屋",
            :table => %w{
              【奇・1】天井や床が派手に崩壊していて、踏み込めない一角があります。
              【奇・2】何か金属の部品が真っ二つになっていました。
              【奇・3】硝子の破片が散乱しています。
              【奇・4】ひどい隙間風が這いこんできています。
              【奇・5】絡み付いた茨に可憐な花が付いていました。（ロマンティック＋1）
              【奇・6】壊れてひっくり返った家具が黙然としています。
              【偶・1】【汚れた人形（従察）】（グッズ）が転がっています。
              【偶・2】あたり一面を、茨（蔦）がびっしり覆っています。
              【偶・3】紐状のものが垂れ下がっています。（ルナティック＋1）
              【偶・4】文字が乱れていて【読めないノート（打押）】（グッズ）が置き去られていました。（カタストロフ＋1）
              【偶・5】壁が崩れていますが、まだ穴にはなっていません。
              【偶・6】虫がせっせとなにかを運んでいます。（ハートフル＋1）
            },
          },
          "SHORE" => {
            :name => "水のほとり",
            :table => %w{
              【奇・1】水面に波紋が広がっていきます。
              【奇・2】視界の外で水音がしました。
              【奇・3】生臭い匂いがします。
              【奇・4】湿った空気が肌を撫でます。（ロマンティック＋1）
              【奇・5】うっかり足元を濡らせてしまいました。
              【奇・6】遠くを水鳥が滑っていきました。（ハートフル＋1）
              【偶・1】水面に映した自分の顔が、不自然にくっきりとしていました。（カタストロフ＋1）
              【偶・2】水がやけに濁っています。
              【偶・3】底の方に何か沈んでいるのを見てしまったような気がします。
              【偶・4】【ガラクタ（打従）】（グッズ）が所在なさげに浮かんでいます。
              【偶・5】一瞬寒気に襲われました。（ルナティック＋1）
              【偶・6】水の中で、魚の影が翻りました。
            },
          },
        }.freeze
    end
  end
end
