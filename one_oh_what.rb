def sputs(string)
  (string + "\n").chars.each do |char|
    sleep $typing_speed.call
    print char
  end
end

def sprint(string)
  string.chars.each do |char|
    sleep $typing_speed.call
    print char
  end
end

require 'pry'
require 'io/console'

def draw_box(string)
  console_size = IO.console.winsize.last
  half_console_size = (console_size / 2)
  adjusted_half_console_size = half_console_size - ((string.size / 2) + 4)
  
  padding = 8
  initial_padding = (' ' * adjusted_half_console_size)
  inner_box_padding = ' ' * (padding / 2)

  string = string.to_s
  puts initial_padding + '#' * (string.size + 8)
  puts initial_padding + '#   ' + (' ' * string.size) + '   #'
  puts initial_padding + '#   ' + string + '   #'
  puts initial_padding + '#   ' + (' ' * string.size) + '   #'
  puts initial_padding + '#' * (string.size + 8)
  
end

$typing_speed = proc { rand(0.05..0.2) }

def continue?
  puts
  sputs("Continue?")
  gets
end

draw_box("Docker One Oh What?")
continue?

sputs "Oh hey? How's it going? You going to teach some docker to these fellows?"
sputs "1. Yes, but type faster than that please"
sputs "2. No"
sputs "3. REEEEEE"

gets
puts

$typing_speed = proc { rand(0.05..0.06) }

sputs 'Got it. Lets get teaching. ;)'

# Part one introduction

draw_box("What is docker?")

sprint '- Containerization Protocol'
sprint '  - Lightweight'
sprint '  - Fast'
sprint '  - Easy To Use For:'
sprint '    - Devops & Deployment'
sprint '    - Development'
sprint '    - "Infrastructure As Code"'
sprint '  - Important Note: Not a VM'
sprint '  - Probably the protocal underpinning the majority of Kubernetes clusters'
sprint '- "Well we\'ll just deploy your machine then!"'
continue?

# # Part two technicals and usage
draw_box("Key docker concepts")

sputs '- Networking'
sputs ' - Creates actual network adapters on your host'
puts '`docker network create our-first-network`'
puts '`docker network ls | grep our-first-network`'
gets
sputs '- Volumes'
sputs ' - Creates non host mounted volumes for data permanency'
puts '`docker volume create our-first-volume`'
puts '`docker volume ls | grep our-first-volume`'
gets
sputs '- Images'
sputs '`cat Dockerfile`'
puts
puts '----- Dockerfile -------'
puts `cat Dockerfile`
puts '----- \Dockerfile -------'
puts
gets
puts '`docker build . -t our-first-image:latest`'
puts '`docker image ls | grep our-first-image`'
gets
sputs '- Containers'
puts '`docker run -d --name our-first-container our-first-image`'
puts '`docker ps | grep our-first-container`'
puts '`docker logs our-first-container`'
puts '`docker exec -it our-first-container sh`'
sputs 'NB: everything in docker containers are ephemeral without volume mounts'
gets
sputs '- Registries'
puts '`docker pull ruby:2.7-alpine`'
sputs 'Pulls from https://hub.docker.com/'
puts '`docker push ruby:2.7-alpine`'
sputs "Probably shouldn't work... well, hopefully it doesn't."

continue?

# Part three better with docker compose
sprint 'This all sounds like a lot of work to control... What are we gonna do about that?'
puts
sputs '1. Not even bother to give multiple options, because there\'s already a solution...'
puts

draw_box('docker-compose')

sputs '`cat docker-compose.yml`'
puts
puts '----- docker-compose.yml -------'
puts `cat docker-compose.yml`
puts '----- \docker-compose.yml -------'
puts
gets

puts "`alias dc='docker-compose'`"
puts "`dc up -d`"

continue?

# Part Four setup
draw_box('Setup')

sputs "If you're using Ubuntu:"
sputs '`sudo apt-get install docker docker-compose`'
sputs "`sudo groupadd docker`"
sputs "`sudo usermod -aG docker $USER`"
sputs "Log out and log back in..."
sputs "Ta-Da!"
sputs "The Ubuntu docker is co-maintained by the core Docker team as well as cononical."
sputs "..."
sputs "Any other distribution... welllllll..."
sputs "
In the wise words of Mohit Gupta: 
\"Most distros will have an antiquated version of Docker, avoid it;

Grab it fresh from Docker repos:

* https://docs.docker.com/engine/installation/#server

* (or Google: `install Docker CE $YOUR_DISTRO`)

`pip install docker-compose`\"
"

continue?

# Part Five security
draw_box("Security Best Practices")

sputs '`cat Better-Dockerfile`'
puts
puts '----- Better-Dockerfile -------'
puts `cat Better-Dockerfile`
puts '----- \Better-Dockerfile -------'
puts
gets
sputs '- Layered Dockerfiles'
sputs '- Alpine Linux'
sputs '- Setting the User'
sputs '- Container Quotas'
sputs '- Docker Ignore'
puts
sputs '`cat Copy-Everything-Dockerfile`'
puts
puts '----- Copy-Everything-Dockerfile -------'
puts `cat Copy-Everything-Dockerfile`
puts '----- \Copy-Everything-Dockerfile -------'
puts
gets

continue?

# Part 6
draw_box("Other Interesting Nik Naks")

sputs '- Interacting With Docker Containers'
sputs '  - `docker attach our-first-container`'
sputs '  - `docker exec -it our-first-container sh`'
sputs '  - `dc exec arbruba sh`'
gets
sputs '- Host Networking Mode'
sputs '  - --network host'
gets
sputs '- Privelleged Mode'
sputs '  - "Let Docker do ALL THE THINGS!" mode. Enough permissions to run docker inside docker.'
sputs '  - docker pull docker:dind'
gets
sputs '- The Docker Daemon Socket and what the docker cli is doing'
sputs '  - By default, a root owned unix domain socket (or IPC socket) is created at /var/run/docker.sock'
gets
sputs '- --user'
sputs '  - `dc exec --user ruby arbruba sh`'
sputs '  - `dc exec --user root arbruba sh`'
gets
sputs '- copying between host and container'
sputs '  - `docker cp <container-name>:/data/db /tmp/db`'
sputs '  - Basically works like SCP'
gets
sputs '- Windows and Docker Machine'
sputs '  - Never tried it, but apparently not horrible on Windows'
sputs "  - Mac can't mount unix volumes to it's file system, so a virtualization layer is needed" 
sputs "    - docker-machine basically runs headless virutal box vms for this, so it's a bit slow." 
gets
sputs '- Docker Swarm'
sputs '  - An orchestration protocol built into docker for running docker networks across hosts'
gets
sputs '- Orchestration'
sputs "  - Speaking of orchestration, you're probably more likely to have heard of the de facto orchestration protocol for docker containers: Kubernetes"
gets

draw_box("Thanks")
gets 

draw_box("Recommended Reading")
puts
sputs "Usage: https://github.com/Skybound1/docker-workshop/blob/master/slideshow.html"
sputs "Exploitation: https://github.com/Skybound1/docker-practice-vm/blob/master/slides.pdf"
sputs "Just remind me to share these in the chat :)"
gets 
