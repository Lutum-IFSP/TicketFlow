package model.services;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import org.apache.commons.io.FileUtils;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import jakarta.servlet.http.Part;

public class ImageService {
    private Cloudinary cloudinary;

    public ImageService(Cloudinary cloudinary) {
        super();
        this.cloudinary = cloudinary;
    }

    @SuppressWarnings("rawtypes")
    public String uploadPart(Part part, String filename) {
        String url = "image/user.png";
        try {
            if (!part.getSubmittedFileName().isEmpty()) {
                File image = new File(filename + "_" + part.getSubmittedFileName());
                FileUtils.copyInputStreamToFile(part.getInputStream(), image);
                Map upload = cloudinary.uploader().upload(image, ObjectUtils.asMap("use_filename", true));
                url = (String) upload.get("url");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return url;
    }
}
