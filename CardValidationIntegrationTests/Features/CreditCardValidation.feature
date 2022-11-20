Feature: CreditCardValidation

Scenario Outline: All fields are provided correctly,
	Given I create a new card data <Owner>,<Number>,<IssueDate>,<CVV>
	When I send the request to server 
	Then the server should return <StatusCode>,<Response>

	Examples: 
		| Test scenario     | Owner    | Number           | IssueDate | CVV | StatusCode | Response    |
		| Valid Visa card   | Jane Doe | 4111111111111111 | 1225      | 381 | 200        | ValidVisa   |
		| Valid Master Card | John Doe | 5555555555554444 | 12/25     | 352 | 200        | ValidMaster |
		| Valid Amex Card   | Jeny Doe | 378282246310005  | 12/25     | 188 | 200        | ValidAmex   |


Scenario Outline: card owner does not have credit card information 
	Given I create a new card data <Owner>,<Number>,<IssueDate>,<CVV>
	When I send the request to server 
	Then the server should return <StatusCode>

	Examples: 
		| Test scenario    | Owner    | Number           | IssueDate | CVV | StatusCode | Response   |
		| All null values  |          |                  |           |     | 400        | Null       |
		| null owner       |          | 5555555555554444 | 11/28     | 892 | 400        | NullOwner  |
		| null number      | John Doe |                  | 05/23     | 822 | 400        | NullNumber |
		| null expire date | Jeny Doe | 5555345555554444 |           | 789 | 400        | NullDate   |
		| null cvv         | Jane Doe | 5555345598254415 | 12/25     |     | 400        | NullCvv    |
  
Scenario Outline: verify invalid response codes,
	Given I create card data for new endpoint <RequestType>,<EndPoint>,<Owner>,<Number>,<IssueDate>,<CVV> 
	When I send the request to server with header <ContentType>
	Then the server should return <StatusCode>

	Examples: 
		| Test scenario        | RequestType | ContentType      | EndPoint                             | Owner    | Number           | IssueDate | CVV | StatusCode |
		| Invalid content type | Post        | application/text | /CardValidation/card/credit/validate | Jane Doe | 4111111111111111 | 1225      | 381 | 415        |
		| invalid endpoint     | Post        | application/json | /CardValidation/card/credit/create   | John Doe | 5555555555554444 | 12/25     | 352 | 404        |
		| invalid HTTP method  | Get         | application/json | /CardValidation/card/credit/validate | Jeny Doe | 378282246310005  | 12/25     | 188 | 405        |


Scenario Outline: card owner enter invalid details 
	Given I create a new card data <Owner>,<Number>,<IssueDate>,<CVV>
	When I send the request to server 
	Then the server should return <StatusCode>,<Response>

	Examples: 
		| Test scenario       | Owner    | Number           | IssueDate | CVV   | StatusCode | Response    |
		| All invalid values  | 9827     | 162              | abcd      | 20/60 | 400        | Invalid     |
		| invalid Owner       |          | 5555555555554444 | 11/28     | 892   | 400        | NullOwner   |
		| invalid number      | John Doe | abc2             | 05/23     | 822   | 400        | WrongNumber |
		| invalid expire date | Jeny Doe | 5555345555554444 | 33ab      | 789   | 400        | WrongDate   |
		| invalid cvv         | Jane Doe | 5555345598254415 | 12/25     | abcd  | 400        | WrongCvv    |
  
Scenario Outline: Verify cvv number length 
	Given I create a new card data <Owner>,<Number>,<IssueDate>,<CVV>
	When I send the request to server 
	Then the server should return <StatusCode>,<Response>

	Examples: 
		| Test scenario  | Owner    | Number           | IssueDate | CVV    | StatusCode | Response    |
		| length=0       | John Doe | 5555555555554444 | 12/24     |        | 400        | NullCvv     |
		| 0 < length < 3 | Jim Doe  | 5555555555554444 | 11/28     | 2      | 400        | WrongCvv    |
		| length = 3     | Jill Doe | 5555555555554444 | 05/23     | 822    | 200        | ValidMaster |
		| length = 4     | Jeny Doe | 5555345555554444 | 11/24     | 7891   | 200        | ValidMaster |
		| length > 4     | Jane Doe | 5555345598254415 | 12/25     | 242344 | 400        | WrongCvv    |

