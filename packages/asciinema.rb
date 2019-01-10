require 'package'

class Asciinema < Package
  description 'Terminal session recorder'
  homepage 'https://asciinema.org/'
  version '2.0.1-2'
  source_url 'https://github.com/asciinema/asciinema/archive/v2.0.1.tar.gz'
  source_sha256 '7087b247dae36d04821197bc14ebd4248049592b299c9878d8953c025ac802e4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/asciinema-2.0.1-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/asciinema-2.0.1-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/asciinema-2.0.1-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/asciinema-2.0.1-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6b5ea0249de2ca8b44e974316799eba90b7190c43720ba2b9625cec134085318',
     armv7l: '6b5ea0249de2ca8b44e974316799eba90b7190c43720ba2b9625cec134085318',
       i686: '699f103391c9d5925dcc2b85ffa4d15348249e0ca033234c904bcec2ebd3c16c',
     x86_64: '550a06b4dbdd3662852bc78036fc632e2407f5a47d582489b3d539f11b7ac259',
  })

  depends_on 'xdg_base'
  depends_on 'setuptools'

  def self.build
    system "echo '[api]

; API server URL, default: https://asciinema.org
; If you run your own instance of asciinema-server then set its address here
; It can also be overriden by setting ASCIINEMA_API_URL environment variable
;url = https://asciinema.example.com

[record]

; Command to record, default: \$SHELL
command = /bin/bash -l

; Enable stdin (keyboard) recording, default: no
stdin = yes

; List of environment variables to capture, default: SHELL,TERM
env = SHELL,TERM,USER

; Limit recorded terminal inactivity to max n seconds, default: off
idle_time_limit = 2

; Answer \"yes\" to all interactive prompts, default: no
yes = true

; Be quiet, suppress all notices/warnings, default: no
quiet = true

[play]

; Playback speed (can be fractional), default: 1
speed = 2

; Limit replayed terminal inactivity to max n seconds, default: off
idle_time_limit = 1' > config"
  end

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system "install -Dm644 config #{CREW_DEST_HOME}/.config/asciinema/config"
    system "touch #{CREW_DEST_HOME}/.config/asciinema/install-id"
  end

  def self.postinstall
    puts
    puts "To finish the installation, execute the following:".lightblue
    puts "echo 'export LC_ALL=en_US.utf8' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts
    puts "The configuration file is located at $HOME/.config/asciinema/config".lightblue
    puts
  end
end
