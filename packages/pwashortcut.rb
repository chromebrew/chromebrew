require 'package'

class Pwashortcut < Package
  description 'Scripts to create a PWA shortcut on ChromeOS dock for Chromebrew GUI Apps.'
  homepage 'https://github.com/supechicken666/pwashortcut/'
  version '1.3.1'
  source_url 'https://github.com/supechicken666/pwashortcut/archive/1.3.1-debug.tar.gz'
  source_sha256 'ec4d3e728733550a8cdaa8b8f19c5df01982f9e39dfc1a456e39d52934bf9d89'
  
  depends_on "graphicsmagick"

  HOME = Dir.home
    
  def self.build
    system "pip install flask"
    #######################################
    system "cat <<'EOF'> main.py.bak
from flask import Flask, render_template, redirect, url_for, send_from_directory
from threading import Thread
import os

app = Flask(__name__)

EOF"
    #######################################
    system "cat <<'EOF'> manifest.json.bak
v1
  \"name\"v4 \"linuxapp\"v6
  \"short_name\"v4 \"linuxapp\"v6
  \"display\"v4 \"standalone\"v6
  \"start_url\"v4 \"unixapp.app\"v6
  \"theme_color\"v4 \"#000000\"v6
  \"background_color\"v4 \"#000000\"v6
  \"icons\"v4 v2
    v1
      \"src\"v4 \"icon/brew.png\"v6
      \"sizes\"v4 \"546x546\"v6
      \"type\"v4 \"image/png\"
    v9
  v8
v9
EOF"
    system "sed -i 's/v6/,/g' manifest.json.bak"
    system "sed -i 's/v4/:/g' manifest.json.bak"
    system "sed -i 's/v1/\{/g' manifest.json.bak"
    system "sed -i 's/v2/\[/g' manifest.json.bak"
    system "sed -i 's/v9/\}/g' manifest.json.bak"
    system "sed -i 's/v8/]/g' manifest.json.bak"
    #######################################
    system "cat <<'EOF'> pwashortcut
#!/bin/bash
# A simple start script
export CREW_PREFIX=#{CREW_PREFIX}
export PYTHONPATH=$CREW_PREFIX/lib/python3.9/site-packages/
export PWA_PREFIX=$CREW_PREFIX/lib/pwa
export tools=$PWA_PREFIX/tools
export FLASK_APP=$PWA_PREFIX/main.py
export FLASK_ENV=development
pkill flask
help='
===================================
    Shortcut Server Starter
  -s (Default option) Start shortcut server
  -n (App Name)       Make a new shortcut
  -h                  Show this message
  -p                  Set py script path
  -y                  Set PYTHONPATH
  -f                  Pass option to Flask
  -g                  PWA icon chooser
  -i                  Available preinstalled icons for PWA icon chooser
  -d                  Generate shortcuts from .desktop files (stable but not recommended)
