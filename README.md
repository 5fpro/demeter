銀行及其分行資訊API
=======

資料來源: [財金資訊股份有限公司](https://www.fisc.com.tw/tc/knowledge/opendata.aspx)

REST API
=======

### Get 全銀行資訊

### Request

`GET /banks/`

    curl -i -H 'Accept: application/json' http://api.localhost:3000/banks/

### Response

    {
        "code": "502",
        "name": "宜蘭縣頭城區漁會（農金資訊所屬會員）"
    },
    {
        "code": "000",
        "name": "中央銀行國庫局"
    },
    {
        "code": "004",
        "name": "臺灣銀行"
    },
    {
        "code": "005",
        "name": "臺灣土地銀行"
    },
    {
        "code": "006",
        "name": "合作金庫商業銀行"
    }

---
### Get 分行資訊

### Request

`GET /banks/:id/branches/`

    curl -i -H 'Accept: application/json' http://api.localhost:3000/banks/009/branches

### Response

    {
        "branch_code": "2200",
        "bank_branch_code": "0092200",
        "address": "台中市中區自由路二段３８號",
        "name": "營業部"
    },
    {
        "branch_code": "3003",
        "bank_branch_code": "0093003",
        "address": "台北市中山區南京東路二段９８號",
        "name": "吉林分行"
    }