Scenario Outline: Verify CVV charactor format
	Given I create a new card data <Owner>,<Number>,<IssueDate>,<CVV>
	When I send the request to server 
	Then the server should return <StatusCode>,<Response>

	Examples: 
		| Test scenario                              | Owner    | Number           | IssueDate | CVV  | StatusCode | Response    |
		| Three numbers                              | Jill Doe | 5555345555554444 | 06/28     | 123  | 200        | ValidMaster |
		| Four numbers                               | John Doe | 5555345555554444 | 05/27     | 8789 | 200        | ValidMaster |
		| One number followed by two special chars   | Jane Doe | 5555345598254415 | 12/25     | 2**  | 400        | WrongCvv    |
		| One number followed by three special chars | Jeny Doe | 5555345555554444 | 09/28     | 2*** | 400        | WrongCvv    |
		| All special chars                          | Jane Doe | 5555345598254415 | 12/25     | **** | 400        | WrongCvv    |
		| letters                                    | Jane Doe | 5555345598254415 | 12/25     | abc  | 400        | WrongCvv    |
		| decimal                                    | Jane Doe | 5555345598254415 | 12/25     | 22.2 | 400        | WrongCvv    |

Scenario Outline: Verify visa card number length 
	Given I create a new card data <Owner>,<Number>,<IssueDate>,<CVV>
	When I send the request to server 
	Then the server should return <StatusCode>,<Response>

	Examples: 
		| Test scenario          | Owner    | Number            | IssueDate | CVV  | StatusCode | Response    |
		| length = 0             | John Doe |                   | 09/24     | 2060 | 400        | NullNumber  |
		| 0 < length number <13  | John Doe | 411111111         | 05/23     | 822  | 400        | WrongNumber |
		| length = 13            | Jeny Doe | 4111111111111     | 06/29     | 789  | 200        | ValidVisa   |
		| 13 < length number <16 | Jane Doe | 41111111111111    | 12/25     | 345  | 400        | WrongNumber |
		| length = 16            | Jane Doe | 4111111111111111  | 12/25     | 1222 | 200        | ValidVisa   |
		| length > 16            | Jane Doe | 41111111111111111 | 12/25     | 5312 | 400        | WrongNumber |

Scenario Outline: Verify visa card number format
	Given I create a new card data <Owner>,<Number>,<IssueDate>,<CVV>
	When I send the request to server 
	Then the server should return <StatusCode>,<Response>

	Examples: 
		| Test scenario                                 | Owner    | Number            | IssueDate | CVV  | StatusCode | Response    |
		| Start with 4 and length = 13 numbers          | Jeny Doe | 4111111111111     | 09/23     | 4556 | 200        | ValidVisa   |
		| Start with 4 and length = 16 numbers          | John Doe | 4111111111111111  | 05/23     | 822  | 200        | ValidVisa   |
		| Start with !4 and length = 13 numbers         | Jeny Doe | 3111111111111     | 02/28     | 789  | 400        | WrongNumber |
		| Start with !4 or !5 and length = 16 numbers   | Jane Doe | 611111111111111   | 12/25     | 3332 | 400        | WrongNumber |
		| Start with 4 and followed by 12 special chars | Jane Doe | 4************     | 12/25     | 334  | 400        | WrongNumber |
		| Start with 4 and followed by 15 special chars | Jane Doe | 4***************  | 12/25     | 542  | 400        | WrongNumber |
		| All special chars and length = 13             | Jane Doe | *************     | 12/25     | 1234 | 400        | WrongNumber |
		| All special chars and length = 16             | Jane Doe | ****************  | 12/25     | 564  | 400        | WrongNumber |
		| letters                                       | Jane Doe | abcdefghijklmn    | 12/25     | 222  | 400        | WrongNumber |
		| decimal                                       | Jane Doe | 41111111.11111111 | 12/25     | 222  | 400        | WrongNumber |

