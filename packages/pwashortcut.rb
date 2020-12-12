require 'package'

class Pwashortcut < Package
  description 'Scripts to create a PWA shortcut on ChromeOS dock for Chromebrew GUI Apps.'
  homepage 'https://github.com/supechicken666/pwashortcut/'
  version '1.1'
  source_url 'https://github.com/supechicken666/pwashortcut/archive/1.0-stable.tar.gz'
  source_sha256 '9e028cb35ce6b0ba840b476d4641be496686d4ee16c73935c48d1fb30ca70d07'

  def self.build
    system "pip install flask"
    system "cat <<'EOF'> main.py.bak
from flask import Flask, render_template, redirect, url_for, send_from_directory
import os

app = Flask(__name__)

EOF"
    #######################################
    system "cat <<'EOF'> installer.html.bak
<!DOCTYPE html>
<html>
<head>
<title>Shortcut Installer</title>
<link rel=\"manifest\" href=\"manifest.json\" />
</head>
<body style=\"background-color:powderblue;\">
    <h1>Shortcut Installer</h1>
    <p>Add Linux GUI App shortcut to your dock</p>
    <h2>HowTo</h2>
    <h3>Step 1</h3>
    <p>Click the ••• icon in the right corner of the screen</p>
    <h3>Step 2</h3>
    <p>Select 'Create shortcut...' under 'More tools'</p>
    <h3>Step 3</h3>
    <p>Tick the 'Open as window' checkbox</p>
    <h3>Step 4</h3>
    <p>Simply click the blue 'Create' button!</p>
    <h3>Step 5</h3>
    <p>Close this window and reopen it by the new shortcut</p>
    <h2>That's all:) </h2>
</body>
</html>
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
case ${1} in
    -h)
          echo  '
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
==================================='
          ;;
    -i)
          bash $tools/customize.sh -i
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
          echo \"    os.system('$2')\" >> $FLASK_APP
          echo \"    return 'You can close this window now'\" >> $FLASK_APP
          echo \"@app.route('/$2/')\" >> $FLASK_APP
          echo \"def installer_$2():\" >> $FLASK_APP
          echo \"    return render_template('installer.html')\" >> $FLASK_APP
          echo \"@app.route('/$2/<path:path>')\" >> $FLASK_APP
          echo \"def $2_path(path):\" >> $FLASK_APP
          echo \"    if path.endswith(('.png', 'manifest.json')):\" >> $FLASK_APP
          echo \"        return send_from_directory('$2/templates', path)\" >> $FLASK_APP
          echo \" \" >> $FLASK_APP
          #######################
          echo \"Shortcut for ${2^} deployed!\"
          echo \"Wait for server start and go to localhost:5000/$2/ for installing shortcut.\"
          sleep 2
          flask run
          ;;
    -s)
          flask run
          ;;
    *)
          while getopts \"p:y:f:*\" arg; do
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
                     break
                     ;;
              esac
          done
          if [[ $RUN != YES ]]; then pwashortcut -h; fi
          ;;
esac
EOF"
    #########################################
  end

  def self.install
    system "install -Dm755 pwashortcut #{CREW_PREFIX}/bin/pwashortcut"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib/pwa/templates"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib/pwa/tools/icon"
    FileUtils.cp "installer.html.bak", "#{CREW_DEST_PREFIX}/lib/pwa/templates/installer.html"
    FileUtils.cp "main.py.bak", "#{CREW_DEST_PREFIX}/lib/pwa/main.py"
    Dir.chdir("icon") do
      FileUtils.mv "brew_transparent_546x546.png", "brew.png"
      FileUtils.mv Dir.glob('*'), "#{CREW_DEST_PREFIX}/lib/pwa/tools/icon"
    end
    FileUtils.rm_rf "icon"
    FileUtils.mv Dir.glob('*'), "#{CREW_DEST_PREFIX}/lib/pwa/tools/"
  end
  def self.postinstall
      puts 
      puts "To complete the installation, execute the following:".lightblue
      puts "echo 'nohup pwashortcut &' >> ~/.bashrc".lightblue
      puts 
      puts "Run 'pwashortcut -h' for more usage of this package".lightblue
      puts 
  end
end
