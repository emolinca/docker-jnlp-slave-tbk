# The MIT License
#
#  Copyright (c) 2015-2017, CloudBees, Inc.
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.

FROM jenkins/slave:3.29-2
MAINTAINER Ed Molina <emolinca@gmail.com>
USER root
RUN apt-get -y update
RUN apt -y install git
RUN echo "Install Maven"
RUN apt-get -y install maven
RUN wget https://www.kiuwan.com/pub/analyzer/KiuwanLocalAnalyzer.zip -P .
RUN mkdir /opt/kiuwan/
RUN mkdir /opt/kiuwan/KiuwanLocalAnalyzer
RUN unzip KiuwanLocalAnalyzer.zip -d /opt/kiuwan
RUN chmod +x /opt/kiuwan/KiuwanLocalAnalyzer/bin/*.sh
RUN export AGENT_HOME=/opt/kiuwan/KiuwanLocalAnalyzer
RUN echo $AGENT_HOME
RUN cd $AGENT_HOME && ls -la
RUN cd /opt/kiuwan && ls -alt
RUN git clone https://github.com/gtoledoe/kiuwan_config.git
RUN pwd && ls -alt
RUN ls -la $AGENT_HOME
USER jenkins

LABEL Description="This is a base image, JNLP, Java etc..."

ENTRYPOINT ["jenkins-slave"]
