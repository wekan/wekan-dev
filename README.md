# Wekan Development Environment

This is a containerised development environment for [Wekan](/wekan/wekan). It's meant to quickly
get you set up with a system that you can use to develop Wekan, without needing to worry about its
various dependencies.

To get started, you'll need [Docker](https://www.docker.com/products/docker) set up on your system.
Then:

```
git clone https://github.com/wekan/wekan-dev.git wekan
cd wekan
git submodule update --init --remote
(cd src; npm install)
docker-compose up --build -d
```

This will take some time to build the image, and to initially cache & build the meteor packages.
Eventually you should be able to see Wekan at `http://localhost:8081/`, and changes made under
`src/` will automatically trigger a refresh of the interface. Note that the `src/` directory also
includes docker configuration; those are for the production builds of Wekan.

To update the Wekan source submodule to the head of its `devel` branch, you can use
`git submodule update --remote`; the commit reference stored in this repo will undoubtedly lag
behind the [`HEAD`](https://github.com/wekan/wekan/commits/devel) of that branch, hence its
inclusion even above.

For a continuous view of what's happening with the app, you can use `docker-compose logs -f`. To
start and stop the app, it's just `docker-compose start` and `docker-compose stop`. See the
[docker-compose documentation](https://docs.docker.com/compose/reference/) for more commands.

With this setup, on my 2015 MacBook Pro, building the environment takes 40 seconds or so, and a
refresh after changes about 10 seconds. The initial build feels interminable, but is probably about
10-15 minutes. Changes to the packages or other stuff under `src/.meteor/` will trigger a partial
re-build of the image, which will take a few minutes depending on your network connection.
