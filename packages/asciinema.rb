require 'package'

class Asciinema < Package
  description 'Terminal session recorder'
  homepage 'https://asciinema.org/'
  version '2.1.0'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/asciinema/asciinema.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciinema/2.1.0_armv7l/asciinema-2.1.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciinema/2.1.0_armv7l/asciinema-2.1.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciinema/2.1.0_i686/asciinema-2.1.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/asciinema/2.1.0_x86_64/asciinema-2.1.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8ffc09b11883dbdfa8a6b3f3edca9ac2153d71caf0bd76618627b73267d8d375',
     armv7l: '8ffc09b11883dbdfa8a6b3f3edca9ac2153d71caf0bd76618627b73267d8d375',
       i686: '3cd8cff26adadf090b650b5009b1fae5347a3f5fd19fbaef71faa75080af040d',
     x86_64: '2111e78503836a4d1db5a71c436274f59dc54506c70903088af52864a7e2f3a6'
  })

  depends_on 'xdg_base'
  depends_on 'python3' => :build

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
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
    system "install -Dm644 config #{CREW_DEST_HOME}/.config/asciinema/config"
    system "touch #{CREW_DEST_HOME}/.config/asciinema/install-id"
  end
end
