# ExcelDiff

ExcelDiffモジュールは、Excelファイルの内容をdiffをとるためのメソッドを提供します。
CSV形式でdiffをとるため、フォントやセル幅といった見た目の要素を除いて内容を比較することが可能です。
対応している拡張子は.xlsxと.xlsです。

## Usage

cloneしてbundle installを行うことで、実際にサンプルを試すことができます。


```
  $ bundle install  --path ./.bundle
```

```
  $ bundle exec excel_diff sample/test1.xlsx sample/test2.xlsx
  --- /path/to/excel_diff/lib/excel_diff/tmp/tmp1sheet0.csv  2017-06-20 15:46:12.729112559 +0900
  +++ /path/to/excel_diff/lib/excel_diff/tmp/tmp2sheet0.csv  2017-06-20 15:46:12.729112559 +0900
  @@ -1,4 +1,4 @@
   "test","test"
   "test",
  -"test1",
  -"test","test"
  +"test2",
  +"test","test2"
```

また、GitリポジトリにあるGemfileに以下を追記してExcelDiffモジュールをインストールすれば、

```
gem 'excel_diff', git: 'https://github.com/s-kawamoto/excel_diff'
```

```
  $ bundle install  --path ./.bundle
```

以下のコマンドによりgitで管理されているExcelファイルの、現在チェックアウトしているコミットとのdiffを取ることができます。

```
  $ bundle exec excel_git_diff hoge.xlsx
```

## License

ExcelDiff is released under the MIT License, see LICENSE.txt.
