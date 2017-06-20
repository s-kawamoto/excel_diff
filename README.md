# ExcelDiff

## Usage

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

## License

ExcelDiff is released under the MIT License, see LICENSE.txt.
