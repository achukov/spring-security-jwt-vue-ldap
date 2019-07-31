package com.ifsaid.report.common.activiti;

import org.activiti.engine.ProcessEngineConfiguration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.PlatformTransactionManager;
import org.activiti.spring.SpringAsyncExecutor;
import org.activiti.spring.SpringProcessEngineConfiguration;
import org.activiti.spring.boot.AbstractProcessEngineAutoConfiguration;

import javax.sql.DataSource;
import java.io.IOException;

@Configuration
public class ActivitiConfiguration extends AbstractProcessEngineAutoConfiguration {

    private final DataSource dataSource;
    private final PlatformTransactionManager platformTransactionManager;

    /**
     * Inject data source and transaction template
     *
     * @param dataSource                 data source
     * @param platformTransactionManager Transaction template
     */
    @Autowired
    public ActivitiConfiguration(DataSource dataSource, PlatformTransactionManager platformTransactionManager) {
        this.dataSource = dataSource;
        this.platformTransactionManager = platformTransactionManager;
    }

    @Bean
	public SpringProcessEngineConfiguration springProcessEngineConfiguration(SpringAsyncExecutor springAsyncExecutor)
            throws IOException {
		SpringProcessEngineConfiguration configuration = baseSpringProcessEngineConfiguration(dataSource,
				platformTransactionManager, springAsyncExecutor);
                configuration.setMailServerHost("relay.batgen.com");
                configuration.setMailServerPort(25);
                configuration.setMailServerDefaultFrom("do_not_replay@bat.com");
				configuration.setDatabaseSchemaUpdate(ProcessEngineConfiguration.DB_SCHEMA_UPDATE_TRUE);
				return configuration;
				}
}
