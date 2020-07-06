# GUI_ROI_tool
the GUI tool for taking a region of interest (ROI) from a fluorescence image
<img src="doc/demo.gif" width="800" align="below">

## Dependencies
MATLAB

## RUN
Open "Get_ROI.m" and run the code (F5 or RUN). Select the image (tif file).
Image must be the 8 or 16 bit grascale tif image.

"Get_ROI.m"を開いて、F5または実行ボタンで実行すると、画像選択画面が現れる。ROI取りをしたい画像を選択する。
画像は8または16bitのグレースケールのtif画像である必要がある。

## Usage of GUI

平均化フィルタと二値化を組み合わせて細胞領域を取り出す。

Get area→クリックしたところをつながった部分をとる

Get line→クリックした2点の間の軸索探索

パラメータを確認しながら、ROI取りできる。

赤：元画像　　緑：ワークスペース　　青：取得したROI　をそれぞれ表している。

## Demos
You can use the "demo_image_8bit.tif" or "demo_image_16bit.tif" for demos.

"demo_image_8bit.tif" または "demo_image_16bit.tif"をデモとして使用できる。


## Author
Takehiro Ajioka 

E-mail:1790651m@stu.kobe-u.ac.jp


## Affiliation

Division of System Neuroscience, Kobe University of Graduate School of Medicine

神戸大学医学研究科システム生理学分野
