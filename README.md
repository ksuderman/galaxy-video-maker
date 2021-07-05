# Galaxy Video Maker

The GTN (Galaxy Training Network) has a [wonderful method](https://youtu.be/Gm1MKAwuLxg) for generating slideshows with narrated videos from slides created with GFM (GitHub Flavored Markdown).  In fact, in the spirit of [eating your own dog food](https://www.computer.org/csdl/magazine/so/2006/03/s3005/13rRUygBwg0) that video was automatically generated from the markdown used to create the slides.

However, one drawback is that the videos are generated on GitHub servers via GitHub actions and there is no standalone script (yet) to process the slides for a single video on your local machine.  In addition, on MacOS several of the tools used operate slightly differently, are named differently, or are not available at all (I'm looking at you `ss`).  

This Docker image addresses all of these problems by providing a Ubuntu 20.04 system with all the required software installed and ready to use.

## Prerequisites

1. Docker (of course)
1. Credentials for AWS
1. A local copy of the [training material repository](https://github.com/galaxyproject/training-material)

Since Amazon is used to generate the speech you will need your own keys to be able to access the service.

## Generating A Video

1. Create your slides according to the instructions in the above video.
1. Store your AWS credentials in a file named `aws-creds.sh` that we will use to set the **ENV** variables in the container:
   ```
   AWS_ACCESS_KEY_ID=<your access key ID>
   AWS_SECRET_ACCESS_KEY=<your secret access key>
   ```
   **Note:** if you name the file something other than `aws-creds.sh` be sure to use the corrent name in the command below.
1. From the root of the `training-material` directory run the command:
   `docker run --env-file aws-cred.sh -v $(pwd):/home/galaxy/training-material ksuderman/galaxy-video-maker <topic> <tutorial-name>`
   Where `<topic>` is one of the existing topics (e.g. admin, climate, proteomics, etc) and `<tutorial-name>` is the name of the directory containing the `slides.html` file you created.

For example, if you create an `admin` tutorial on remote storage and create the slide deck in `./topics/admin/tutorials/remote-storage/slides.html` the command to generate the video would be:

```
docker run --env-file aws-cred.sh -v $(pwd):/home/galaxy/training-material ksuderman/galaxy-video-maker admin remote-storage
```

The generated video will be found in `./videos/topics/admin/tutorials/remote-storage` and a PDF version of the slides in `_site/training-material/topics/admin/tutorials/remote-storage`.

## Future Work

The scripts used by the GTN can also use [Mozilla TTS](https://github.com/mozilla/TTS) but using it requires setting up your own TTS server.

