require 'package'

class Asciinema < Package
  description 'Terminal session recorder'
  homepage 'https://asciinema.org/'
  version '2.0.2-1'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/asciinema/asciinema/archive/v2.0.2.tar.gz'
  source_sha256 '2578a1b5611e5375771ef6582a6533ef8d40cdbed1ba1c87786fd23af625ab68'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/asciinema-2.0.2-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/asciinema-2.0.2-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/asciinema-2.0.2-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/asciinema-2.0.2-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '5fddd233f9f093935c23574dc1ce6247103352e845408375fa537fd2f56675ec',
     armv7l: '5fddd233f9f093935c23574dc1ce6247103352e845408375fa537fd2f56675ec',
       i686: '82f850655844133b11a251428021f9d92904b6c733f68cd3f6f827987fc072ee',
     x86_64: 'e2bbf8e05f6762432da17259edba89f86f28d8c145de74adc057eb1d253eae90'
  })

  depends_on 'xdg_base'
  depends_on 'setuptools'

  def self.build
    system "echo '[api]

; API server URL, default: https://asciinema.org
; If you run your own instance of asciinema-server then set its address here
; It can also be overridden by setting ASCIINEMA_API_URL environment variable
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
end
