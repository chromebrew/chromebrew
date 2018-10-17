require 'package'

class Rng_tools < Package
  description 'This is a random number generator daemon.'
  homepage 'https://github.com/nhorman/rng-tools'
  version '6.5'
  source_url 'https://github.com/nhorman/rng-tools/archive/v6.5.tar.gz'
  source_sha256 '5fecd904f7d01262b3209ff78dd3b9594aac8daa41badd5a1e6438658e80c36e'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'curl'
  depends_on 'libgcrypt'
  depends_on 'sysfsutils'
  depends_on 'psmisc'

  def self.build
    system './autogen.sh'
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
    system "echo '#!/bin/bash' > startrngd"
    system "echo 'RNGD=#{CREW_PREFIX}/sbin/rngd' >> startrngd"
    system "echo 'RNG=\$(pidof \$RNGD 2> /dev/null)' >> startrngd"
    system "echo 'if [ -z \"\$RNG\" ]; then' >> startrngd"
    system "echo '  sudo LD_LIBRARY_PATH=\$LD_LIBRARY_PATH rngd &>/dev/null' >> startrngd"
    system "echo '  sleep 3' >> startrngd"
    system "echo 'fi' >> startrngd"
    system "echo 'RNG=\$(pidof \$RNGD 2> /dev/null)' >> startrngd"
    system "echo 'if [ ! -z \"\$RNG\" ]; then' >> startrngd"
    system "echo '  echo \"rngd process \$RNG is running\"' >> startrngd"
    system "echo 'else' >> startrngd"
    system "echo '  echo \"rngd failed to start\"' >> startrngd"
    system "echo '  exit 1' >> startrngd"
    system "echo 'fi' >> startrngd"
    system "echo '#!/bin/bash' > stoprngd"
    system "echo 'RNGD=#{CREW_PREFIX}/sbin/rngd' >> stoprngd"
    system "echo 'RNG=\$(pidof \$RNGD 2> /dev/null)' >> stoprngd"
    system "echo 'if [ ! -z \"\$RNG\" ]; then' >> stoprngd"
    system "echo '  sudo killall rngd' >> stoprngd"
    system "echo '  sleep 3' >> stoprngd"
    system "echo 'fi' >> stoprngd"
    system "echo 'RNG=\$(pidof \$RNGD 2> /dev/null)' >> stoprngd"
    system "echo 'if [ -z \"\$RNG\" ]; then' >> stoprngd"
    system "echo '  echo \"rngd process stopped\"' >> stoprngd"
    system "echo 'else' >> stoprngd"
    system "echo '  echo \"rngd process \$RNG is running\"' >> stoprngd"
    system "echo '  exit 1' >> stoprngd"
    system "echo 'fi' >> stoprngd"
    system "chmod a+x startrngd stoprngd"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "cp", "startrngd", "stoprngd", "#{CREW_DEST_PREFIX}/bin/"
  end

  def self.postinstall
    puts
    puts "To start the rngd daemon, execute the following:".lightblue
    puts "startrngd".lightblue
    puts
    puts "To stop the rngd daemon, execute the following:".lightblue
    puts "stoprngd".lightblue
    puts
    puts "To start the rngd daemon at login, execute the following:".lightblue
    puts "echo '# start the rngd daemon' >> ~/.bashrc".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/bin/startrngd ]; then' >> ~/.bashrc".lightblue
    puts "echo '  #{CREW_PREFIX}/bin/startrngd' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
