Feature: Basic Gift
  As a user
  I want to be able to use a gift I'm receiving
  So that I can make an impact

Background:
  Given I am an authenticated user
  And I have received a $5 gift

Scenario: From open to checkout payment options
  Given I am on the open dt gifts page
  And I fill in "Enter your Pickup Code" with my gift pickup code
  And I press "Open"
  Then I should be on the open dt gifts page
  And I should have a $5 gift card balance
  When I follow "Let Uend: figure it out"
	Then I should see "You are choosing to let Uend: figure out where your gift card balance will be used"
	When I press "Yes"
	Then I should see "If you wish to support UEnd directly on a monthly basis, you can do so by signing up for U:Powered"
	When I choose "$25.00"
	And I press "order_submit"
	Then I should see "Payment Options"
	And I fill in "Take from my Gift Card" with "3"
	And I fill in "Put on my Credit Card" with "2"
	And I press "order_submit"
	Then I should see "Billing Information"
	And I fill in "First name" with "John"
	And I fill in "Last name" with "Doe"
	And I fill in "Email" with "j.doe@jdoeinc23343.net"
	And I fill in "Street address" with "123 Main St."
	And I fill in "City" with "Toronto"
	And I fill in "Province/State" with "ON"
	And I fill in "Postal/Zip code" with "M5W 1E6"
	And I select "Canada" from "Country"
	And I press "order_submit"
	Then I should see "Credit Card Details"
	And I fill in "Cardholder name" with "John Doe"
  And I fill in "Credit card number" with "1"
  And I fill in "Card security number (CVV)" with "989"
  And I select "01" from "order_expiry_month"
  And I select "2018" from "order_expiry_year"
	And I press "order_submit"
	Then I should see "Order Summary"
	And I press "order_submit"
	Then I should see "Receipt"
	