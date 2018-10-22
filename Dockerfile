FROM openjdk:8-jdk-alpine
 
RUN wget https://www-us.apache.org/dist//jmeter/binaries/apache-jmeter-5.0.tgz
RUN tar -xvzf apache-jmeter-5.0.tgz
RUN rm apache-jmeter-5.0.tgz

RUN mv apache-jmeter-5.0 /jmeter

# Copy all our jmeter scripts to the local scripts directory
COPY /scripts /scripts

ENV JMETER_HOME /jmeter

# Add JMeter to the Path
ENV PATH $JMETER_HOME/bin:$PATH
