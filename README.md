# math.github.com

This is an experiment in implementing a web service to render math equations as SVG images.

## Contributing

After cloning the repo, bundle all the dependencies with:

    $ script/bootstrap

Start the local server with:

    $ script/server

Test it out:

    $ curl -X GET 'http://localhost:9393/formula' -d formula='X'
    <h1>Hello World</h1>
