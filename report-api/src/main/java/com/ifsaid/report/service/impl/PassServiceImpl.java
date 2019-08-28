package com.ifsaid.report.service.impl;

import java.util.List;

import javax.servlet.ServletContext;

import com.ifsaid.report.common.exception.JpaCrudException;
import com.ifsaid.report.common.service.impl.BaseServiceImpl;
import com.ifsaid.report.common.utils.EmailSender;
import com.ifsaid.report.common.utils.SecurityUtils;
import com.ifsaid.report.entity.Pass;
import com.ifsaid.report.entity.User;
import com.ifsaid.report.repository.PassRepository;
import com.ifsaid.report.service.IPassService;
import com.ifsaid.report.service.IUserService;
import com.ifsaid.report.vo.MyPage;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import com.ifsaid.report.common.jwt.JwtTokenProvider;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PassServiceImpl extends BaseServiceImpl<Pass, Long, PassRepository> implements IPassService {

    private final ServletContext servletContext;

    private final EmailSender emailSender;

    private final IUserService userService;

    private final JwtTokenProvider jwtTokenUtil;

    public PassServiceImpl(ServletContext servletContext, EmailSender emailSender, IUserService userService, JwtTokenProvider jwtTokenUtil) {
        this.servletContext = servletContext;
        this.emailSender = emailSender;
        this.userService = userService;
        this.jwtTokenUtil = jwtTokenUtil;
    }

    @Override
    public Pass findById(Long aLong) {
        return super.findById(aLong);
    }

    @Override
    public Pass save(Pass entity) throws JpaCrudException {
        entity.setCreatedBy(SecurityUtils.getCurrentMail());

        List<User> approvers = userService.findByDept(13);
    
        log.info("approvers{} ", approvers);
        String[] to = new String[approvers.size()];
        for (int i = 0; i < approvers.size(); i++) {
            to[i] = approvers.get(i).getMail();
        }

        super.save(entity);

            emailSender.htmlEmailManyTo(
                servletContext,
                // user name
                null,
                // to
                to,
                // subject
                "New Pass Approval №: " + entity.getPsid() + " for your approval",
                //  msg
                "Please click this <a href=\"http://ruits/pass/index/" + entity.getPsid() + " \">link</a> for further details."
                + " Thank you."
                );
        return entity;
        
    } 

    @Override
    public Pass update(Pass entity) throws JpaCrudException {
        entity.setUpdatedBy(SecurityUtils.getCurrentMail());

        if( entity.getState() == 2 ){
            emailSender.htmlEmail(
                servletContext,
                // user name
                entity.getCreatedBy().toString(),
                // to
                entity.getCreatedBy().toString(),
                // subject
                "Pass Approval number: " + entity.getPsid() + " was approved.",
                //  msg
                "Please click this <a href=\"http://ruits/pass/index/\">link</a> for further details."
                + " Thank you."
            );
        } else if ( entity.getState() == 3 ) {
            emailSender.htmlEmail(
                servletContext,
                // user name
                null,
                // to
                entity.getCreatedBy().toString(),
                // subject
                "Pass Approval number: " + entity.getPsid() + " was rejected."
                + " History Log: " + entity.getHistoryLog(),
                //  msg
                "Please click this <a href=\"http://ruits/pass/index/\">link</a> for further details."
                + " Thank you."
            );

        } else {
            // TODO доделать уведомления
        }

        return super.update(entity);
    }

    @Override
    public void deleteById(Long aLong) throws JpaCrudException {
        super.deleteById(aLong);
    }

    @Override
    public Page<Pass> findAll(MyPage page) {
        PageRequest pageRequest = PageRequest.of(page.getPage() - 1, page.getSize(), Sort.by(Sort.Direction.DESC, "upTime"));
        Page<Pass> all = null;
        if (page.getCid() != null && page.getCid() > 0) {
            all = baseRepository.findAllByCategoryId(pageRequest, page.getCid());
        } else if (page.getSearch() != null && StringUtils.isNotEmpty(page.getSearch())) {
            all = baseRepository.findAllBySearch(pageRequest, page.getSearch());
        } else {
            all = baseRepository.findAll(pageRequest);
        }
        return all;
    }

    @Override
    public Page<Pass> findAllbyAuthor(MyPage page, String token) {
        final String authToken = token.substring(this.jwtTokenUtil.getTokenHead().length());
        String username = jwtTokenUtil.getMailFromToken(authToken);

        PageRequest pageRequest = PageRequest.of(page.getPage() - 1, page.getSize(), Sort.by(Sort.Direction.DESC, "upTime"));
        Page<Pass> all = null;

        if (page.getSearch() != null && StringUtils.isNotEmpty(page.getSearch())) {
            all = baseRepository.findAllByAuthorAndSearch(pageRequest, page.getSearch(), username);
        } else {
            all = baseRepository.findAllbyAuthor(pageRequest, username);
        }
        return all;
    }

}
