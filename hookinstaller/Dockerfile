FROM busybox:latest

ENTRYPOINT sh -c "cd /tmp/hooks && ls | xargs chmod +x && cd /tmp/proj/ && find /tmp/hooks -type f -exec cp {} /tmp/proj/ \; && echo 'githooks installed'"

