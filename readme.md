# Living by sukinakoto

## setup

```
$ cp .env.in .env
$ vi .env # Edit your environments.
```

```
$ npm run docker:build # Build docker image.
$ npm run docker:cert # Acquire cert files by letsencrypt.
$ npm run docker:run # Start a nginx process.
```

## debug
```
$ npm run docker:shell
```
