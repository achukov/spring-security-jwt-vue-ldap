// package com.ifsaid.report.controller;

// import com.ifsaid.report.vo.Result;
// import lombok.extern.slf4j.Slf4j;
// import net.coobird.thumbnailator.Thumbnails;
// import net.coobird.thumbnailator.geometry.Positions;
// import org.apache.commons.lang3.StringUtils;
// import org.springframework.core.io.ClassPathResource;
// import org.springframework.web.bind.annotation.*;
// import org.springframework.web.multipart.MultipartFile;

// import javax.imageio.ImageIO;
// import java.io.File;
// import java.io.FileInputStream;
// import java.io.IOException;
// import java.io.InputStream;
// import java.util.HashMap;
// import java.util.Map;

// @Slf4j
// @RestController
// @RequestMapping("/upload")
// public class UploadController {

//     @PostMapping("/image")
//     public Result uploadImages(MultipartFile file) throws IOException {
//         if (file.isEmpty() || StringUtils.isEmpty(file.getOriginalFilename())) {
//             Result.error500("Image cannot be empty", null);
//         }
//         String contentType = file.getContentType();
//         if (!contentType.contains("")) {
//             Result.error500("Image format cannot be empty", null);
//         }
//         String originalFileName = file.getOriginalFilename();
//         String suffix = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
//         // Determine if the format of the image is correct
//         if (suffix.toUpperCase().equals("BMP") || suffix.toUpperCase().equals("JPG")
//                 || suffix.toUpperCase().equals("JPEG") || suffix.toUpperCase().equals("PNG")
//                 || suffix.toUpperCase().equals("GIF")) {
//             Map<String, String> map = uploadFile(file, 500, 500);
//             return Result.success(map);
//         }
//         return Result.error500("The image format is incorrect. You can only upload one of [BMP, JPG, JPEG, PNG, GIF]", null);
//     }

//     @DeleteMapping("/delete")
//     public Result deleteImages(@RequestBody Map<String, String> map) throws IOException {
//         String url = map.get("url");
//         log.info("deleteImages url: {}", url);
//         if (url != null && url.trim() != "") {
//             AliyunOssUtil.deleteFile(url);
//         }
//         return Result.success();
//     }

//     @PostMapping("/avatar")
//     public Result uploadAvatar(MultipartFile file) throws IOException {
//         if (file.isEmpty() || StringUtils.isEmpty(file.getOriginalFilename())) {
//             Result.error500("The avatar cannot be empty", null);
//         }
//         String contentType = file.getContentType();
//         if (!contentType.contains("")) {
//             Result.error500("The avatar format cannot be empty", null);
//         }
//         String originalFileName = file.getOriginalFilename();
//         String suffix = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
//         if (suffix.toUpperCase().equals("BMP") || suffix.toUpperCase().equals("JPG")
//                 || suffix.toUpperCase().equals("JPEG") || suffix.toUpperCase().equals("PNG")
//                 || suffix.toUpperCase().equals("GIF")) {
//             Map<String, String> map = uploadFile(file, 200, 200);
//             return Result.success(map);
//         }
//         return Result.error500("The avatar format is incorrect. You can only upload one of [BMP, JPG, JPEG, PNG, GIF]", null);
//     }

//     public Map<String, String> uploadFile(MultipartFile file, int width, int height) throws IOException {
//         // Get an empty file
//         File nullFile = makeParentFolder(file.getOriginalFilename());
//         // Because it is a jar package after spring boot packaging, you need to use ClassPathResource to get the watermark image under the classpath.
//         InputStream watermark = new ClassPathResource("images/watermark.png").getInputStream();
//         // After the image is compressed, it is read into an empty file.
//         Thumbnails.of(file.getInputStream())
//                 .watermark(Positions.BOTTOM_RIGHT, ImageIO.read(watermark), 0.5f)
//                 .outputQuality(0.8f)
//                 .size(width, height).toFile(nullFile);
//         String url = AliyunOssUtil.putObject(new FileInputStream(nullFile), file.getContentType(), AliyunOssUtil.createFolder() + nullFile.getName());
//         Map<String, String> result = new HashMap<>(2);
//         result.put("url", url);
//         result.put("fileName", nullFile.getName());
//         log.info("uploadFile( {} , {} , {} , {} );", file.getOriginalFilename(), file.getSize(), file.getContentType(), nullFile.getName(), url);
//         nullFile.delete();
//         return result;
//     }

//     private File makeParentFolder(String fileName) {
//         String uuidFileName = AliyunOssUtil.createFileName(fileName);
//         StringBuilder sb = new StringBuilder(System.getProperties().getProperty("user.home"));
//         sb.append("/imagesCache/").append(uuidFileName);
//         log.info("Generate cache file address is:  {}", sb.toString());
//         File originalFile = new File(sb.toString());
//         if (!originalFile.getParentFile().exists()) {
//             originalFile.getParentFile().mkdir();
//         }
//         return originalFile;
//     }


// }
