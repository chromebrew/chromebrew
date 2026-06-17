require 'buildsystems/rust'

class Asciinema < RUST
  description 'Terminal session recorder'
  homepage 'https://asciinema.org/'
  version '3.2.1'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/asciinema/asciinema.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8b5ea29d7cd24fed975aa57485b0b53e0930180e269acd515867da9a281bd163',
     armv7l: '8b5ea29d7cd24fed975aa57485b0b53e0930180e269acd515867da9a281bd163',
       i686: '3d9bf5dbb6100585ab9e5760c1851bd611b26977e618fbd81c7f686db4a6b85a',
     x86_64: 'b3e43d4839b5c534ba27ce6c947299f36ad80f6ce19f33001d9c673cecbf137a'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
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
