#!/usr/bin/env ruby
CREW = `dirname $(which crew)`

# use chromebrew variable
require "#{CREW}/../lib/crew/lib/const"
require "#{CREW}/../lib/crew/lib/color"
require 'em-websocket'
require 'fileutils'

PID = CREW_PREFIX + '/tmp/server.pid'
LOG = CREW_PREFIX + '/tmp/server.log'
PWA_PREFIX = CREW_PREFIX + '/lib/pwa'
PORT = 25500
PATH = "#{CREW_PREFIX}/share/pixmaps " + "/usr/local/share/icons " + "#{Dir.home}/.local/ " + PWA_PREFIX

HELP = <<EOF
launcher: Chromebrew GUI application shortcut maker

Usage:
  stop            stop the launcher server if running
  start           start the launcher server for shortcut
  help            show this message
  new <command>   make a new shortcut

EOF

JS = <<EOF
chrome.app.runtime.onLaunched.addListener(function () {
    const ws = new WebSocket('ws://0.0.0.0:#{PORT}');
    ws.onopen = function () { ws.send('CMD'); }
});
EOF

JSON = <<EOF
{
  "manifest_version": 2,
  "app": {
    "background": {
      "scripts": [ "background.js" ]
    }
  },
  "name": "NAME",
  "version": "1.0",
  "description": "INFO",
  "icons": { "1024": "icon.png" },
  "minimum_chrome_version": "56.0"
}
EOF

POST_INSTALL = "
You're almost done, three more steps: 

Go to chrome://extensions in Chrome
Ensure that the 'Developer mode' checkbox in the top right-hand corner is checked.
Click on Load Unpacked and select the '<CMD>.launcher' folder.".lightblue

# kill pid of the previous server in the log file (if exist)
def stop_server
  begin
    Process.kill 'KILL', File.read(PID).to_i if File.exist?(PID)
  rescue
  end
end


def desktop_icon_name_finder (app)
  # find out the info, name and icon of the command
    
  @desktop = `find / -name #{app}.desktop 2> /dev/null | sed -e '/stateful_partition/d' | tail -n1`.tr("\n", '')
    
  # abort if a desktop file not found for the command
  if @desktop == '' then
    puts "Cannot find the .desktop file for #{app}, using default Chromebrew icon... 
(If you want to use customize icon, put the icon file to #{CREW_PREFIX}/lib/pwa/ and name it to '#{app}.png')".yellow
    FileUtils.mkdir_p PWA_PREFIX
    system('curl', '-L#', 'https://github.com/supechicken/chromebrew/raw/master/images/brew546.png', '-o', PWA_PREFIX + '/brew.png')
    @icon = PWA_PREFIX + '/brew.png'
    @icon = PWA_PREFIX + "/#{app}.png" if File.exist?(PWA_PREFIX + "/#{app}.png")
    @name = app.capitalize
  else
    @icon = File.readlines(@desktop).select { |line| line =~ /^Icon/ }[0].partition('=')[2].tr("\n", '')
    @icon = `find #{PATH} -iname #{@icon}.png -o -iname #{@icon}.xpm 2> /dev/null | sed -e '/stateful_partition/d' |\
             sed -e 's:/usr/local/share/icons/hicolor/::g' | sort -n | sed -e 's:^:/usr/local/share/icons/hicolor/:g' |\
             tail -n1`.tr("\n", '')
  

    @name = File.readlines(@desktop).select { |line| line =~ /^Name/ }[0].partition('=')[2].tr("\n", '')
    @info = File.readlines(@desktop).select { |line| line =~ /^Comment/ }[0].partition('=')[2].tr("\n", '')
  end
  @info = `crew search -d #{app} | head -1` unless @info
end

def new (app)
  # abort when command not found
  abort "#{app}: command not found".lightred unless system("which #{app} > /dev/null 2>1")

  desktop_icon_name_finder(app)
  
  @working_on_dir = "#{Dir.home}/MyFiles/#{app}.launcher/"
  FileUtils.mkdir_p(@working_on_dir)
  
  system('convert', @icon, '-resize', '1024x1024', @working_on_dir + 'icon.png')
    
  File.write @working_on_dir + 'manifest.json', JSON.gsub('NAME', @name).gsub('INFO', @info)
  File.write @working_on_dir + 'background.js', JS.gsub('CMD', app)
  
  puts POST_INSTALL.gsub('<CMD>', app).lightblue
end

def start_server
    
  stop_server
    
  system('startsommelier > /dev/null') or abort "Failed to start graphical environment: sommelier exited with status #{$?.exitstatus.to_s}".lightred
  ENV['DISPLAY'] = ':0'
  ENV['GDK_BACKEND'] = 'x11'
  Process.fork do
    # write current fork process pid to a file
    File.write(PID, Process.pid)
    EM.run {
      EM::WebSocket.run(:host => "0.0.0.0", :port => 25500) do |ws|
        ws.onmessage { |message|
          File.open(LOG, 'w') { |file|
            $stdout.sync = true
            $stdout.reopen(file)
            $stderr.sync = true
            $stderr.reopen(file)
          }
          system(message + '&')
        }
      end
    }
  end
end
    
case ARGV[0]
when 'start'
  start_server
when 'new'
  new ARGV[1]
  start_server
when 'stop'
  stop_server
  puts 'Server stopped'.lightgreen
else
  puts HELP
end