require 'buildsystems/autotools'

class Rng_tools < Autotools
  description 'This is a random number generator daemon.'
  homepage 'https://github.com/nhorman/rng-tools'
  version '6.17'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/nhorman/rng-tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd7b5f20fa396372e95ba2d0d2b91b9b8eb9b3709a19ef7b1568e6635d35c2893',
     armv7l: 'd7b5f20fa396372e95ba2d0d2b91b9b8eb9b3709a19ef7b1568e6635d35c2893',
       i686: 'e659d4ce3cc795dc4e5363139a59fb743980474ab08fdd6cea2e2ca00623c761',
     x86_64: 'b79a50b975f89fea3325180247aa9a313a9ce4df0798f7c6c3afc7782a26d429'
  })

  depends_on 'curl' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'jansson' => :executable
  depends_on 'libcap' => :executable
  depends_on 'libgcrypt' => :executable
  depends_on 'libp11' => :executable
  depends_on 'librtlsdr' => :executable
  depends_on 'libxml2' => :executable
  depends_on 'openssl' => :executable
  depends_on 'psmisc' => :executable
  depends_on 'sysfsutils' => :executable

  print_source_bashrc

  autotools_build_extras do
    File.write 'startrngd', <<~EOF
      #!/bin/bash
      RNGD=#{CREW_PREFIX}/sbin/rngd
      RNG=$(pidof $RNGD 2> /dev/null)
      if [ -z "$RNG" ]; then
        sudo LD_LIBRARY_PATH=\$LD_LIBRARY_PATH rngd &>/dev/null
        sleep 3
      fi
      RNG=$(pidof $RNGD 2> /dev/null)
      if [ -n "$RNG" ]; then
        echo "rngd process $RNG is running"
      else
        echo "rngd failed to start"
        exit 1
      fi
    EOF

    File.write 'stoprngd', <<~EOF
      #!/bin/bash
      RNGD=#{CREW_PREFIX}/sbin/rngd
      RNG=$(pidof $RNGD 2> /dev/null)
      if [ -n "$RNG" ]; then
        sudo killall rngd
        sleep 3
      fi
      RNG=$(pidof $RNGD 2> /dev/null)
      if [ -z "$RNG" ]; then
        echo "rngd process stopped"
      else
        echo "rngd process $RNG is running"
        exit 1
      fi
    EOF

    File.write '10-startrngd', <<~EOF
      # start the rngd daemon
      if [ -f #{CREW_PREFIX}/bin/startrngd ]; then
        #{CREW_PREFIX}/bin/startrngd
      fi
    EOF
  end

  # Fix fatal error: p11_ver.h: No such file or directory
  autotools_make_options "CFLAGS='-I#{CREW_PREFIX}/include'"

  autotools_install_extras do
    FileUtils.install %w[startrngd stoprngd], "#{CREW_DEST_PREFIX}/bin/", mode: 0o755
    FileUtils.install '10-startrngd', "#{CREW_DEST_PREFIX}/etc/bash.d/10-startrngd", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add <<~EOM

      To start the rngd daemon, execute 'startrngd'

      To stop the rngd daemon, execute 'stoprngd'

      startrngd will be executed at login.
    EOM
  end
end
