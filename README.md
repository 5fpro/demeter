銀行及其分行資訊API
=======

資料來源: [財金資訊股份有限公司](https://www.fisc.com.tw/tc/knowledge/opendata.aspx)

注意事項
=======

1. git clone 時請務必加上參數 --recursive-submodules

```cli
git clone -b develop --recursive-submodules git@github.com:5fpro/demeter.git
```

爬蟲更新資料庫
=============

```ruby
Fisc::CrawlContext.new.perform
```

將更新的資料庫佈署上去
===========

1. 確保本機的資料是正確的
2. `cd dist && git pull origin gh-pages && cd ..`
3. `rails c`
4. `ExportToDistContext.new.perform`
5. `cd dist && git add . && git commit -m "data update" && git push origin gh-pages`

連線測試
===============

- https://demeter.5fpro.com/banks.json
- https://demeter.5fpro.com/banks/808.json

TODO
==========

1. 地址以外，提供經緯度資料。
2. 後台管理 bank, branch 資料。
3. 本專案性質提升為「各方公開資料」，目前只有放銀行和分行資料。
