FROM python:3.6-alpine

LABEL maintainer="hromus@gmail.com"

RUN apk add --update --no-cache \
	gcc \
        build-base \
        linux-headers \
        python3-dev \
        busybox-extras \
        jpeg-dev \
        zlib-dev
        
RUN pip3 install --upgrade pip

RUN addgroup -S nut && adduser -S -G nut nut
USER nut
WORKDIR /home/nut

ENV PATH /home/nut/.local/bin:$PATH

COPY --chown=nut:nut requirements.txt .
RUN pip3 install --user -r requirements.txt

ENV PYTHONDONTWRITEBYTECODE 1 
ENV PYTHONUNBUFFERED 1

COPY --chown=nut:nut . .

EXPOSE 9000

CMD ["python3.6", "nut.py", "--server", "-p", "9000"]

