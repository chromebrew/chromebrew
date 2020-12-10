require 'package'

class Pwashortcut < Package
  description 'Scripts to create a PWA shortcut on ChromeOS dock for Chromebrew GUI Apps.'
  homepage 'https://github.com/supechicken666/pwashortcut/'
  version '1.0'
  source_url 'https://github.com/supechicken666/pwashortcut/raw/master/brew_transparent.png'
  source_sha256 'dedaa7b9dda61413ff03c823f035bebf5a006dc6a4c37eb8bbd27363e676fd56'

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
  \"display\"v4 \"minimal-ui\"v6
  \"start_url\"v4 \"unixapp.app\"v6
  \"theme_color\"v4 \"#000000\"v6
  \"background_color\"v4 \"#000000\"v6
  \"icons\"v4 v2
    v1
      \"src\"v4 \"brew.png\"v6
      \"sizes\"v4 \"200x200\"v6
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
export tools=$CREW_PREFIX/lib/pwa/tools
export PREFIX=$CREW_PREFIX/lib/pwa
export FLASK_APP=$PREFIX/main.py
export FLASK_ENV=development
pkill flask
if [[ $1 = '-h' ]]; then
    echo  '
===================================
    Shortcut Server Starter
  -s (Default option) Start shortcut server
  -n (App Name)       Make a new shortcut
  -h                  Show this message
  -p                  Set py script path
  -y                  Set PYTHONPATH
  -f                  Pass option to Flask
==================================='
elif [[ $1 = '-n' ]]; then
    mkdir $PREFIX/templates
    mkdir $PREFIX/$2
    mkdir $PREFIX/$2/templates
    cp -r $tools/* $PREFIX/$2/templates
    cp -r $tools/* $PREFIX/templates
    mv $PREFIX/templates/manifest.json.bak $PREFIX/templates/manifest.json
    mv $PREFIX/templates/installer.html.bak $PREFIX/templates/installer.html
    mv $PREFIX/$2/templates/manifest.json.bak $PREFIX/$2/templates/manifest.json
    mv $PREFIX/$2/templates/installer.html.bak $PREFIX/$2/templates/installer.html
    sed -i \"s/linuxapp/${2^}/g\" $PREFIX/$2/templates/manifest.json
    sed -i \"s/unixapp/$2/g\" $PREFIX/$2/templates/manifest.json
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
    echo \"    if path.endswith(('brew.png', 'manifest.json')):\" >> $FLASK_APP
    echo \"        return send_from_directory('$2/templates', path)\" >> $FLASK_APP
    echo \" \" >> $FLASK_APP
    #######################
    echo \"Shortcut for ${2^} deployed!\"
    echo \"Wait for server start and go to localhost:5000/$2/ for installing shortcut.\"
    sleep 2
    flask run
elif [[ $1 = '-s' ]]; then
    flask run
else
    while getopts \"p:y:f:*\" arg; do
        OPTARG=$(echo ${OPTARG} | sed 's/\=//')
        RUN=NO
        case ${arg} in
           p)
               echo $OPTARG
               export FLASK_APP=$OPTARG
               ;;
           y)
               echo $OPTARG
               export PYTHONPATH=$OPTARG
               ;;
           f)  
               RUN=YES
               flask run $OPTARG
               ;;
           *)  echo \"Error: unknown option '$arg'\"
               ;;
        esac
    done
    if [[ $RUN != YES ]]; then
      flask run
    fi
fi
EOF"
    #########################################
  end

  def self.install
    FileUtils.mkdir "#{CREW_PREFIX}/lib/pwa/" unless File.exists? "#{CREW_PREFIX}/lib/pwa/"
    FileUtils.mkdir "#{CREW_PREFIX}/lib/pwa/tools/" unless File.exists? "#{CREW_PREFIX}/lib/pwa/tools/"
    FileUtils.mv "../brew_transparent.png", "#{CREW_PREFIX}/lib/pwa/tools/brew.png"
    system "install -Dm755 pwashortcut #{CREW_PREFIX}/bin/pwashortcut"
    system "cp * #{CREW_PREFIX}/lib/pwa/tools/"
    FileUtils.mv "main.py.bak", "#{CREW_PREFIX}/lib/pwa/main.py"
  end
  def self.postinstall
      puts 
      puts "To complete the installation, execute the following:".lightblue
      puts "echo 'nohup pwashortcut &> /dev/null' >> ~/.bashrc".libhtblue
      puts 
      puts "Run 'pwashortcut -h' for more usage of this package".lightblue
      puts 
  end
end