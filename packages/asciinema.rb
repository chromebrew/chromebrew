require 'buildsystems/rust'

class Asciinema < RUST
  description 'Terminal session recorder'
  homepage 'https://asciinema.org/'
  version '3.2.0'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/asciinema/asciinema.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '13de0cc11c3afa81a9381b584c0456eba73eb39c2bb28b23cf8da15318104d05',
     armv7l: '13de0cc11c3afa81a9381b584c0456eba73eb39c2bb28b23cf8da15318104d05',
       i686: 'e564ab489f6f89c4a57a3cd44d2962f9b70faf53b7a882624eac180743ed357d',
     x86_64: '43a6c8f3765a15f9cd835d80f26e00f996133624da73233e3ac4529bb0696bce'
  })

  depends_on 'gcc_lib' => :executable_only
  depends_on 'glibc' => :executable_only
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
