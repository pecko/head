<!--
/**

* editClientPersonalInfo    version: 1.0



* Copyright (c) 2005-2006 Grameen Foundation USA

* 1029 Vermont Avenue, NW, Suite 400, Washington DC 20005

* All rights reserved.



* Apache License
* Copyright (c) 2005-2006 Grameen Foundation USA
*

* Licensed under the Apache License, Version 2.0 (the "License"); you may
* not use this file except in compliance with the License. You may obtain
* a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
*

* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and limitations under the

* License.
*
* See also http://www.apache.org/licenses/LICENSE-2.0.html for an explanation of the license

* and how it is applied.

*

*/
 -->

<%@taglib uri="/tags/mifos-html" prefix="mifos"%>

<%@taglib uri="/tags/date" prefix="date"%>
<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://struts.apache.org/tags-html-el" prefix="html-el"%>
<%@ taglib uri="/userlocaledate" prefix="userdatefn"%>
<%@ taglib uri="/mifos/custom-tags" prefix="customtags"%>
<%@ taglib uri="/sessionaccess" prefix="session"%>

<tiles:insert definition=".clientsacclayoutsearchmenu">
	<tiles:put name="body" type="string">
		<script language="javascript" SRC="pages/framework/js/date.js"></script>
		<script language="javascript" SRC="pages/framework/js/conversion.js"></script>
		<script>

		function goToCancelPage(){
		clientCustActionForm.action="clientCustAction.do?method=cancel";
		clientCustActionForm.submit();
	  }
	  function chkForValidDates(){
		if(!(chkForDateOfBirthDate())){
			return false;
		}
		if (clientCustActionForm.fieldTypeList.length!= undefined && clientCustActionForm.fieldTypeList.length!= null){
			for(var i=0; i <=clientCustActionForm.fieldTypeList.length;i++){
				if (clientCustActionForm.fieldTypeList[i]!= undefined){
					if(clientCustActionForm.fieldTypeList[i].value == "3"){
						var customFieldDate = document.getElementById("customField["+i+"].fieldValue");
						var customFieldDateFormat = document.getElementById("customField["+i+"].fieldValueFormat");
					 	var customFieldDateYY = document.getElementById("customField["+i+"].fieldValueYY");
						var dateValue = customFieldDate.value;
						if(!(validateMyForm(customFieldDate,customFieldDateFormat,customFieldDateYY)))
							return false;
					}
				}
		 	}
		 }
	  }

	  function chkForDateOfBirthDate(){
		 var statusIdValue = document.getElementById("status").value;
	  	 if (statusIdValue!=3){
	  	 	var dateOfBirth = document.getElementById("dateOfBirth");
	  	 	var dateOfBirthFormat = document.getElementById("dateOfBirthFormat");
	  	 	var dateOfBirthYY = document.getElementById("dateOfBirthYY");
			return (validateMyForm(dateOfBirth,dateOfBirthFormat,dateOfBirthYY));
	 	 }
	 	 else{
	 	 	return true;
	 	 }
	  }
	</script>
	<html-el:form action="clientCustAction.do?method=previewEditPersonalInfo"
			enctype="multipart/form-data" onsubmit="return chkForValidDates()">
			<c:set value="${session:getFromSession(sessionScope.flowManager,requestScope.currentFlowKey,'BusinessKey')}"
				   var="BusinessKey" />
			<html-el:hidden property="input" value="editPersonalInfo" />
			<html-el:hidden property="status" value="${BusinessKey.customerStatus.id}" />

			<%-- <td align="left" valign="top" bgcolor="#FFFFFF" class="paddingleftmain"> --%>
			<table width="95%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="bluetablehead05"><span class="fontnormal8pt"> <customtags:headerLink/> </span>
				</tr>
			</table>
			<%-- Start of information --%>
			<table width="95%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td align="left" valign="top" class="paddingL15T15">
					<table width="93%" border="0" cellpadding="3" cellspacing="0">
						<tr>
							<td class="headingorange"><span class="heading"><c:out
								value="${sessionScope.clientCustActionForm.clientName.displayName}" /> - </span><mifos:mifoslabel
								name="client.EditPersonalInformationLink"
								bundle="ClientUIResources"></mifos:mifoslabel></td>
						</tr>
						<tr>
							<td class="fontnormal"><mifos:mifoslabel
								name="client.PreviewEditInfoInstruction"
								bundle="ClientUIResources"></mifos:mifoslabel> <mifos:mifoslabel
								name="client.EditPageCancelInstruction1"
								bundle="ClientUIResources"></mifos:mifoslabel> <mifos:mifoslabel
								name="${ConfigurationConstants.CLIENT}"
								bundle="ClientUIResources"></mifos:mifoslabel> <mifos:mifoslabel
								name="client.EditPageCancelInstruction2"
								bundle="ClientUIResources"></mifos:mifoslabel> <span
								class="mandatorytext"><font color="#FF0000">*</font></span> <mifos:mifoslabel
								name="client.FieldInstruction" bundle="ClientUIResources"></mifos:mifoslabel>
							</td>
						</tr>
					</table>
					<br>
					<table width="93%" border="0" cellpadding="3" cellspacing="0">
						<font class="fontnormalRedBold"><html-el:errors
							bundle="ClientUIResources" /> </font>
						<tr>
							<td colspan="2" class="fontnormalbold"><mifos:mifoslabel
								name="client.PersonalInformationHeading"
								bundle="ClientUIResources"></mifos:mifoslabel><br>
							<br>
							</td>
						</tr>
						<%-- Salutation --%>
						<tr class="fontnormal">
							<td width="17%" align="right"><mifos:mifoslabel
								name="client.Salutation" mandatory="yes"
								bundle="ClientUIResources"></mifos:mifoslabel></td>
							<td width="83%">
								<mifos:select	name="clientCustActionForm"	property="clientName.salutation" size="1">
								<c:forEach var="salutationEntityList" items="${session:getFromSession(sessionScope.flowManager,requestScope.currentFlowKey,'salutationEntity')}" >
									<html-el:option value="${salutationEntityList.id}">${salutationEntityList.name}</html-el:option>
								</c:forEach>
								</mifos:select>
							</td>
						</tr>
						<%-- First Name --%>
						<tr class="fontnormal">
							<td align="right"><mifos:mifoslabel name="client.FirstName"
								mandatory="yes" bundle="ClientUIResources"></mifos:mifoslabel></td>
							<td><mifos:mifosalphanumtext name="clientCustActionForm" property="clientName.firstName" maxlength="200" /></td>
						</tr>
						<%-- Middle Name --%>
						<tr class="fontnormal">
							<td align="right"><mifos:mifoslabel keyhm="Client.MiddleName" name="client.MiddleName"
								bundle="ClientUIResources"></mifos:mifoslabel></td>
							<td><mifos:mifosalphanumtext keyhm="Client.MiddleName" name="clientCustActionForm"	property="clientName.middleName" maxlength="200" /></td>
						</tr>
						<%-- Second Last Name --%>
						<tr class="fontnormal">
							<td align="right"><mifos:mifoslabel keyhm="Client.SecondLastName" name="client.SecondLastName"
								isColonRequired="yes" bundle="ClientUIResources"></mifos:mifoslabel></td>
							<td><mifos:mifosalphanumtext keyhm="Client.SecondLastName" name="clientCustActionForm"
								 property="clientName.secondLastName" maxlength="200" />
							</td>
						</tr>
						<%-- Last Name --%>
						<tr class="fontnormal">
							<td align="right"><mifos:mifoslabel name="client.LastName"
								mandatory="yes" bundle="ClientUIResources"></mifos:mifoslabel></td>
							<td><mifos:mifosalphanumtext name="clientCustActionForm" property="clientName.lastName" maxlength="200" /></td>
						</tr>
						<html-el:hidden property="clientName.nameType" value="3" />

						<c:choose>

							<c:when test="${BusinessKey.customerStatus.id != CustomerStatus.CLIENT_ACTIVE.value}">
								<!-- If status is approved then display government id and date of birth as labels -->
								<%-- Government Id --%>
								<tr class="fontnormal">
									<td align="right">
									<mifos:mifoslabel	keyhm="Client.GovernmentId" name="${ConfigurationConstants.GOVERNMENT_ID}" isColonRequired="yes"/>
										</td>
									<td><mifos:mifosalphanumtext keyhm="Client.GovernmentId" name="clientCustActionForm"
										property="governmentId" maxlength="50" /></td>
								</tr>
								<%-- Date Of  Birth  --%>
								<tr class="fontnormal">
									<td align="right"><mifos:mifoslabel name="client.DateOfBirth"
										mandatory="yes" bundle="ClientUIResources"></mifos:mifoslabel></td>
									<td>
									<date:datetag property="dateOfBirth" /></td>
								</tr>
							</c:when>
							<c:otherwise>
								<%-- Government Id Label--%>
								<tr class="fontnormal">
									<td align="right"><mifos:mifoslabel keyhm="Client.GovernmentId" isColonRequired="yes"
										name="${ConfigurationConstants.GOVERNMENT_ID}"></mifos:mifoslabel></td>
									<td><c:out value="${BusinessKey.governmentId}" />
										<html-el:hidden	name="clientCustActionForm" property="governmentId"	value="${BusinessKey.governmentId}" /></td>
								</tr>
								<%-- Date Of  Birth Label--%>
								<tr class="fontnormal">
									<td align="right"><mifos:mifoslabel name="client.DateOfBirth"
										mandatory="yes" bundle="ClientUIResources"></mifos:mifoslabel></td>
									<td>
										<c:out value="${sessionScope.clientCustActionForm.dateOfBirth}" />
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
						<%-- Gender --%>
						<tr class="fontnormal">
							<td align="right"><mifos:mifoslabel name="client.Gender"
								mandatory="yes" bundle="ClientUIResources"></mifos:mifoslabel></td>
							<td>
								<mifos:select name="clientCustActionForm" property="clientDetailView.gender" size="1">
									<c:forEach var="genderEntityList" items="${session:getFromSession(sessionScope.flowManager,requestScope.currentFlowKey,'genderEntity')}" >
										<html-el:option value="${genderEntityList.id}">${genderEntityList.name}</html-el:option>
									</c:forEach>
								</mifos:select>
							</td>
						</tr>
						<%-- Marital Status --%>
						<tr class="fontnormal">
							<td align="right"><mifos:mifoslabel name="client.MaritalStatus"
								bundle="ClientUIResources"></mifos:mifoslabel></td>
							<td>
								<mifos:select name="clientCustActionForm" property="clientDetailView.maritalStatus" size="1">
									<c:forEach var="maritalStatusEntityList" items="${session:getFromSession(sessionScope.flowManager,requestScope.currentFlowKey,'maritalStatusEntity')}" >
										<html-el:option value="${maritalStatusEntityList.id}">${maritalStatusEntityList.name}</html-el:option>
									</c:forEach>
								</mifos:select>
							</td>
						</tr>
						<%-- Number Of Children--%>
						<tr class="fontnormal">
							<td align="right" class="fontnormal"><mifos:mifoslabel
								name="client.NumberOfChildren" bundle="ClientUIResources"></mifos:mifoslabel></td>
							<td><mifos:mifosnumbertext name="clientCustActionForm"	property="clientDetailView.numChildren" maxlength="5" size="10" /></td>
						</tr>
						<%-- Citizenship --%>
						<tr class="fontnormal">
							<td align="right"><mifos:mifoslabel keyhm="Client.Citizenship" isColonRequired="yes"
								name="${ConfigurationConstants.CITIZENSHIP}"></mifos:mifoslabel></td>
							<td><mifos:select keyhm="Client.Citizenship"
										name="clientCustActionForm"
										property="clientDetailView.citizenship" size="1">
										<c:forEach var="citizenshipEntityList" items="${session:getFromSession(sessionScope.flowManager,requestScope.currentFlowKey,'citizenshipEntity')}" >
											<html-el:option value="${citizenshipEntityList.id}">${citizenshipEntityList.name}</html-el:option>
										</c:forEach>
								</mifos:select></td>

						</tr>
						<%-- Ethinicity --%>
						<tr class="fontnormal">
							<td align="right"><mifos:mifoslabel keyhm="Client.Ethinicity"
								name="${ConfigurationConstants.ETHINICITY}" isColonRequired="yes"
								bundle="ClientUIResources"></mifos:mifoslabel></td>
							<td><mifos:select keyhm="Client.Ethinicity"
										name="clientCustActionForm"
										property="clientDetailView.ethinicity" size="1">
										<c:forEach var="ethinicityEntityList" items="${session:getFromSession(sessionScope.flowManager,requestScope.currentFlowKey,'ethinicityEntity')}" >
											<html-el:option value="${ethinicityEntityList.id}">${ethinicityEntityList.name}</html-el:option>
										</c:forEach>
								</mifos:select></td>

						</tr>
						<%-- Education Level --%>
						<tr class="fontnormal">
							<td align="right"><mifos:mifoslabel name="client.EducationLevel" keyhm="Client.EducationLevel"
								bundle="ClientUIResources"></mifos:mifoslabel></td>

							<td><mifos:select keyhm="Client.EducationLevel"
										name="clientCustActionForm"
										property="clientDetailView.educationLevel" size="1">
										<c:forEach var="educationLevelEntityList" items="${session:getFromSession(sessionScope.flowManager,requestScope.currentFlowKey,'educationLevelEntity')}" >
											<html-el:option value="${educationLevelEntityList.id}">${educationLevelEntityList.name}</html-el:option>
										</c:forEach>
									</mifos:select></td>
						</tr>
						<%-- Business Activities --%>
						<tr class="fontnormal">
							<td align="right"><mifos:mifoslabel keyhm="Client.BusinessActivities"
								name="client.BusinessActivities" bundle="ClientUIResources"></mifos:mifoslabel></td>
							<td><mifos:select name="clientCustActionForm" keyhm="Client.BusinessActivities"
										property="clientDetailView.businessActivities" size="1">
										<c:forEach var="businessActivitiesEntityList" items="${session:getFromSession(sessionScope.flowManager,requestScope.currentFlowKey,'businessActivitiesEntity')}" >
											<html-el:option value="${businessActivitiesEntityList.id}">${businessActivitiesEntityList.name}</html-el:option>
										</c:forEach>
									</mifos:select></td>
						</tr>
						<%-- Poverty Status --%>
						<tr class="fontnormal">
							<td align="right"><mifos:mifoslabel keyhm="Client.PovertyStatus"
								name="client.PovertyStatus" bundle="ClientUIResources"></mifos:mifoslabel></td>
							<td><mifos:select name="clientCustActionForm" keyhm="Client.PovertyStatus"
										property="clientDetailView.povertyStatus" size="1">
										<c:forEach var="povertyStatus" items="${session:getFromSession(sessionScope.flowManager,requestScope.currentFlowKey,'povertyStatus')}" >
											<html-el:option value="${povertyStatus.id}">${povertyStatus.name}</html-el:option>
										</c:forEach>
									</mifos:select></td>
						</tr>
						<%-- Handicapped --%>
						<tr class="fontnormal">
							<td align="right"><mifos:mifoslabel keyhm="Client.Handicapped" isColonRequired="yes"
								name="${ConfigurationConstants.HANDICAPPED}"
								bundle="ClientUIResources"></mifos:mifoslabel></td>
							<td><mifos:select keyhm="Client.Handicapped"
										name="clientCustActionForm"
										property="clientDetailView.handicapped" size="1">
										<c:forEach var="handicappedEntityList" items="${session:getFromSession(sessionScope.flowManager,requestScope.currentFlowKey,'handicappedEntity')}" >
											<html-el:option value="${handicappedEntityList.id}">${handicappedEntityList.name}</html-el:option>
										</c:forEach>
								</mifos:select>
							</td>
						</tr>

						<%-- Photograph ADD CUSTOMER PICTURE TO ACTION FORM AND CUSTOMER VO --%>
						<tr class="fontnormal">
							<td align="right"><mifos:mifoslabel keyhm="Client.Photo" name="client.Photograph"
								bundle="ClientUIResources"></mifos:mifoslabel></td>
							<td><mifos:file keyhm="Client.Photo" property="picture" maxlength="200"
								onkeypress="return onKeyPressForFileComponent(this);" /></td>
						</tr>
						<%-- Spouse/Father details --%>
						<tr class="fontnormal">
							<td align="right" class="fontnormal"><mifos:mifoslabel
								name="client.SpouseFatherName" mandatory="yes"
								bundle="ClientUIResources"></mifos:mifoslabel></td>
							<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr class="fontnormal">
								  <td width="14%"><mifos:mifoslabel name="client.Relationship" bundle="ClientUIResources"></mifos:mifoslabel>
									<mifos:select	style="width:80px;" name="clientCustActionForm"
										property="spouseName.nameType" size="1">
										<c:forEach var="spouseEntityList" items="${session:getFromSession(sessionScope.flowManager,requestScope.currentFlowKey,'spouseEntity')}" >
											<html-el:option value="${spouseEntityList.id}">${spouseEntityList.name}</html-el:option>
										</c:forEach>
									</mifos:select>
								   </td>
								   <td class="paddingL10">
										<table border="0" cellspacing="0" cellpadding="0">
											<tr class="fontnormal">
												<td class="paddingL10">
													<mifos:mifoslabel name="client.SpouseFirstName" mandatory="yes"
														bundle="ClientUIResources">
													</mifos:mifoslabel>
												</td>
											</tr>
											<tr class="fontnormal">
												<td class="paddingL10">
													<mifos:mifosalphanumtext property="spouseName.firstName" maxlength="200"	style="width:100px;" />
												</td>
											</tr>
										</table>
									<td class="paddingL10">
										<table border="0" cellspacing="0" cellpadding="0">
											<tr class="fontnormal">
												<td class="paddingL10">
													<mifos:mifoslabel keyhm="Client.SpouseFatherMiddleName" name="client.SpouseMiddleName" bundle="ClientUIResources">
													</mifos:mifoslabel>
												</td>
											</tr>
											<tr class="fontnormal">
												<td class="paddingL10">
												  <mifos:mifosalphanumtext keyhm="Client.SpouseFatherMiddleName" property="spouseName.middleName" maxlength="200" style="width:100px;" />
												</td>
											</tr>
										</table>
									</td>
									<td class="paddingL10">
										<table border="0" cellspacing="0" cellpadding="0">
											<tr class="fontnormal">
												<td class="paddingL10">
													<mifos:mifoslabel keyhm="Client.SpouseFatherSecondLastName"
														name="client.SpouseSecondLastName" bundle="ClientUIResources">
													</mifos:mifoslabel>
												</td>
											</tr>
											<tr class="fontnormal">
												<td class="paddingL10">
													<mifos:mifosalphanumtext keyhm="Client.SpouseFatherSecondLastName"
																property="spouseName.secondLastName"
																	maxlength="200" style="width:100px;" />
												</td>
											</tr>
										</table>
									</td>
									<td class="paddingL10">
										<table border="0" cellspacing="0" cellpadding="0">
											<tr class="fontnormal">
												<td class="paddingL10">
													<mifos:mifoslabel name="client.SpouseLastName"
													   mandatory="yes"	bundle="ClientUIResources">
													   </mifos:mifoslabel>
												</td>
											</tr>
											<tr class="fontnormal">
												<td class="paddingL10">
												   <mifos:mifosalphanumtext property="spouseName.lastName" maxlength="200"
																style="width:100px;" />
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>

					<br>
					<!-- Address Fields -->
					<table width="95%" border="0" cellpadding="3" cellspacing="0">
						<tr>
							<td colspan="2" class="fontnormalbold"><mifos:mifoslabel
								name="client.AddressHeading"  keyhm="Client.Address" isManadatoryIndicationNotRequired="yes" bundle="ClientUIResources"></mifos:mifoslabel><br>
							<br>
							</td>
						</tr>
						<tr class="fontnormal">
							<td width="17%" align="right"><mifos:mifoslabel keyhm="Client.Address1" isColonRequired="yes"
								name="${ConfigurationConstants.ADDRESS1}"></mifos:mifoslabel></td>
							<td width="83%"><mifos:mifosalphanumtext keyhm="Client.Address1"
								name="clientCustActionForm"
								property="address.line1"
								maxlength="200" /></td>
						</tr>
						<tr class="fontnormal">
							<td align="right"><mifos:mifoslabel keyhm="Client.Address2" isColonRequired="yes"
								name="${ConfigurationConstants.ADDRESS2}"></mifos:mifoslabel></td>
							<td><mifos:mifosalphanumtext keyhm="Client.Address2" name="clientCustActionForm"
								property="address.line2"
								maxlength="200" /></td>
						</tr>
						<tr class="fontnormal">
							<td align="right"><mifos:mifoslabel keyhm="Client.Address3" isColonRequired="yes"
								name="${ConfigurationConstants.ADDRESS3}"></mifos:mifoslabel></td>
							<td><mifos:mifosalphanumtext keyhm="Client.Address3" name="clientCustActionForm"
								property="address.line3"
								maxlength="200" /></td>
						</tr>
						<tr class="fontnormal">
							<td align="right"><mifos:mifoslabel keyhm="Client.City" isColonRequired="yes"
								name="${ConfigurationConstants.CITY}"></mifos:mifoslabel></td>
							<td><mifos:mifosalphanumtext keyhm="Client.City" name="clientCustActionForm"
								property="address.city"
								maxlength="100" /></td>
						</tr>
						<tr class="fontnormal">
							<td align="right"><mifos:mifoslabel keyhm="Client.State" isColonRequired="yes"
								name="${ConfigurationConstants.STATE}"></mifos:mifoslabel></td>
							<td><mifos:mifosalphanumtext  keyhm="Client.State" name="clientCustActionForm"
								property="address.state"
								maxlength="100" /></td>
						</tr>
						<tr class="fontnormal">
							<td align="right"><mifos:mifoslabel keyhm="Client.Country" name="client.Country"
								bundle="ClientUIResources"></mifos:mifoslabel></td>
							<td><mifos:mifosalphanumtext keyhm="Client.Country" name="clientCustActionForm"
								property="address.country"
								maxlength="100" /></td>
						</tr>
						<tr class="fontnormal">
							<td align="right"><mifos:mifoslabel keyhm="Client.PostalCode" isColonRequired="yes"
								name="${ConfigurationConstants.POSTAL_CODE}"></mifos:mifoslabel></td>
							<td><mifos:mifosalphanumtext keyhm="Client.PostalCode" name="clientCustActionForm"
								property="address.zip"
								maxlength="20" /></td>
						</tr>
						<tr class="fontnormal">
							<td align="right"><mifos:mifoslabel keyhm="Client.PhoneNumber" name="client.Telephone"
								bundle="ClientUIResources"></mifos:mifoslabel></td>
							<td><mifos:mifosalphanumtext keyhm="Client.PhoneNumber" name="clientCustActionForm"
								property="address.phoneNumber"
								maxlength="20" /></td>
						</tr>
					</table>
					<br>
					<!-- Custom Fields -->
					<table width="93%" border="0" cellpadding="3" cellspacing="0">
						<tr>
							<td colspan="2" class="fontnormalbold"><mifos:mifoslabel
								name="client.AdditionalInformationHeading"
								bundle="ClientUIResources"></mifos:mifoslabel><br>
							<br>
							</td>
						</tr>

						<!-- For each custom field definition in the list custom field entity is passed as key to mifos label -->




						<c:forEach var="customFieldDef"
							items="${session:getFromSession(sessionScope.flowManager,requestScope.currentFlowKey,'customFields')}" varStatus="loopStatus">
							<bean:define id="ctr">
								<c:out value="${loopStatus.index}" />
							</bean:define>
							<c:forEach var="cf"
								items="${sessionScope.clientCustActionForm.customFields}">
								<c:if test="${customFieldDef.fieldId==cf.fieldId}">
									<tr class="fontnormal">
										<td width="17%" align="right"><mifos:mifoslabel
											name="${customFieldDef.lookUpEntity.entityType}"
											mandatory="${customFieldDef.mandatoryStringValue}"
											bundle="ClientUIResources"></mifos:mifoslabel>:</td>
										<td width="83%"><c:if test="${customFieldDef.fieldType == CustomFieldType.NUMERIC.value}">
											<mifos:mifosnumbertext name="clientCustActionForm"
												property='customField[${ctr}].fieldValue' value="${cf.fieldValue}" maxlength="200" />
										</c:if> <c:if test="${customFieldDef.fieldType == CustomFieldType.ALPHA_NUMERIC.value}">
											<mifos:mifosalphanumtext name="clientCustActionForm"
												property='customField[${ctr}].fieldValue' value="${cf.fieldValue}" maxlength="200" />
										</c:if> <c:if test="${customFieldDef.fieldType == CustomFieldType.DATE.value}">
											<date:datetag property="customField[${ctr}].fieldValue"	/>

										</c:if>
										<html-el:hidden property='customField[${ctr}].fieldId'	value="${cf.fieldId}"></html-el:hidden>
										<html-el:hidden	property='fieldTypeList' value='${customFieldDef.fieldType}' />
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</c:forEach>

					</table>

					<!--Custom Fields end  -->
					<table width="93%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td align="center" class="blueline">&nbsp;</td>
						</tr>
					</table>
					<br>
					<table width="93%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td align="center"><html-el:submit styleClass="buttn"
								style="width:70px;">
								<mifos:mifoslabel name="button.preview"
									bundle="ClientUIResources"></mifos:mifoslabel>
							</html-el:submit> &nbsp; &nbsp; <html-el:button
								onclick="goToCancelPage();" property="cancelButton"
								styleClass="cancelbuttn" style="width:70px">
								<mifos:mifoslabel name="button.cancel"
									bundle="ClientUIResources"></mifos:mifoslabel>
							</html-el:button></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			<br>
			<td></td>
			<tr></tr>
			<table></table>
			<html-el:hidden property="currentFlowKey" value="${requestScope.currentFlowKey}" />
		</html-el:form>
	</tiles:put>
</tiles:insert>
