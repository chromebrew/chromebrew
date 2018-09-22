require 'package'

class Asciinema < Package
  description 'Terminal session recorder'
  homepage 'https://asciinema.org/'
  version '2.0.1-1'
  source_url 'https://github.com/asciinema/asciinema/archive/v2.0.1.tar.gz'
  source_sha256 '7087b247dae36d04821197bc14ebd4248049592b299c9878d8953c025ac802e4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/asciinema-2.0.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/asciinema-2.0.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/asciinema-2.0.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/asciinema-2.0.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1b68a9d19e2f7f129b92f53b9c273e4a69f284539d82f216f108bbf49143d2d2',
     armv7l: '1b68a9d19e2f7f129b92f53b9c273e4a69f284539d82f216f108bbf49143d2d2',
       i686: 'f81954e9851f5b839cbee7f58d6b723d8028f2dcc6b2bdf0f6838521a592dc62',
     x86_64: 'f048f3f93709373d8b21456c829eccdb8f1059136e1b0371b04bc8fa4ef42046',
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
    system "install -Dm644 config $HOME/.config/asciinema/config"
    system "touch #{CREW_DEST_HOME}/.config/asciinema/install-id"
    system "touch $HOME/.config/asciinema/install-id"
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
