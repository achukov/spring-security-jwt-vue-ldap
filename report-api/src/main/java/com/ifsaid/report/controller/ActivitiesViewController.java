package com.ifsaid.report.controller;

import com.ifsaid.report.service.IActivitiesViewService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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
    @GetMapping
    public void checkNowProcessActivitiesByLdpId(@RequestParam(name = "LdpId") String LdpId,
                                                       HttpServletResponse response) {
        try (InputStream stream = activitiesViewService.checkNowProcessActivitiesById(LdpId);
             ServletOutputStream outputStream = response.getOutputStream()) {
            BufferedImage image = ImageIO.read(stream);
            ImageIO.write(image, "PNG", outputStream);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
