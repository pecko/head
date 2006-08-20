package org.mifos.application.office.struts.actionforms;

import java.util.ArrayList;
import java.util.List;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.Globals;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.mifos.application.customer.business.CustomFieldDefinitionEntity;
import org.mifos.application.customer.business.CustomFieldView;
import org.mifos.application.customer.util.helpers.CustomerConstants;
import org.mifos.application.office.util.resources.OfficeConstants;
import org.mifos.application.util.helpers.Methods;
import org.mifos.framework.business.util.Address;
import org.mifos.framework.security.util.UserContext;
import org.mifos.framework.struts.actionforms.BaseActionForm;
import org.mifos.framework.util.helpers.Constants;
import org.mifos.framework.util.helpers.SessionUtils;
import org.mifos.framework.util.helpers.StringUtils;

public class OffActionForm extends BaseActionForm {
	ResourceBundle resourceBundle =null;
	
	private String officeId;

	private String officeName;

	private String shortName;

	private String officeLevel;

	private String parentOfficeId;

	private String officeStatus;

	private Address address;

	private List<CustomFieldView> customFields;

	public OffActionForm() {
		this.customFields = new ArrayList<CustomFieldView>();
		this.address = new Address();

	}

	public List<CustomFieldView> getCustomFields() {
		return customFields;
	}

	public void setCustomFields(List<CustomFieldView> customFields) {
		this.customFields = customFields;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public String getOfficeId() {
		return officeId;
	}

	public void setOfficeId(String officeId) {
		this.officeId = officeId;
	}

	public String getOfficeLevel() {
		return officeLevel;
	}

	public void setOfficeLevel(String officeLevel) {
		this.officeLevel = officeLevel;
	}

	public String getOfficeName() {
		return officeName;
	}

	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}

	public String getOfficeStatus() {
		return officeStatus;
	}

	public void setOfficeStatus(String officeStatus) {
		this.officeStatus = officeStatus;
	}

	public String getParentOfficeId() {
		return parentOfficeId;
	}

	public void setParentOfficeId(String parentOfficeId) {
		this.parentOfficeId = parentOfficeId;
	}

	public String getShortName() {
		return shortName;
	}

	public void setShortName(String shortName) {
		this.shortName = shortName;
	}

	public CustomFieldView getCustomField(int i) {
		while (i >= customFields.size()) {
			customFields.add(new CustomFieldView());
		}
		return (CustomFieldView) (customFields.get(i));
	}

	public void clear() {
		this.officeId = "";
		this.officeLevel = "";
		this.officeName = "";
		this.officeStatus = "";
		this.shortName="";
		this.parentOfficeId = "";
		this.customFields = new ArrayList<CustomFieldView>();
		this.address = new Address();

	}

	private void verifyFields(ActionErrors actionErrors, UserContext userContext) {
		if (StringUtils.isNullOrEmpty(officeName))
			actionErrors.add(OfficeConstants.OFFICE_NAME,
					new ActionMessage(OfficeConstants.ERRORMANDATORYFIELD,
							getLocaleString(OfficeConstants.OFFICE_NAME,
									userContext)));
		if (StringUtils.isNullOrEmpty(shortName))
			actionErrors.add(OfficeConstants.OFFICESHORTNAME,
					new ActionMessage(OfficeConstants.ERRORMANDATORYFIELD,
							getLocaleString(OfficeConstants.OFFICESHORTNAME,
									userContext)));
		if (StringUtils.isNullOrEmpty(officeLevel))
			actionErrors.add(OfficeConstants.OFFICELEVEL,
					new ActionMessage(OfficeConstants.ERRORMANDATORYFIELD,
							getLocaleString(OfficeConstants.OFFICELEVEL,
									userContext)));
		if (StringUtils.isNullOrEmpty(parentOfficeId))
			actionErrors.add(OfficeConstants.PARENTOFFICE,
					new ActionMessage(OfficeConstants.ERRORMANDATORYFIELD,
							getLocaleString(OfficeConstants.PARENTOFFICE,
									userContext)));
	}

	private String getLocaleString(String key, UserContext userContext) {

		if( resourceBundle ==null)
		try{
			
			
			resourceBundle= ResourceBundle.getBundle(OfficeConstants.OFFICERESOURCEPATH, userContext
						.getPereferedLocale());
		}catch (MissingResourceException e) {
			
			resourceBundle =ResourceBundle.getBundle(OfficeConstants.OFFICERESOURCEPATH);
			
		}
		return resourceBundle.getString(key);

	}

	protected UserContext getUserContext(HttpServletRequest request) {
		return (UserContext) SessionUtils.getAttribute(
				Constants.USER_CONTEXT_KEY, request.getSession());
	}

	protected void validateCustomFields(HttpServletRequest request,
			ActionErrors errors) {
		List<CustomFieldDefinitionEntity> customFieldDefs = (List<CustomFieldDefinitionEntity>) SessionUtils
				.getAttribute(CustomerConstants.CUSTOM_FIELDS_LIST, request
						.getSession());
		for (CustomFieldView customField : customFields) {
			for (CustomFieldDefinitionEntity customFieldDef : customFieldDefs) {
				if (customField.getFieldId()
						.equals(customFieldDef.getFieldId())
						&& customFieldDef.isMandatory()) {
					if (StringUtils.isNullOrEmpty(customField.getFieldValue()))
						errors
								.add(
										CustomerConstants.CUSTOM_FIELD,
										new ActionMessage(
												OfficeConstants.ENTERADDTIONALINFO));
				}
			}
		}
	}

	@Override
	public ActionErrors validate(ActionMapping mapping,
			HttpServletRequest request) {
		ActionErrors errors = new ActionErrors();
		String method = request.getParameter("method");
		if (method.equals(Methods.preview.toString())) {
			verifyFields(errors, getUserContext(request));
			validateCustomFields(request, errors);
			errors.add(super.validate(mapping, request));
		}
		if (null != errors && !errors.isEmpty()) {
			request.setAttribute(Globals.ERROR_KEY, errors);
			request.setAttribute("methodCalled", method);
		}

		return errors;

	}

}
