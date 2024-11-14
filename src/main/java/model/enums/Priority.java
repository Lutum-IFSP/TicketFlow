package model.enums;

public enum Priority {
    UNDEFINED(0),
    LOW(1),
    MID(2),
    HIGH(3);

    public int value;

    public static Priority convert(int priority) {

        switch (priority) {
            case 0:
                return Priority.UNDEFINED;

            case 1:
                return Priority.LOW;

            case 2:
                return Priority.MID;

            case 3:
                return Priority.HIGH;
        
            default:
                return Priority.UNDEFINED;
        }
    }

    Priority(int value) {
        this.value = value;
    }
}
