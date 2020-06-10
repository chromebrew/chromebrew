require 'package'

class Asciinema < Package
  description 'Terminal session recorder'
  homepage 'https://asciinema.org/'
  version '2.0.2'
  compatibility 'all'
  source_url 'https://github.com/asciinema/asciinema/archive/v2.0.2.tar.gz'
  source_sha256 '2578a1b5611e5375771ef6582a6533ef8d40cdbed1ba1c87786fd23af625ab68'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/asciinema-2.0.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/asciinema-2.0.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/asciinema-2.0.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/asciinema-2.0.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '325ec978e978222c0b052a9e57223f2c2d70ab3ed47f8a0774332b73fa842784',
     armv7l: '325ec978e978222c0b052a9e57223f2c2d70ab3ed47f8a0774332b73fa842784',
       i686: '165db28c4c80d8779e6d869a363b2ec0f3b6242fe21320cd0bc93a5e478484ff',
     x86_64: '30dac19c7fce14e9f1ab63a94bb312f2e9e93abcf7d237879b6a3e800dd8be23',
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
