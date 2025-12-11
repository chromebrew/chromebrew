require 'buildsystems/rust'

class Asciinema < RUST
  description 'Terminal session recorder'
  homepage 'https://asciinema.org/'
  version '3.0.1'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/asciinema/asciinema.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '99c98bb937becd11ed33a2e698825fccd57f57a7bf1eea9a4b159212537d38e6',
     armv7l: '99c98bb937becd11ed33a2e698825fccd57f57a7bf1eea9a4b159212537d38e6',
       i686: '0e93849e396c9686bef0a409c5f4330d2ffd4636087f3aedb84dba84b6dfa50e',
     x86_64: '6be54897e8e98b7baa45f0d33088a72828539308d8cbf55d084e25f2cbd46554'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3' => :build
  depends_on 'xdg_base'

  rust_build_extras do
    File.write 'config', <<~EOF
      [api]

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
      idle_time_limit = 1
    EOF
    FileUtils.install 'config', "#{CREW_DEST_HOME}/.config/asciinema/config", mode: 0o644
    FileUtils.touch "#{CREW_DEST_HOME}/.config/asciinema/install-id"
  end

  def self.postinstall
    ExitMessage.add "\nType 'asciinema' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.config/asciinema")
  end
end
