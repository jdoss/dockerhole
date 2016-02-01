# dockerhole
A DNS based ad and malware URL blocker in Docker. It will manage the downloading and parsing of known ad and malware URLs from  third party sources. Currently it blocks ~750k unique domains. It also has support for custom domain whitelists and blacklists.

## Quick Start

To get started quickly, make sure you have Docker installed for your OS. 

###Linux

If you are running a Linux distro with systemd the ```install_dockerhole``` script should get dockerhole installed and running for you without much hassle. To manually install you can follow these steps.

  * ```sudo docker build -t dockerhole -f Dockerfile .```
  * ```sudo docker run --name dockerhole -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro dockerhole /usr/lib/systemd/systemd```

###OS X

  Todo.

###Windows 

  Todo.

## Roadmap / Todo / Ideas

* Rewrite ```bin/dockerhole``` in something other than bash to speed up list parsing.
* Create small API/app for interacting with Dockerhole remotely.
* Figure out how to get a docker container to pull a LAN IP for LAN wide ad blocking.
* Expand block lists
* Local emulation of Content Delivery Networks. (https://github.com/Synzvato/decentraleyes)
* Figure out video ad blocking
* IPv6 ad blocking
* Debian 8 / Ubuntu 15.04 Docker Image.

## FAQs

#### Why a Fedora based docker image? 

I chose Fedora for the base image as I am most familiar with Red Hat based Linux distributions. It should be pretty easy to get working on Debian 8 or Ubuntu 15.04. 

#### Why Systemd... in a Docker container?

Not everyone hates the benevolent overlord known as PID 1. Systemd has everything needed to manage the dockerhole processes and systemd timers makes it easy trigger services to run even if your laptop has been sleeping for a few days.

#### Why not just use [pi-hole](https://github.com/pi-hole/pi-hole) or a browser based ad blocker like [uBlock](https://github.com/gorhill/uBlock)

I do most of my work on a laptop so an ad blocker that is tied to a single location such as Pi-Hole running on a Raspberry Pi at home doesn't really help keep ads off my browser. Also, some people don't use Chrome or Firefox so having an alternative method for blocking ads and malware domains is useful.  

## About

dockerhole was heavily inspired by the great [Pi-Hole](https://pi-hole.net/) project. It was created and shoved into a docker container because I wanted to have better ad / malware blocking on my laptops while on the go. 

I would also like to thank [Matt Holt](@holt) for his awesome [Caddy Webserver](https://github.com/mholt/caddy). 

##  Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request