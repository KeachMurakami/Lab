成長可視化プロジェクト
----------------------

植物の成長のばらつき・バッチ間差を簡単に可視化します。

使い方
------

1.  以下のような形式のcsvファイルを用意します
    -   [sampleファイル](https://github.com/KeachMurakami/Lab/blob/master/GrowthPlot/SampleData.csv)
    -   csvファイルは管理の簡単さから、とりあえず[OneDrive](https://onedrive.live.com/)に置いてあります
    -   csvファイルをダウンロード -&gt;
        同様のフォーマットで最下部にデータ追加 -&gt;
        保存して再度アップロード
        -   バージョン管理ソフト
            ([GitLab](https://about.gitlab.com/)) で履歴も管理できると素敵です...

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

1.  [アプリ](https://keachmurakami.shinyapps.io/GrowthPlot/)を開きます
2.  OneDrive上で「対象csvファイルを右クリック -&gt; 埋め込み -&gt;
    共有」して表示された`cid=XXXXXX&resid=YYYYYY&authkey=ZZZZZZ`部をサイドバー内のテキストボックスに貼り付けます

### 注意

-   カーブはとりあえず局所重み付き回帰曲線 (Lowess; Rのデフォルト)
    なので、あまり深い意味はありません
-   機能リクエストばっちこいです