Scenario Outline: Verify Master card number length with correct format
	Given I create a new card data <Owner>,<Number>,<IssueDate>,<CVV>
	When I send the request to server 
	Then the server should return <StatusCode>,<Response>

	Examples: 
		| Test scenario  | Owner    | Number               | IssueDate | CVV  | StatusCode | Response    |
		| length = 0     | John Doe | 162                  | 09/30     | 1120 | 400        | WrongNumber |
		| 0 < length <16 | John Doe | 5555555555554444     | 11/28     | 892  | 200        | ValidMaster |
		| length = 16    | John Doe |                      | 05/23     | 822  | 400        | NullNumber  |
		| length > 16    | Jeny Doe | 55553455555544441243 | 09/28     | 789  | 400        | WrongNumber |

Scenario Outline: Verify Master card number format
	Given I create a new card data <Owner>,<Number>,<IssueDate>,<CVV>
	When I send the request to server 
	Then the server should return <StatusCode>,<Response>

	Examples: 
	    | Test scenario                                 | Owner    | Number            | IssueDate | CVV  | StatusCode | Response    |
	    | Start with 51 and length = 16 numbers         | Jill Doe | 5177777777777777  | 09/28     | 5433 | 200        | ValidMaster |
	    | Start with 55 and length = 16 numbers         | Jill Doe | 5553455982544152  | 09/28     | 5433 | 200        | ValidMaster |
	    | Start with 56 and length = 16 numbers         | Jill Doe | 5653455982544152  | 09/28     | 5433 | 400        | WrongNumber |
	    | Start with 50 and length = 16 numbers         | Jill Doe | 5053455982544152  | 09/28     | 5433 | 400        | WrongNumber |
	    | Start with 2221 and length = 16 numbers       | Jill Doe | 2221455982544152  | 09/28     | 5433 | 200        | ValidMaster |
	    | Start with 2229 and length = 16 numbers       | Jill Doe | 2229455982544152  | 09/28     | 5433 | 200        | ValidMaster |
	    | Start with 2220 and length = 16 numbers       | Jill Doe | 2220455982544152  | 09/28     | 5433 | 400        | WrongNumber |
	    | Start with 223 and length = 16 numbers        | Jill Doe | 2233455982544152  | 09/28     | 5433 | 200        | ValidMaster |
	    | Start with 229 and length = 16 numbers        | Jill Doe | 2293455982544152  | 09/28     | 5433 | 200        | ValidMaster |
	    | Start with 220 and length = 16 numbers        | Jill Doe | 2203455982544152  | 09/28     | 5433 | 400        | WrongNumber |
	    | Start with 23 and length = 16 numbers         | Jill Doe | 2353455982544152  | 09/28     | 5433 | 200        | ValidMaster |
	    | Start with 26 and length = 16 numbers         | Jill Doe | 2653455982544152  | 09/28     | 5433 | 200        | ValidMaster |
	    | Start with 21 and length = 16 numbers         | Jill Doe | 2153455982544152  | 09/28     | 5433 | 400        | WrongNumber |
	    | Start with 2701 and length = 16 numbers       | Jill Doe | 2701455982544152  | 09/28     | 5433 | 200        | ValidMaster |
	    | Start with 2720 and length = 16 numbers       | Jill Doe | 2720455982544152  | 09/28     | 5433 | 200        | ValidMaster |
	    | Start with 5 and followed by 15 special chars | Jane Doe | 5***************  | 12/25     | 4221 | 400        | WrongNumber |
	    | All special chars and length = 16             | Jane Doe | ****************  | 12/25     | 222  | 400        | WrongNumber |
	    | letters                                       | Jane Doe | abcdefghijklmn    | 12/25     | 222  | 400        | WrongNumber |
	    | decimal                                       | Jane Doe | 5553455.982544152 | 12/25     | 222  | 400        | WrongNumber |


Scenario Outline: Verify Amex card number length with correct format
	Given I create a new card data <Owner>,<Number>,<IssueDate>,<CVV>
	When I send the request to server 
	Then the server should return <StatusCode>,<Response>

	Examples: 
	    | Test scenario  | Owner    | Number              | IssueDate | CVV  | StatusCode | Response    |
	    | length = 0     | Jane Doe |                     | 0227      | 2060 | 400        | NullNumber  |
	    | 0 < length <15 | John Doe | 378                 | 05/23     | 822  | 400        | WrongNumber |
	    | length = 15    | Jeny Doe | 378282246310005     | 08/26     | 789  | 200        | ValidAmex   |
	    | length > 15    | Jane Doe | 3782822463100058709 | 12/25     | 877  | 400        | WrongNumber |  
     
