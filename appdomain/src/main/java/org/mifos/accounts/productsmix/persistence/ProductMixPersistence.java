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

package org.mifos.accounts.productsmix.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.mifos.accounts.productdefinition.business.PrdOfferingBO;
import org.mifos.accounts.productdefinition.util.helpers.ProductDefinitionConstants;
import org.mifos.accounts.productsmix.business.ProductMixBO;
import org.mifos.accounts.util.helpers.AccountConstants;
import org.mifos.application.NamedQueryConstants;
import org.mifos.framework.exceptions.PersistenceException;
import org.mifos.framework.persistence.LegacyGenericDao;

public class ProductMixPersistence extends LegacyGenericDao {

    private static final Logger logger = LoggerFactory.getLogger(ProductMixPersistence.class);

    public ProductMixBO getAllLoanOfferingMixByID(Short prdofferingMixId) throws PersistenceException {
        logger.debug("in getAllLoanOfferingMix");
        return getPersistentObject(ProductMixBO.class, prdofferingMixId);
    }

    @SuppressWarnings("cast")
    public List<ProductMixBO> getAllProductMix() throws PersistenceException {
        return (List<ProductMixBO>) executeNamedQuery(NamedQueryConstants.LOAD_ALL_DEFINED_PRODUCTS_MIX, null);
    }

    @SuppressWarnings("cast")
    public List<PrdOfferingBO> getNotAllowedProducts(Short prdofferingId) throws PersistenceException {

        Map<String, Object> queryParameters = new HashMap<String, Object>();
        queryParameters.put(AccountConstants.PRDOFFERINGID, prdofferingId);
        return (List<PrdOfferingBO>) executeNamedQuery(NamedQueryConstants.LOAD_NOT_ALLOWED_PRODUCTS, queryParameters);
    }

    public ProductMixBO getPrdOfferingMixByPrdOfferingID(Short productID, Short notAllowedProductID)
            throws PersistenceException {

        HashMap<String, Object> queryParameters = new HashMap<String, Object>();
        queryParameters.put(ProductDefinitionConstants.PRODUCTID, productID);
        queryParameters.put(ProductDefinitionConstants.NOTALLOWEDPRODUCTID, notAllowedProductID);
        ProductMixBO prdOffring = (ProductMixBO) execUniqueResultNamedQuery(NamedQueryConstants.PRD_MIX_BYID,
                queryParameters);
        return prdOffring;
    }

    public boolean doesPrdOfferingsCanCoexist(Short idPrdOff_A, Short idPrdOff_B) throws PersistenceException {
        if (null == getPrdOfferingMixByPrdOfferingID(idPrdOff_A, idPrdOff_B)) {
            if (null == getPrdOfferingMixByPrdOfferingID(idPrdOff_B, idPrdOff_A)) {
                return true;
            }
        }

        return false;

    }
}
