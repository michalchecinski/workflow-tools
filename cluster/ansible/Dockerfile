FROM python:3.8

RUN apt update && \
    apt install -y \
        vim \
        sshpass
    
RUN pip install ansible

WORKDIR /etc/ansible

ENTRYPOINT ["/bin/bash"]
