FROM uninen/python:3.11

ENV DOCKER_BUILDKIT=1

USER duser
WORKDIR /home/duser
ADD --chown=duser:duser . /home/duser

# This doesn't work as the permissions are wrong! :(
# RUN --mount=type=cache,target=/home/duser/.cache \
#     pip install --user -r requirements.txt
RUN pip install --no-cache-dir --user -r requirements.txt

CMD ["uvicorn", "--host", "0.0.0.0", "hello:app"]
