#!/usr/bin/env ruby

# use chromebrew variable if exist
if File.exist?('/usr/local/lib/crew/lib/const.rb')
  require_relative '/usr/local/lib/crew/lib/const'
  CREW = true
elsif File.exist?("#{ENV['CREW_PREFIX']}/lib/crew/lib/const.rb")
  require_relative ENV['CREW_PREFIX'] + '/lib/crew/lib/const'
  CREW = true
else
  CREW_PREFIX = ''
  CREW = false
end

begin
  require 'em-websocket'
rescue LoadError
  system 'gem', 'install', 'em-websocket'
end

# colorization for strings
class String
  def colorize(color_code, shade)
    return "\e[#{shade};#{color_code}m#{self}\e[0m"
  end

  def lightred
    colorize(31, 1)
  end

  def lightgreen
    colorize(32, 1)
  end

  def yellow
    colorize(33, 1)
  end

  def lightblue
    colorize(34, 1)
  end

  def lightcyan
    colorize(36, 1)
  end
end

# for multi-language support in .desktop file
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8
LANG = ENV['LANG'] || ''

# variables
PID = '/tmp/desktop2chrome/server.pid'
LOG = '/tmp/desktop2chrome/server.log'
PWA_PREFIX = Dir.home + '/.local/desktop2crx/'
PORT = 25500

ICON_TYPE = [
  '96x96/',
  '128x128/',
  '192x192/',
  '256x256/',
  '512x512/'
]

ICON_PATH = [
  "#{CREW_PREFIX}/share/icons/",
  "/usr/share/icons/",
  "/usr/local/share/icons/",
  "/usr/share/pixmaps/",
  "/usr/local/share/pixmaps/",
  "#{CREW_PREFIX}/share/pixmaps/",
  "#{Dir.home}/.local/",
  PWA_PREFIX
]

ICON_EXTENSION = [
  '.png',
  '.xpm'
]

ICON_PROVIDER = [
  'gnome/',
  'Adwaita/',
  'hicolor/'
]

DESKTOP_PATH = [
  "#{CREW_PREFIX}/share/applications/",
  "/usr/share/applications/",
  "/usr/local/share/applications/",
  "#{Dir.home}/.local/share/applications/",
  PWA_PREFIX
]

# help message

HELP = <<EOF
desktop2crx: Add GUI applications shortcut to Chrome/Chromium OS launcher

Usage:
  stop            stop the launcher server if running
  start           start the launcher server for shortcut
  help            show this message
  new <command>   make a new shortcut

EOF

POST_INSTALL = <<EOF
You are almost done, three more steps: 

Go to chrome://extensions in Chrome
Ensure that the 'Developer mode' checkbox in the top right-hand corner is checked.
Click on Load Unpacked and select the '<CMD>.launcher' folder.

EOF

def make (name, cmd, wip_dir, ver = nil, info = nil)
  js = <<EOF
chrome.app.runtime.onLaunched.addListener(function () {
    const ws = new WebSocket("ws://0.0.0.0:#{PORT}");
    ws.onopen = function () { ws.send("#{cmd}"); }
});
EOF
    
  json = <<EOF
{
  "manifest_version": 2,
  "app": {
    "background": {
      "scripts": [ "background.js" ]
    }
  },
  "name": "#{name}",
  "version": "#{ver}",
  "description": "#{info}",
  "icons": { "1024": "icon.png" }
}
EOF
  
  File.write(wip_dir + 'background.js', js)
  File.write(wip_dir + 'manifest.json', json)
end

# kill pid of the previous server in the log file (if exist)

def stop_server
  begin
    Process.kill 'TERM', File.read(PID).to_i if File.exist?(PID)
  rescue
  end
end


