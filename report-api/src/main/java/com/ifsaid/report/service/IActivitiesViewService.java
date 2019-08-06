package com.ifsaid.report.service;

import java.io.InputStream;

public interface IActivitiesViewService {
    InputStream checkNowProcessActivitiesById(String Id, String uname);
}
