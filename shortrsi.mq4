//+------------------------------------------------------------------+
//|                                                     shortrsi.mq4 |
//|                                                           shakil |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "shakil"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+


input double sl = 5 ;//stop loss (pips)
input double risk_reward = 2; //risk reward ratio
input double rsi_lower_val = 10; //rsi lower value
input double rsi_upper_val = 90; //rsi upper value
input int rsi_period = 2; // rsi period
input bool five_digit_broker = true; //five digit broker
input double risk_amount_in_dollar = 100; //risk amount(usd)


input double account_initial_balance = 0;
input double challange_profit_target = 0;


int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {


if(OrdersTotal()==0){

//for buy trade

double rsival = iRSI(Symbol(),0,rsi_period,PRICE_CLOSE,0);

double buy_sl = Ask-(Point*sl*10);
double sell_sl = Bid+(Point*sl*10);
double buy_tp = Ask+((Point*sl*10)*risk_reward);
double sell_tp = Bid-((Point*sl*10)*risk_reward);

double lotsize = getLotSize(sl,risk_amount_in_dollar);

if(rsival < rsi_lower_val && (AccountBalance() < challange_profit_target+account_initial_balance || challange_profit_target == 0 )){

int ticket2 = OrderSend(Symbol(),OP_BUY,lotsize,Ask,2,buy_sl,buy_tp,"traded from EA",9009,NULL,Blue);

}


if(rsival > rsi_upper_val && (AccountBalance() < challange_profit_target+account_initial_balance || challange_profit_target == 0)){

int ticket = OrderSend(Symbol(),OP_SELL,lotsize,Bid,2,sell_sl,sell_tp,"traded from EA",9009,NULL,Blue);

}









}



   
  }
//+------------------------------------------------------------------+




double getLotSize(double pips,double amount)
  {

   //double riskamount = (AccountBalance()*0.01*risk_percentage);
   
   double riskamount = amount;

   double lot = 0.00;

   if(five_digit_broker == true)
     {
      lot = (riskamount/pips)/(MarketInfo(Symbol(),MODE_TICKVALUE)*10);

      return lot;

     }


   else
     {

      lot = (riskamount/pips)/(MarketInfo(Symbol(),MODE_TICKVALUE));

      return lot;

     }

  }


double getPips(double price1,double price2)
  {

   if(MarketInfo(Symbol(),MODE_DIGITS)==5)
     {

      double pipDiff = (MathAbs(price1 - price2)*10000);

      return pipDiff;

     }


   else
      if(MarketInfo(Symbol(),MODE_DIGITS)==3)
        {

         double pipDiff = (MathAbs(price1 - price2)*100);

         return pipDiff;
        }





      else
        {

         return 0.00;


        }



  }

