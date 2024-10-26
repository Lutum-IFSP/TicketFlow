package model.auth;

import at.favre.lib.crypto.bcrypt.BCrypt;

public class Encryptor {
    public static boolean verifyPassword(String password, String hash) {
        return BCrypt.verifyer().verify(password.toCharArray(), hash.toCharArray()).verified;
    }

    public static String encrypt(String password) {
        return BCrypt.withDefaults().hashToString(14, password.toCharArray());
    }
}
