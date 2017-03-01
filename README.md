# Wekan Development Environment

This is a containerised development environment for [Wekan](/wekan/wekan). It's meant to quickly
get you set up with a system that you can use to develop Wekan, without needing to worry about its
various dependencies.

To get started, you'll need [Docker](https://www.docker.com/products/docker) set up on your system.
Then:

```
git clone --recursive https://github.com/wekan/wekan-dev.git wekan
(cd wekan/src; npm install --save xss)
cd wekan
docker-compose up --build -d
```

This will take some time to build the image, and to initially cache & build the meteor packages.
Eventually you should be able to see Wekan at `http://localhost:3000/`, and changes made under
`src/` will automatically trigger a refresh of the interface. If you missed the recursive clone,
you'll need to run `git submodule update --init` to fetch the actual Wekan source to `src/`.

For a continuous view of what's happening with the app, you can use `docker-compose logs -f`. To
stop, it's just `docker-compose stop`. See the
[docker-compose documentation](https://docs.docker.com/compose/reference/) for more commands.

With this setup, on my 2015 MacBook Pro, building the environment takes 40 seconds or so, and a
refresh after changes about 10 seconds. The initial build feels interminable, but is probably about
10-15 minutes. Changes to the packages or other stuff under `src/.meteor/` will trigger a partial
re-build of the image, which will take a few minutes depending on your network connection.
