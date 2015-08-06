Feature: Buy three books
  In order to verify the steps befor offer applicaton
  As a customer
  I want to select three books in the list
  So I can access to my basket with three books
  So I can calculate the basic amount

Scenario: Buy three books
  Given Collection Books appeared
  Then I wait
  Then I touch collection item number 0
  Then I scroll down
  Then I touch collection item number 3
  Then I scroll down
  Then I touch collection item number 4
  When I touch the "confirm" navbar button
  Then I see the "basketTableView"
  Then I wait
  When I touch the "InfosImg" navbar button
  Then I see the "infosTableView"