Scenario Outline: Verify Amex card number format
	Given I create a new card data <Owner>,<Number>,<IssueDate>,<CVV>
	When I send the request to server 
	Then the server should return <StatusCode>,<Response>

	Examples: 
		| Test scenario                                                   | Owner    | Number           | IssueDate | CVV  | StatusCode | Response    |
		| Start with 34 and length = 15 numbers                           | Jane Doe | 347889293047162  | 0927      | 2060 | 200        | ValidAmex   |
		| Start with 37 and length = 15 numbers                           | John Doe | 377889293047162  | 05/23     | 822  | 200        | ValidAmex   |
		| Start with 3 but not followed by 4 or 7 and length = 13 numbers | Jane Doe | 389999021233849  | 12/25     | 5434 | 400        | WrongNumber |
		| Start with 34 but followed by special chars and length = 15     | Jeny Doe | 34*************  | 08/28     | 789  | 400        | WrongNumber |
		| Start with 37 but followed by special chars and length = 15     | Jane Doe | 37*************  | 12/25     | 233  | 400        | WrongNumber |
		| Start with 347 but followed by special chars and length = 15    | Jane Doe | 347************  | 12/25     | 5466 | 400        | WrongNumber |
		| All special chars and length = 15                               | Jane Doe | ***************  | 12/25     | 6554 | 400        | WrongNumber |
		| Letters                                                         | Jane Doe | abcdefghijklmno  | 12/25     | 321  | 400        | WrongNumber |
		| Decimal                                                         | Jane Doe | 55553455.9825441 | 12/25     | 222  | 400        | WrongNumber |

Scenario Outline: Verify Card expire date
	Given I create a new card data <Owner>,<Number>,<IssueDate>,<CVV>
	When I send the request to server 
	Then the server should return <StatusCode>,<Response>

	Examples: 
		| Test scenario                          | Owner    | Number           | IssueDate | CVV  | StatusCode | Response    |
		| Two number month with two number year  | John Doe | 5555345555554444 | 1230      | 2060 | 200        | ValidMaster |
		| Two number month with four number year | John Doe | 347889293047162  | 102030    | 822  | 200        | ValidAmex   |
		| One number month with two number year  | Jane Doe | 5555345598254415 | 129       | 343  | 400        | WrongDate   |
		| One number month with four number year | Jeny Doe | 5555345555554444 | 1/2027    | 789  | 400        | WrongDate   |
		| Month and year in wrong order          | Jane Doe | 5555345598254415 | 2030/02   | 123  | 400        | WrongDate   |
		| correct date with backward Slash       | Jane Doe | 5555345598254415 | 12/25     | 1253 | 200        | ValidMaster |
		| expired card                           | Jane Doe | 5555345598254415 | 12/20     | 544  | 400        | WrongDate   |
		| Letters                                | Jane Doe | 5555345598254415 | absd      | 321  | 400        | WrongDate   |
		| Decimal                                | Jane Doe | 5555345598254415 | 12.25     | 222  | 400        | WrongDate   |


Scenario Outline: Verify Card owner name format
	Given I create a new card data <Owner>,<Number>,<IssueDate>,<CVV>
	When I send the request to server 
	Then the server should return <StatusCode>,<Response>

	Examples: 
		| Test scenario                     | Owner            | Number           | IssueDate | CVV  | StatusCode | Response    |
		| Owner with no name                |                  | 5555345555554444 | 12/24     | 5443 | 400        | NullOwner   |
		| Owner with first name             | John             | 347889293047162  | 05/23     | 822  | 200        | ValidAmex   |
		| Owner with first and middle name  | Jane Doe         | 5555345598254415 | 12/25     | 342  | 200        | ValidMaster |
		| Owner with three names            | Jeny Doe Doe     | 5555345555554444 | 11/26     | 789  | 200        | ValidMaster |
		| Owner with names > 3              | Jane Doe Doe Doo | 5555345598254415 | 12/25     | 5432 | 400        | WrongOwner  |
		| Owner name with special charactor | Ja*e             | 5555345598254415 | 12/25     | 5432 | 400        | WrongOwner  |
		| numbers                           | 123 421          | 5555345598254415 | 05/23     | 321  | 400        | WrongOwner  |
