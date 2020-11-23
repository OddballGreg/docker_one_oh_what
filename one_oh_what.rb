require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'pry'
  gem 'colorize'
end

def sputs(string='')
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

def run_command(string, actually_run=nil)
  sputs
  sputs "-"*20
  sputs "`#{string}`".blue
  if actually_run
    system(actually_run, out: STDOUT)
  else
    system(string, out: STDOUT)
  end
  sputs "-"*20
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
  puts initial_padding + '#   ' + string.underline + '   #'
  puts initial_padding + '#   ' + (' ' * string.size) + '   #'
  puts initial_padding + '#' * (string.size + 8)
  
end

$typing_speed = proc { rand(0.05..0.06) }

def continue?
  puts
  sputs("Continue?".blink)
  gets
end

draw_box("Docker One Oh What?")
continue?

# Part one introduction

draw_box("What is docker?")

sputs '- Containerization Protocol'
sputs '  - Lightweight'
sputs '  - Fast'
continue?
sputs '  - Easy To Use For:'
sputs '    - Devops & Deployment'
sputs '    - Development'
sputs '    - "Infrastructure As Code"'
continue?
sputs '  - Important Note: Not a VM'
sputs '  - Probably the protocol underpinning the majority of Kubernetes clusters'
continue?
sputs '- "Well we\'ll just deploy your machine then!"'
continue?

# # Part two technicals and usage
draw_box("Key docker concepts")

sputs '- Networking'
sputs ' - Creates actual network adapters on your host'
run_command 'docker network create our-first-network'
run_command 'docker network ls | grep our-first-network'
continue?
sputs '- Volumes'
sputs ' - Creates non host mounted volumes for data permanency'
run_command('docker volume create our-first-volume')
run_command('docker volume ls | grep our-first-volume')
continue?
sputs '- Images'
run_command('cat Dockerfile')
continue?
run_command('docker build . -t our-first-image:latest')
run_command('docker image ls | grep our-first-image')
continue?
sputs '- Containers'
run_command('cat arbitrary_ruby_application.rb')
run_command('docker run -d --name our-first-container our-first-image')
run_command('docker ps | grep our-first-container')
run_command('docker logs --tail=20 our-first-container')
run_command('docker exec -it our-first-container sh')
sputs 'NB: everything in docker containers is ephemeral unless mounted to a volume'
continue?
sputs '- Registries'
run_command('docker pull ruby:2.7-alpine')
sputs 'Pulls from https://hub.docker.com/'
run_command('docker push ruby:2.7-alpine')
sputs "Probably shouldn't work... well, hopefully it doesn't."

continue?

# Part three better with docker compose
sprint 'This all sounds like a lot of work to control... What are we gonna do about that?'
puts

draw_box('docker-compose')

run_command('cat docker-compose.yml')
continue?

run_command("alias dc='docker-compose'")
run_command('dc up -d', '. .env/bin/activate && docker-compose up -d')
run_command('dc ps', '. .env/bin/activate && docker-compose ps')

continue?

# Part Four setup
draw_box('Setup')

sputs "If you're using Ubuntu:"
sputs '`sudo apt-get install docker.io docker-compose`'
sputs "`sudo groupadd docker`"
sputs "`sudo usermod -aG docker $USER`"
sputs "Log out and log back in aaaaand..."
sputs ''
sputs "Ta-Da!"
sputs ''
sputs "The Ubuntu docker is co-maintained by the core Docker team as well as canonical, so is trust worthy and generally up to date."
sputs "..."
sputs "As for any other distribution... welllllll..."
sputs "
In the wise words of a friend of mine: 
\"Most distros will have an antiquated version of Docker, avoid it;

Grab it fresh from Docker repos:

* https://docs.docker.com/engine/installation/#server

* (or Google: `install Docker CE $YOUR_DISTRO`)

`pip install docker-compose`\"
"
continue?
sputs "The docker-compose available to ubuntu via apt-get can also be a bit dodgy from time to time, so it might be worth tinkering with python virtual envs for docker-compose"

continue?

# Part Five security
draw_box("Security Best Practices")

sputs '- Layered Dockerfiles'
sputs '- Alpine Linux'
sputs '- Setting the User'
sputs '- Container Quotas'
puts
run_command('cat Better-Dockerfile')
continue?
run_command('docker build . -f Better-Dockerfile -t our-third-image:latest')
continue?
puts

sputs '- Docker Ignore files'
puts
run_command('cat Copy-Everything-Dockerfile')
run_command('cat .dockerignore')
run_command('ls')
continue?
run_command('docker build . -f Copy-Everything-Dockerfile -t our-fourth-image:latest')
run_command('docker run --rm our-fourth-image:latest ls')
continue?

# Part 6
draw_box("Other Interesting Nik Naks")

sputs '- Interacting With Docker Containers'
sputs 'To attach your terminal to the process run in a docker container: docker attach our-first-container'
sputs ' - (showing this would break the presentation)'
run_command('docker exec -it our-first-container sh')
run_command('dc exec arbruba sh', '. .env/bin/activate && docker-compose exec arbruba sh')
continue?
sputs '- Host Networking Mode'
sputs '  - --network host'
continue?
sputs '- Privelleged Mode'
sputs '  - "Let Docker do ALL THE THINGS!" mode. Enough permissions to run docker inside docker.'
sputs '  - docker pull docker:dind'
continue?
sputs '- The Docker Daemon Socket and what the docker cli is doing'
sputs '  - By default, a root owned unix domain socket (or IPC socket) is created at /var/run/docker.sock'
continue?
sputs '- --user'
run_command('dc exec --user ruby arbruba whoami', '. .env/bin/activate && docker-compose exec --user ruby arbruba whoami')
run_command('dc exec --user root arbruba whoami', '. .env/bin/activate && docker-compose exec --user root arbruba whoami')
continue?
sputs '- Copying between host and container'
run_command('touch cpfile')
run_command('docker cp cpfile our-second-container:/src/app/cpfile')
run_command('docker exec our-second-container ls')
sputs '  - Basically works like SCP'
continue?
sputs '- Windows and Docker Machine'
sputs '  - Never tried it, but apparently not horrible on Windows'
sputs "  - Mac can't mount unix volumes to it's file system, so a virtualization layer is needed" 
sputs "    - docker-machine basically runs headless virutal box vms for this, so it's a bit slow." 
sputs "      - Apple has apparently made some changes to reduce this impact since I originally wrote this, so your milleage may vary." 
continue?
sputs '- Docker Swarm'
sputs '  - An orchestration protocol built into docker for running docker networks across hosts'
continue?
sputs '- Orchestration'
sputs "  - Speaking of orchestration, you're probably more likely to have heard of the de facto orchestration protocol for docker containers: Kubernetes"
continue?
sputs '- Clean Out Docker Related Resources'
run_command('docker system prune --volumes --all')
run_command('rm cpfile')

draw_box("Thanks")
continue? 

draw_box("Recommended Reading")
puts
sputs "Usage: https://github.com/Skybound1/docker-workshop/blob/master/slideshow.html"
sputs "Exploitation: https://github.com/Skybound1/docker-practice-vm/blob/master/slides.pdf"
sputs "Just remind me to share these in the chat :)"