def desktop_icon_name_finder (app)
  # find out the info, name and icon of the command
    
  # abort if a desktop file not found for the command
  
  DESKTOP_PATH.each do |desktop|
    desktop_path = desktop + app + '.desktop'
    @desktop = desktop_path if File.exist?(desktop_path)
    break if @desktop
  end
  
  unless @desktop
    @name = app.capitalize
  else
    desktop = File.read(@desktop).split("\n\n", -1)[0]
    icon_name = desktop.scan(/^Icon=(.*)/)[0].first
    
    ICON_PATH.each {|icon| ICON_TYPE.each {|size| ICON_PROVIDER.each {|provider| ICON_EXTENSION.each {|extname|
      if icon.match(/pixmaps/)
        xpm = icon + icon_name + extname
        @icon ||= xpm if File.exist?(xpm)
      else
        icon_path = icon + provider + size + 'apps/' + icon_name + extname
        @icon = icon_path if File.exist?(icon_path)
      end
    }}}}

    # if localized name (language) not found, use default
    @name = (desktop.scan(/^Name\[#{LANG}\]=(.*)/)[0].first) rescue \
       desktop.scan(/^Name=(.*)/)[0].first
    @info = (desktop.scan(/^Comment\[#{LANG}\]=(.*)/)[0].first) rescue \
       desktop.scan(/^Comment=(.*)/)[0].first
  end
  
  unless @icon
    if app == 'firefox'
      ['/usr/local/', '/usr/', CREW_PREFIX].each do |i|
        path = i + 'firefox/browser/chrome/icons/default/default128.png'
        @icon = path if File.exist?(path)
      end
    end
  end
  
  unless @icon
    puts "Cannot find an icon for #{app}, using default Chromebrew icon... 
(If you want to use customize icon, put the icon file to #{PWA_PREFIX} and name it to '#{app}.png')".yellow

    Dir.mkdir(PWA_PREFIX) unless Dir.exist?(PWA_PREFIX)
    system('wget', '-O', PWA_PREFIX + 'brew.png', 'https://github.com/skycocker/chromebrew/raw/master/images/brew.png')
    
    @icon = PWA_PREFIX + 'brew.png'
    @icon = PWA_PREFIX + app + '.png' if File.exist?(PWA_PREFIX + app + '.png')
  end
  
  unless @info
    # if info is missing, use chromebrew one (only when chromebrew mode)
    if CREW and File.exist?(CREW_LIB_PATH + 'packages/' + app + '.rb')
      @info = File.read(CREW_LIB_PATH + 'packages/' + app + '.rb') \
        .scan(/description ['"](.*?)['"]/)[0][0]
    end
  end
  @ver = `#{app} --version 2> /dev/null`.scan(/[\_\.\-\d]*/).reject(&:empty?).first
      
  puts 'Name: ' + @name
  puts 'Version: ' + @ver
  puts 'Icon: ' + @icon
  puts 'Info: ' + @info if @info
end



def new (app)
  # abort when command not found
  abort "Error: no application name provided".lightred unless app
  abort "#{app}: application not installed".lightred unless system("which #{app} > /dev/null 2>&1")

  desktop_icon_name_finder(app)
  
  @working_on_dir = "#{Dir.home}/Downloads/#{app}.launcher/"
  Dir.mkdir(@working_on_dir) unless Dir.exist?(@working_on_dir)
  
  # convert icon to .png and resize
  system('convert', @icon, '-resize', '1024x1024', @working_on_dir + 'icon.png')
    
  make(@name, app, @working_on_dir, @ver, @info)
  
  puts
  puts POST_INSTALL.sub('<CMD>', app).lightcyan
end

def start_server
    
  stop_server
  
  Process.fork do
    puts "Server daemon running with PID #{Process.pid}".lightgreen
    puts "Appending process output to '#{LOG}'".lightblue
    
    # write current fork process pid to a file
    Dir.mkdir('/tmp/desktop2chrome') unless Dir.exist?('/tmp/desktop2chrome')
    File.write(PID, Process.pid)

    # ignore SIGHUP, make us be a daemon
    Signal.trap('HUP') do
      puts "Received HUP, ignoring..."
    end

    EM.run {
      EM::WebSocket.run(:host => "0.0.0.0", :port => PORT) do |ws|
        ws.onmessage { |message|
          # redirect STDOUT and STDERR to log file
        
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
  if ARGV[1] then
    new ARGV[1]
    start_server
  else
    puts 'launcher: missing command name'.lightred
    puts HELP
  end
when 'stop'
  stop_server
  puts 'Server stopped'.lightgreen
else
  puts HELP
end
