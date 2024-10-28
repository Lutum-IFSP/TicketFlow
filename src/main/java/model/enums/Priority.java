package model.enums;

public enum Priority {
    UNDEFINED(0),
    LOW(1),
    MID(2),
    HIGH(3);

    public int value;

    Priority(int value) {
        this.value = value;
    }
}
