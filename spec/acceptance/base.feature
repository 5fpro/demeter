Feature: base_controller
  Scenario: 首頁
    When 瀏覽 首頁
      Then 頁面回應 200
  Scenario: 404
    When 瀏覽 /123asdasdas
      Then 頁面回應 404
    When 瀏覽 /123asdasdas.txt
      Then 頁面回應 404
