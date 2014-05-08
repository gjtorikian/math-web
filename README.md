# math.github.com

This is an experiment in implementing a web service to render math equations as SVG images.

Why a separate web service? Because rendering math requires a lot of dependencies, and those dependencies are prone to security vulnerabilities. Isolating these dependencies on their own service will ensure that they don't have access to any confidential data.

## TODO

* [ ] Error handling
* [ ] Proper ETag and cache control headers for CDN

## Contributing

After cloning the repo, bundle all the dependencies with:

    $ script/bootstrap

Start the local server with:

    $ script/server

Test it out by viewing http://localhost:9393/render/%5Cpi%20r%5E2?mode=inline in your browser.
