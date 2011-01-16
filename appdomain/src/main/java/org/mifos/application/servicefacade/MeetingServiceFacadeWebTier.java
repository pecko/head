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

package org.mifos.application.servicefacade;

import org.mifos.accounts.servicefacade.UserContextFactory;
import org.mifos.customers.business.service.CustomerService;
import org.mifos.dto.domain.MeetingUpdateRequest;
import org.mifos.framework.exceptions.ApplicationException;
import org.mifos.security.MifosUser;
import org.mifos.security.util.UserContext;
import org.mifos.service.BusinessRuleException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;

public class MeetingServiceFacadeWebTier implements MeetingServiceFacade {

    private final CustomerService customerService;

    @Autowired
    public MeetingServiceFacadeWebTier(CustomerService customerService) {
        this.customerService = customerService;
    }

    @Override
    public void updateCustomerMeeting(MeetingUpdateRequest meetingUpdateRequest) {

        MifosUser user = (MifosUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        UserContext userContext = new UserContextFactory().create(user);

        try {
            customerService.updateCustomerMeetingSchedule(meetingUpdateRequest, userContext);
        } catch (ApplicationException e) {
            throw new BusinessRuleException(e.getKey(), e);
        }
    }
}