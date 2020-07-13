# 10G Ethernet MAC for Xilinx FPGA

## 概要

Xilinx FPGA用の10G Ethernet PCS/PMAと組み合わせて 10G Ethernetでの通信をするデザインを作るために使うことができる、10G Ethernet MAC IPです。
このデザインは株式会社フィックスターズ Tech Blog の記事(https://proc-cpuinfo.fixstars.com/2020/05/alveo-u50-10g-ethernet/) 向けに開発されたものです。そのためデザインは記事に記載がある環境、操作に限定して動作確認を行っています。

## 動作環境

以下のボードで動作確認を行っています。

* Alveo U50 (ES3)


また、10G Ethernetの通信対象のNIC及びケーブルとして、以下のもので動作確認を行っています。

* 10G Ethernet NIC: X520-10G-2S-X8 (10Gtek)
* 10G SFP+ケーブル: SFP-H10GB-CU1M (10Gtek)

## ライセンス

以下のディレクトリにあるソースコードは株式会社フィックスターズの著作物であり、3条項BSDライセンスのもとに利用することができます。
詳しくは本リポジトリに含まれている `LICENSE` ファイルを確認してください。

* crc
* util
* vivado/board
* vivado/board_icmp
* vivado/board_loopback
* vivado/sw
* xgmii_axis

toeディレクトリ以下にSubmoduleで取得しているモジュールは、元のリポジトリ[(https://github.com/hpcn-uam/100G-fpga-network-stack-core)](https://github.com/hpcn-uam/100G-fpga-network-stack-core) に記載のライセンスにしたがってください。

vivado/XilinxBoardStoreディレクトリ以下にSubmoduleで取得しているモジュールは Alveo U50 定義ファイルを使用しています。Alveo U50 定義ファイルのライセンスは Apache License 2.0 にしたがってください。

## デザインの合成

以下のVivadoで合成を確認しています。

```
Vivado v2019.2_AR72956 (64-bit)
SW Build 2700185 on Thu Oct 24 18:45:48 MDT 2019
IP Build 2699827 on Thu Oct 24 21:16:38 MDT 2019
Copyright 1986-2019 Xilinx, Inc. All Rights Reserved
```

合成可能なデザインは2種類あり、それぞれ指定のディレクトリ以下で `make` を実行することで合成が可能です。

### board_loopback

[10G Ethernet MACの動作確認](https://proc-cpuinfo.fixstars.com/2020/05/alveo-u50-10g-ethernet/) に記載されているデザインは、下記手順で合成できます。

```
$ cd /path/to/xg_mac/vivado/board_loopback/
$ make
```

### board_icmp

[pingに応答してみる](https://proc-cpuinfo.fixstars.com/2020/05/alveo-u50-10g-ethernet/) に記載されているデザインは、下記手順で合成できます。

```
$ cd /path/to/xg_mac/vivado/board_icmp/
$ make
```
