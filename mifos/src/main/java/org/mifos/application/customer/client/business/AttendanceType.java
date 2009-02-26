package org.mifos.application.customer.client.business;

/*
 * Encapsulates valid id values for {@link CustomerAttendanceType} class.
 */
public enum AttendanceType {

	PRESENT(1),
	ABSENT(2),
	APPROVED_LEAVE(3),
	LATE(4);
	
	private short value;
	
	private AttendanceType(int value) {
		this.value = (short)value;
	}
	
	public short getValue() {
		return value;
	}

	public static AttendanceType fromShort(short target) {
		for (AttendanceType candidate : values()) {
			if (candidate.getValue() == target) {
				return candidate;
			}
		}
		throw new RuntimeException("no attendance type " + target);
	}
	
}
