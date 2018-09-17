### Issue

I want to start a stack with 2 containers:

1. A site (`django`, `rails`, you name it).
2. `nginx`.

And I want `nginx` to serve static files that come with the site's image.

I can't just mount a volume to both of them and be done with it:

```yaml
volumes:
  docroot:
services:
  site:
    volumes:
      - docroot:/site/public
  nginx:
    volumes:
      - docroot:/docroot
```

The way I understand it on first `docker stack deploy`, `docker` creates
a `docroot` volume. Then it starts the containers. `nginx` image has nothing at
`/docroot`, so it moves on to the `site`'s image.
And this one does come with some files 
(at `/site/public`), so `docker` uses them to initialize the `docroot` volume.
On the following deploys,
no matter what `nginx` or `site` images have at docroot path, that doesn't
affect the `docroot` volume. And from inside both of the them, you see
the `docroot` volume's content, not what comes with an image.

### Solution

The only way to change the `docroot` volume is to execute a command from inside
a container that has it mounted. And one way to go about it is:

`docker-stack.yml`:

```yaml
volumes:
  docroot:
services:
  site:
    volumes:
      - docroot:/docroot
  nginx:
    volumes:
      - docroot:/docroot
```

`site`'s `entrypoint.sh`:

```sh
#!/usr/bin/env sh
rsync -a --delete --exclude /uploads public/ /docroot
# start the site
```

Here I additionally make it not copy `/site/public/uploads` dir.

### How to reproduce

I had two objectives in mind regarding the way to reproduce the issue:

1. Ease of use.
2. Being close to production environment.

There are some **prerequisites**, or **thing you might want to know before
running the script.** Your `docker` is supposed to be running in swarm mode.
The script starts a `registry` container (name: `registry`, port: `5000`).
At the beginning
it stops stack `s1`, and removes volumes `s1_docroot` and `s1_uploads`
(to be able to start the script more then once without doing the clean-up
yourself).

If the above is met:

```
$ git clone -b docker-copy-docroot https://github.com/x-yuri/issues docker-copy-docroot
$ cd docker-copy-docroot
$ ./go.sh
...
---
/docroot
├── assets
│   └── 1.css
└── robots.txt

1 directory, 2 files
---
...
---
/docroot
├── assets
│   └── 2.css
└── robots.txt

1 directory, 2 files
---
```

### Alternative solutions

If you'd like to avoid employing `rsync`, you might go with something along
the lines of:

```
cp -r public/* /docroot
find /docroot -mindepth 1 -mtime +1 -delete
```

But it copies the `uploads` dir, and leaves some files from previous releases.
That probably can be dealt with, but using `rsync` seems like a better option.

And yet another way is a custom `nginx` image with docroot copied
from `site`'s image.

### References

[Serving static files with nginx located in another docker container](https://stackoverflow.com/a/56855338/52499)
