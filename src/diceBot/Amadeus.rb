#--*-coding:utf-8-*--

class Amadeus < DiceBot
  
  def initialize
    super
    @sendMode = 2
    @sortType = 1
    @d66Type = 2
  end
  
  def gameName
    'アマデウス'
  end
  
  def gameType
    "Amadeus"
  end
  
  def prefixs
    ['MST', 'RT', 'BT', 'FT', 'FWT']
  end
  
  def getHelpMessage
    return <<INFO_MESSAGE_TEXT
・各種表
　・迷宮シーン表　MST／関係表　RT／休憩表　BT／
　　ファンブル表　FT／致命傷表　FWT
INFO_MESSAGE_TEXT
  end
  
  
  def rollDiceCommand(command)
    info = @@tables[command.upcase]
    
    return nil if info.nil?
    
    name = info[:name]
    type = info[:type]
    table = info[:table]
    
    result = 
      case type
      when '1D6'
        get1D6TableResult(name, table)
      else
        nil
      end
    
    return result
  end
  
  def get1D6TableResult(name, table)
    text, number = get_table_by_1d6(table)
    return nil if( text.nil? )
    
    output = "#{name}(#{number}) ＞ #{text}"
    return output
  end
  
  
  @@tables =
    {
    "MST" => {
      :name => "迷宮シーン表",
      :type => '1D6',
      :table => %w{
水場。壁石の隙間から染み出した水が、床に小さな水たまりを作っている。見たところ臭いもなく澄んだ水で、飲んでも支障はなさそうだ。だが、水場には他の生き物が来るかもしれない。
獣のねぐら。通路に開いた穴のなかから、強烈な悪臭が漂っている。こわごわのぞき込むと、そこは汚物とゴミが詰みあがった小部屋だ。落ちている体毛からして、ここで寝ている動物がいるようだ。
行き止まり。通路は行き止まりで終わっていた。最後のわかれ道はどこだっただろうか……これから戻る道の長さを確認しながら、壁にすばやく目を走らせる。ここになにもなければ本当に歩き損だ。
扉の前。通路は両開きの大扉で終わっていた。禍々しい装飾で飾られた扉の向こうには、いかなる恐怖と脅威が待ち受けているのか？　それを知るためには、扉を開かねばならない。
牢獄。鉄格子で封じられた小さな部屋がいくつも並んでいる。小部屋の中には粗末な寝台が置かれ、そのうちいくつかには人骨のような形を見わけることができる。
迷路。三メートル幅の通路がひたすら伸び、無数の曲がり角とわかれ道が存在する場所。注意深く地図を作るか、目印をつけながら進まなければ、たちまち迷ってしまうだろう。
},},
    "RT" => {
      :name => "関係表",
      :type => '1D6',
      :table => %w{
恋心（プラス）／殺意（マイナス）
同情（プラス）／侮蔑（マイナス）
憧憬（プラス）／嫉妬（マイナス）
信頼（プラス）／疑い（マイナス）
共感（プラス）／不気味（マイナス）
大切（プラス）／面倒（マイナス）
},},
    "BT" => {
      :name => "休憩表",
      :type => '1D6',
      :table => %w{
素敵な夢を見る。この出目を振ったプレイヤーは、好きな属性の領域にインガ一つを配置する。もしくは、自分のPC以外の好きなキャラクター一人を目標に選んで、目標に対する【想い】を1点上昇する。
〈絶界〉の外の世界の友人のことを思い出す。みんなは元気にしているだろうか？　この出目を振ったPCは、【日常】で判定を行うことができる。成功すると、乱心を回復し、黒のインガを1つ取り除くことができる。
一眠りしてしまったのか、不思議な夢を見る。この出目を振ったPCは、【霊力】で判定を行うことができる。成功すると、自分の予言カードの【真実】を見ることができる。
落ち着いて休めそうな場所をみつける。自分の【耐久度】を2D6点回復する。
奇妙な商人に出会う。このシーンに登場したキャラクターは、買い物を行うことができる。「買い物リスト」を見よう。その価格と同じだけ神貨を消費すれば、そのアイテムを一つ獲得できる。獲得したアイテムのデータを、キャラクターシートのアイテム欄に記入しよう（食料以外のアイテムは、3個までしか所持できない）。
食事をしながら、仲間と大いに語り合う。このシーンに登場して、食事を行ったキャラクターは、好きなキャラクター1人を選ぶ。その人物のチェックを消す。
},},
    "FT" => {
      :name => "ファンブル表",
      :type => '1D6',
      :table => %w{
周囲の空気が変化する。運命の輪の上にある赤のインガを青に、青のインガを緑に、緑のインガを白に、白のインガを赤に、それぞれ同時に移動させる。
仲間に迷惑をかけてしまう。自分以外のPC全員の【耐久度】が1点減少する。
この失敗は後に祟るかもしれない……。自分の【耐久度】が1D6点減少する。
あまりの失敗に、みんなの態度が変わる。自分に対して一番高い【想い】の値を持っているキャラクター全員の、その【想い】のプラスとマイナスが反転する。
心に大きな乱れが生まれる。「乱心」状態になる。【耐久度】の欄にある「乱心」を○で囲むこと。乱心が回復するまで、自分が、そのPCの属性の領域にインガを置くことになった場合、そこには配置せず、代わりに黒の領域に配置する。
周囲から活気が失われる。運命の輪から、黒以外の属性のすべての領域のインガを、一つずつ取り除く。
},},
    "FWT" => {
      :name => "致命傷表",
      :type => '1D6',
      :table => %w{
絶望的な攻撃を受ける。そのキャラクターは死亡する。
苦痛の悲鳴をあげ、無惨にも崩れ落ちる。そのキャラクターは行動不能になる。また、黒のインガが1つ増える。
攻撃を受けた武器が砕け、敵の攻撃が直撃する。そのキャラクターは行動不能になる。また、アイテム欄から武器一つを破壊する。
強烈な一撃を受けて気絶する。そのキャラクターは行動不能になる。
意識はあるが、立ち上がることができない。そのキャラクターは行動不能になる。次のシーンになったら【耐久度】が1点に回復する。
奇跡的に持ちこたえる。【耐久度】1点で踏みとどまる。
},},}
  
  
end
