FROM uninen/python:3.13

ENV DOCKER_BUILDKIT=1
ENV PATH="/home/duser/.local/bin:/home/duser/.cargo/bin:${PATH}"
ENV PYTHONPATH="/home/duser/.local/lib:${PYTHONPATH}"
ENV VIRTUAL_ENV="/home/duser/.local"

USER duser
WORKDIR /code

COPY requirements.txt /code/requirements.txt
RUN uv pip install -r requirements.txt

COPY . /code

CMD ["uvicorn", "--host", "0.0.0.0", "hello:app"]
# CMD /bin/sh -c "while sleep 1000; do :; done"