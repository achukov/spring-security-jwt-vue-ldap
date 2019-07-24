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

    /**
     *
     * Configure the process engine, the most important of the activiti is the process engine, here is the injection of dataSource
     * The configuration of StandaloneInMemProcessEngineConfiguration, this is the process engine configuration of the In Memory of the H2 database.
     * SpringProcessEngineConfiguration is integrated with Spring's process engine configuration, of course, you can use MYSQL
     *
     * @param springAsyncExecutor Synchronous execution
     * @return SpringProcessEngineConfiguration
     * @throws IOException io error
     */
//    @Bean
//    public SpringProcessEngineConfiguration springProcessEngineConfiguration(SpringAsyncExecutor springAsyncExecutor)
//            throws IOException {
//        return baseSpringProcessEngineConfiguration(dataSource, platformTransactionManager, springAsyncExecutor);
//    }

    /**
     * The second way is to configure the database construction rules here.
     * @param springAsyncExecutor Synchronous execution
     * @return SpringProcessEngineConfiguration
     * @throws IOException  io error
     */
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
