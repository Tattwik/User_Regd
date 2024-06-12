package tech.csm.util;

import java.io.FileOutputStream;
import java.io.InputStream;

import org.springframework.web.multipart.MultipartFile;

public class FileUploadUtil {

	public static String uploadFile(MultipartFile file) {
		try {
			InputStream is = file.getInputStream();
			byte[] data = is.readAllBytes();
			FileOutputStream fos = new FileOutputStream("D:\\file_server\\" + file.getOriginalFilename());
		    fos.write(data);
		    is.close();
		    fos.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return file.getOriginalFilename();
	}
}
