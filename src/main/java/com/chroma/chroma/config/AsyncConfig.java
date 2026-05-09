package com.chroma.chroma.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.concurrent.Executor;

/**
 * Enables Spring @Async and defines a dedicated thread pool for email sending.
 *
 * Thread pool config:
 *   corePoolSize  = 2  → 2 threads always alive and ready
 *   maxPoolSize   = 5  → burst up to 5 threads under heavy load
 *   queueCapacity = 50 → queue up to 50 email tasks before rejecting
 *   threadNamePrefix → makes threads visible in logs as "email-thread-N"
 */
@Configuration
@EnableAsync
public class AsyncConfig {

    @Bean(name = "emailExecutor")
    public Executor emailExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(2);
        executor.setMaxPoolSize(5);
        executor.setQueueCapacity(50);
        executor.setThreadNamePrefix("email-thread-");
        executor.setWaitForTasksToCompleteOnShutdown(true);
        executor.setAwaitTerminationSeconds(30);
        executor.initialize();
        return executor;
    }
}
