FROM uninen/python:3.14

ENV DOCKER_BUILDKIT=1
ENV UV_NO_CACHE=1
ENV UV_PROJECT_ENVIRONMENT=/code/.dockervenv

USER duser
WORKDIR /code

COPY pyproject.toml /code/pyproject.toml
RUN uv sync

COPY . /code

CMD ["uv", "run", "uvicorn", "--host", "0.0.0.0", "hello:app"]
