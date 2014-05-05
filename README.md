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

Test it out:

    $ curl -X GET 'http://localhost:9393/formula' -d formula='X'
    <h1>Hello World</h1>
