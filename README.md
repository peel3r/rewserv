#REWAWRDS SERVICE


## === User Story ===

Display customer's available rewards

-  As a customer, if I am eligible for rewards, then I want to see which rewards
  are available based on my channel subscriptions.

## === Accepted inputs ===

-  account nr
-  portfolio

## === Services to be implemented ===

-  RewardsService should return a list of all the rewards available according to the subscriptions on the portfolio
-  EligibilityService accepts account nr as an input (mock or stub)

## === Codes for the channel subscriptions and associated rewards ===


**   <table>
        <tr>
          <td>Channel</td>
          <td>Reward</td>
        </tr>
        <tr>
          <td>SPORTS</td>
          <td>CHAMPIONS_LEAGUE_FINAL_TICKET</td>
        </tr>
        <tr>
          <td>KIDS</td>
          <td>N/A</td>
        </tr>
        <tr>
          <td>MUSIC</td>
          <td>KARAOKE_PRO_MICROPHONE</td>
        </tr>
        <tr>
          <td>NEWS</td>
          <td>N/A</td>
        </tr>
        <tr>
          <td>MOVIES</td>
          <td>PIRATES_OF_THE_CARIBBEAN_COLLECTION</td>
        </tr>
    </table>


## === Expected result  ===

-  CUSTOMER_ELIGIBLE Customer is eligible Return relevant rewards according to the customer's portfolio

-  CUSTOMER_INELIGIBLE Customer is not eligible Return no rewards

-  Technical failure exception Service technical failure Return no rewards

-  Invalid account number exception The supplied account number is invalid Return no rewards and notify the client that the account number is invalid


## === Install and run ===

-  bundle exec install
-  rackup

## === Sample input/output ===


-  input: ####  localhost:9292/available_rewards?account_nr=ab12&subscriptions[]=SPORTS  ###

    output: `{"available_rewards":["CHAMPIONS_LEAGUE_FINAL_TICKET"],"error":false}`

-  input: ####  localhost:9292/available_rewards?account_nr=ab12&subscriptions[]=KIDS  ###

     output: `{"available_rewards":[],"error":false}`

-  input: ####  localhost:9292/available_rewards?account_nr=ab12&subscriptions[]=SPORTS&&subscriptions[]=MUSIC  ###

    output #for multi rewards: `{"available_rewards":["CHAMPIONS_LEAGUE_FINAL_TICKET","KARAOKE_PRO_MICROPHONE"],"error":false}`

 ===