==================================='
case ${1} in
    -d)
          bash $tools/find.sh $CREW_PREFIX
          ;;
    -h)
          echo \"$help\"
          ;;
    -i)
          bash $tools/customize.sh -i $tools/icon/
          ;;
    -g)   
          bash $tools/customize.sh $tools/icon/ $PWA_PREFIX
          ;;
    -n)
          mkdir -p $PWA_PREFIX/$2/templates
          cp -r $tools/* $PWA_PREFIX/$2/templates
          mv $PWA_PREFIX/$2/templates/manifest.json.bak $PWA_PREFIX/$2/templates/manifest.json
          sed -i \"s/linuxapp/${2^}/g\" $PWA_PREFIX/$2/templates/manifest.json
          sed -i \"s/unixapp/$2/g\" $PWA_PREFIX/$2/templates/manifest.json
          #######################
          echo \" \" >> $FLASK_APP
          echo \"@app.route('/$2/$2.app')\" >> $FLASK_APP
          echo \"def $2():\" >> $FLASK_APP
          echo \"  def $2_run():\" >> $FLASK_APP
          echo \"    os.system('$2')\" >> $FLASK_APP
          echo \"  start_$2 = Thread(target=$2_run)\" >> $FLASK_APP
          echo \"  start_$2.start()\" >> $FLASK_APP
          echo \"  return redirect('chrome-extension://eabaombiainalffcbinoffnbjeaefhle/exit.html')\" >> $FLASK_APP
          echo \"@app.route('/$2/')\" >> $FLASK_APP
          echo \"def installer_$2():\" >> $FLASK_APP
          echo \"    return render_template('installer.html')\" >> $FLASK_APP
          echo \"@app.route('/$2/<path:path>')\" >> $FLASK_APP
          echo \"def $2_path(path):\" >> $FLASK_APP
          echo \"    if path.endswith(('.svg', '.png', 'manifest.json')):\" >> $FLASK_APP
          echo \"        return send_from_directory('$2/templates', path)\" >> $FLASK_APP
          echo \" \" >> $FLASK_APP
          #######################
          echo \"Shortcut for ${2^} deployed!\"
          if [[ $(pwashortcut -i | grep $2) != \"\" ]]
          then
          echo \"${2^} has a preinstalled customize theme, using preinstalled configuration\"
          cp $tools/icon/$2.json $PWA_PREFIX/$2/templates/manifest.json
          fi
          echo \"Wait for server start and go to localhost:5000/$2/ for installing shortcut.\"
          sleep 2
          flask run
          ;;
    -s)
          flask run
          ;;
    *)
          getopts \"p:y:f:*\" arg
          OPTARG=$(echo ${OPTARG} | sed 's/\=//')
          RUN=NO
          case ${arg} in
                 p)
                     RUN=YES
                     export FLASK_APP=$OPTARG
                     flask run
                     ;;
                 y)
                     RUN=YES
                     export PYTHONPATH=$OPTARG
                     flask run
                     ;;
                 f)  
                     RUN=YES
                     flask run $OPTARG
                     ;;
                 *)  
                     echo \"Error: unknown option '$arg'\"
                     echo \"Try 'pwashortcut -h' for more options.\"
                     ;;
          esac
          if [[ $RUN != YES ]]; then echo \"$help\"; fi
          ;;
esac
EOF"
    #########################################
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib/pwa/tools"
    system "install -Dm755 pwashortcut #{CREW_DEST_PREFIX}/bin/pwashortcut"
    system "install -Dm644 installer.html #{CREW_DEST_PREFIX}/lib/pwa/templates/installer.html"
    system "install -m644 main.py.bak #{CREW_DEST_PREFIX}/lib/pwa/main.py"
    Dir.chdir("icon") do
      FileUtils.mv "brew_transparent_546x546.png", "brew.png"
    end
    FileUtils.mv "extension/", "#{HOME}/Downloads/extension/"
    FileUtils.mv Dir.glob('*'), "#{CREW_DEST_PREFIX}/lib/pwa/tools/"
  end
  def self.postinstall
      puts 
      puts "To complete the installation, execute the following:".lightblue
      puts "echo 'nohup pwashortcut -s &' >> ~/.bashrc".lightblue
      puts 
      puts "To complete the installation, install the exit extension by following:".lightgreen
      puts "Go to chrome://extensions/".lightgreen
      puts "Switch on Developer Mode".lightgreen
      puts "Click 'Load Unpacked'".lightgreen
      puts "Select the 'unpacked' folder under 'extension' in 'Downloads'".lightgreen
      puts "Copy the ID of the extension".lightgreen
      puts "Execute the following:".lightgreen
      puts "id=*REPLACE-WITH-YOUR-COPIED-ID*".lightgreen
      puts "sed -i \"s/eabaombiainalffcbinoffnbjeaefhle/$id/g\" #{CREW_PREFIX}/bin/pwashortcut".lightgreen
      puts "sed -i \"s/eabaombiainalffcbinoffnbjeaefhle/$id/g\" #{CREW_PREFIX}/lib/pwa/tools/*.sh".lightgreen
      puts
      puts "Run 'pwashortcut -h' for more usage of this package".lightblue
      puts 
  end
end
