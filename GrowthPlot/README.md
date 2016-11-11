成長可視化アプリケーション
--------------------------

植物の成長のばらつき・バッチ間差を簡単に可視化します。  
自分のPC内のファイルもOneDrive上のファイルも可視化できます。

対象ファイル
------------

-   .csv (ローカル/webとも対応)
    -   [形式](https://github.com/KeachMurakami/Lab/blob/master/GrowthPlot/SampleData.csv)
-   .xlsx (ローカルのみ対応)
    -   [形式](https://github.com/KeachMurakami/Lab/blob/master/GrowthPlot/SampleData.xlsx)

<!-- -->

    read.csv("https://raw.githubusercontent.com/KeachMurakami/Lab/master/GrowthPlot/SampleData.csv") %>%
      head(10) %>%
      kable

<table>
<thead>
<tr class="header">
<th align="left">Name</th>
<th align="right">Date_measured</th>
<th align="right">Date_sowing</th>
<th align="left">Experiment</th>
<th align="right">PlantNo</th>
<th align="left">Remark</th>
<th align="right">Stem_length</th>
<th align="right">Leaf_length_2nd</th>
<th align="right">Leaf_length_4th</th>
<th align="right">Leaf_length_6th</th>
<th align="right">Leaf_length_8th</th>
<th align="right">Leaf_length_10th</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">Murakami</td>
<td align="right">20150105</td>
<td align="right">20150101</td>
<td align="left">Preliminary</td>
<td align="right">1</td>
<td align="left">NA</td>
<td align="right">2.30</td>
<td align="right">1.75</td>
<td align="right">1.75</td>
<td align="right">1.75</td>
<td align="right">1.75</td>
<td align="right">1.75</td>
</tr>
<tr class="even">
<td align="left">Murakami</td>
<td align="right">20150105</td>
<td align="right">20150101</td>
<td align="left">Preliminary</td>
<td align="right">2</td>
<td align="left">NA</td>
<td align="right">NA</td>
<td align="right">NA</td>
<td align="right">NA</td>
<td align="right">NA</td>
<td align="right">NA</td>
<td align="right">NA</td>
</tr>
<tr class="odd">
<td align="left">Murakami</td>
<td align="right">20150105</td>
<td align="right">20150101</td>
<td align="left">Preliminary</td>
<td align="right">3</td>
<td align="left">NA</td>
<td align="right">1.46</td>
<td align="right">1.00</td>
<td align="right">1.00</td>
<td align="right">1.00</td>
<td align="right">1.00</td>
<td align="right">1.00</td>
</tr>
<tr class="even">
<td align="left">Murakami</td>
<td align="right">20150105</td>
<td align="right">20150101</td>
<td align="left">Preliminary</td>
<td align="right">4</td>
<td align="left">NA</td>
<td align="right">NA</td>
<td align="right">NA</td>
<td align="right">NA</td>
<td align="right">NA</td>
<td align="right">NA</td>
<td align="right">NA</td>
</tr>
<tr class="odd">
<td align="left">Murakami</td>
<td align="right">20150105</td>
<td align="right">20150101</td>
<td align="left">Preliminary</td>
<td align="right">5</td>
<td align="left">NA</td>
<td align="right">1.59</td>
<td align="right">1.34</td>
<td align="right">1.34</td>
<td align="right">1.34</td>
<td align="right">1.34</td>
<td align="right">1.34</td>
</tr>
<tr class="even">
<td align="left">Murakami</td>
<td align="right">20150105</td>
<td align="right">20150101</td>
<td align="left">Preliminary</td>
<td align="right">6</td>
<td align="left">NA</td>
<td align="right">1.59</td>
<td align="right">1.36</td>
<td align="right">1.36</td>
<td align="right">1.36</td>
<td align="right">1.36</td>
<td align="right">1.36</td>
</tr>
<tr class="odd">
<td align="left">Murakami</td>
<td align="right">20150105</td>
<td align="right">20150101</td>
<td align="left">Preliminary</td>
<td align="right">7</td>
<td align="left">NA</td>
<td align="right">1.98</td>
<td align="right">1.03</td>
<td align="right">1.03</td>
<td align="right">1.03</td>
<td align="right">1.03</td>
<td align="right">1.03</td>
</tr>
<tr class="even">
<td align="left">Murakami</td>
<td align="right">20150105</td>
<td align="right">20150101</td>
<td align="left">Preliminary</td>
<td align="right">8</td>
<td align="left">NA</td>
<td align="right">2.09</td>
<td align="right">1.29</td>
<td align="right">1.29</td>
<td align="right">1.29</td>
<td align="right">1.29</td>
<td align="right">1.29</td>
</tr>
<tr class="odd">
<td align="left">Murakami</td>
<td align="right">20150105</td>
<td align="right">20150101</td>
<td align="left">Preliminary</td>
<td align="right">9</td>
<td align="left">NA</td>
<td align="right">2.10</td>
<td align="right">1.16</td>
<td align="right">1.16</td>
<td align="right">1.16</td>
<td align="right">1.16</td>
<td align="right">1.16</td>
</tr>
<tr class="even">
<td align="left">Murakami</td>
<td align="right">20150105</td>
<td align="right">20150101</td>
<td align="left">Preliminary</td>
<td align="right">10</td>
<td align="left">NA</td>
<td align="right">2.41</td>
<td align="right">1.48</td>
<td align="right">1.48</td>
<td align="right">1.48</td>
<td align="right">1.48</td>
<td align="right">1.48</td>
</tr>
</tbody>
</table>

-   Name ~ Remarkまでのカラムは名前・記入様式を変更しないように
-   変数カラムは適宜追加可能
    -   変数カラム内に文字列のカラムがあるとエラーになる
-   欠測は`NA`で記入または空欄

使い方
------

### 自分のPC上のデータを使用する場合

-   所定形式の`.csv`または`.xlsx`ファイルを用意します  
-   [アプリ](https://keachmurakami.shinyapps.io/GrowthPlot/)を開き、左サイドバー内の「ファイルをアップロード」をクリックし、ファイルをアップロードします

### web上のデータを使用する場合

-   所定形式の`.csv`ファイルを[OneDrive](https://onedrive.live.com/)にアップロードします
    -   管理の簡単さから、‘とりあえず’のOneDriveです
    -   csvファイルをダウンロード -&gt;
        同様のフォーマットで最下部にデータ追加 -&gt;
        保存して再度アップロード
    -   バージョン管理ソフト
        ([GitLab](https://about.gitlab.com/)) で履歴も管理できると素敵です...
-   OneDrive上で「対象csvファイルを右クリック -&gt; 埋め込み -&gt;
    生成」をクリックし、表示された文字列
    (`<iframe src ... cid=XXXXXX&resid=YYYYYY&authkey=ZZZZZZ ... </iframe>`)
    をコピーします
-   [アプリ](https://keachmurakami.shinyapps.io/GrowthPlot/)を開き、左サイドバー内の「OneDriveファイルのID」に文字列を貼り付けます

注意
----

-   カーブは局所重み付き回帰曲線 (Lowess; Rのデフォルト)
    なので、あまり深い意味はありません
    -   対数成長・ロジスティック成長などのプログラムも組むかも
-   機能リクエストばっちこいです (D論が終わったらやります)

その他
------

-   能動的にアプリケーションを消すことはありませんが、各種サービスが停止したら維持に力は注ぎません
-   R + Shiny + Shinyapps.io で動いています
    -   このページ上部の`server.R`と`ui.R`がソースコードです
    -   Shiny要素がややわかりづらいので、データのハンドリング・作図のプロセスが気になった場合は、`standalone.R`を見てください

License
-------

These codes are licensed under CC0.

[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")](http://creativecommons.org/publicdomain/zero/1.0/deed.ja)
