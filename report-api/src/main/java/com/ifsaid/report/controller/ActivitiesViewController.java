package com.ifsaid.report.controller;

import com.ifsaid.report.service.IActivitiesViewService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.InputStream;

@Api(tags = "All Activities")
@RestController
@RequestMapping(value = "/activitiesView")
public class ActivitiesViewController {

    private final IActivitiesViewService activitiesViewService;

    @Autowired
    public ActivitiesViewController(IActivitiesViewService activitiesViewService) {
        this.activitiesViewService = activitiesViewService;
    }
    @GetMapping("/info/{id}/{uname}")
    public void checkNowProcessActivitiesById(@PathVariable String id, @PathVariable String uname,
                                                       HttpServletResponse response) {
        response.setContentType("image/png");
        try (InputStream stream = activitiesViewService.checkNowProcessActivitiesById(id, uname);
             ServletOutputStream outputStream = response.getOutputStream()) {
            BufferedImage image = ImageIO.read(stream);
            ImageIO.write(image, "PNG", outputStream);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
