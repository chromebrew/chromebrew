require 'buildsystems/rust'

class Asciinema < RUST
  description 'Terminal session recorder'
  homepage 'https://asciinema.org/'
  version '3.1.0'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/asciinema/asciinema.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5904e59ee2743d01a7f9d791e68925db3bf96f23d9b018933156cfa4c0753c37',
     armv7l: '5904e59ee2743d01a7f9d791e68925db3bf96f23d9b018933156cfa4c0753c37',
       i686: 'b07ab36cb1b4a71a73f94694fa87bb2bd7bfc697792e9a131af19f4d73615bda',
     x86_64: '021f9a3fda92899c292dd0fc1134ce5a5827470147895abf1edba3d942730d08'
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
