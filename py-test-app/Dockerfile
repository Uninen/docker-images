FROM registry.gitlab.com/uninen/docker-images/python:3.9

ENV PATH="/home/duser/.local/bin:${PATH}"
ENV PYTHONPATH="/home/duser"
ENV DOCKER_BUILDKIT=1

USER duser
WORKDIR /home/duser
ADD . /home/duser

RUN pip install --no-cache-dir --user -r requirements.txt

CMD ["uvicorn", "hello:app"]
