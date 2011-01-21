/*
 * Copyright (c) 2005-2010 Grameen Foundation USA
 * All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * permissions and limitations under the License.
 *
 * See also http://www.apache.org/licenses/LICENSE-2.0.html for an
 * explanation of the license and how it is applied.
 */

package org.mifos.test.acceptance.framework.loan;

import junit.framework.Assert;

import org.mifos.test.acceptance.framework.AbstractPage;

import com.thoughtworks.selenium.Selenium;

@SuppressWarnings("PMD.SystemPrintln")
public class TransactionHistoryPage extends AbstractPage {

    public TransactionHistoryPage(Selenium selenium) {
        super(selenium);
        verifyPage("ViewTransactionHistory");
    }

    /**
     * verifies if the table has reversed transactions
     * @param payAmount
     * @param reversedNumber
     * @param notes
     */
    public void verifyTableForReversedValues(String payAmount, int reversedNumber, String notes) {
        for(int i = 0; i < reversedNumber; i++) {
            int row = i * 8 + 1;
            float amount = 0;
            for(int j = 0; j < 8; j++) {
                String value = selenium.getTable("trxnhistoryList."+(row+j)+".6");
                if(!value.contains("-")) {
                    amount += Float.parseFloat(value);
                }
            }
            Assert.assertEquals(amount, Float.parseFloat(payAmount)*2);
            Assert.assertEquals(selenium.getTable("trxnhistoryList."+row+".10"), notes+(i+1));
            Assert.assertEquals(selenium.getTable("trxnhistoryList."+(row+1)+".10"), notes+(i+1));
            Assert.assertEquals(selenium.getTable("trxnhistoryList."+(row+2)+".10"), notes+(i+1));
            Assert.assertEquals(selenium.getTable("trxnhistoryList."+(row+3)+".10"), notes+(i+1));
        }
    }

    /**
     * Verifies transaction history with total amount paid, and number of transactions.
     * @param amountPaid - the amount client paid
     * @param transactionCount - number of transactions made by client
     * @param maxRowCount - maximum number of rows in transaction table
     */
    public void verifyTransactionHistory(double amountPaid, int transactionCount, int maxRowCount) {
        /* TODO: Check if everything works after fixing loan transactions problem */
        double sum = 0;
        String paymentID = "";
        int paymentCount = 0;
        for(int i = 0; ; i++) {
            if((sum >= amountPaid && "Loan Disbursement".equals(getType(i))) || i >= maxRowCount) {
                break;
            }
            if("11201".equals(getGLCode(i))) {
                String debit = getDebit(i);
                if(!"-".equals(debit)) {
                    sum += Double.valueOf(debit);
                }
                String rowPaymentID = getPaymentID(i);
                if(!paymentID.equals(rowPaymentID)) {
                    paymentID = rowPaymentID;
                    paymentCount++;
                }
            }
        }
        Assert.assertEquals(amountPaid, sum);
        Assert.assertEquals(transactionCount, paymentCount);
    }

    public String getPaymentID(int row) {
        return selenium.getTable("trxnhistoryList."+row+".1");
    }

    public String getType(int row) {
        return selenium.getTable("trxnhistoryList."+row+".3");
    }

    public String getGLCode(int row) {
        return selenium.getTable("trxnhistoryList."+row+".4");
    }

    public String getDebit(int row) {
        return selenium.getTable("trxnhistoryList."+row+".5");
    }
}
