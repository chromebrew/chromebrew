require 'package'

class Chruby < Package
  description 'Changes the current Ruby'
  homepage 'https://github.com/postmodern/chruby'
  version '0.3.9-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz'
  source_sha256 '7220a96e355b8a613929881c091ca85ec809153988d7d691299e0a16806b42fd'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/chruby-0.3.9-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/chruby-0.3.9-1-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/chruby-0.3.9-1-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/chruby-0.3.9-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7815a4b47a82634d0a68f89d1bfe8b66f413ce68665696101032f1fb81531ee3',
     armv7l: '7815a4b47a82634d0a68f89d1bfe8b66f413ce68665696101032f1fb81531ee3',
       i686: '9196e553c0592330237bf487ac31688b759262f4900afdd96daed804b2041972',
     x86_64: 'e8b096839ebbcfb351367aef74d53d3c1aeae6c8b166024971b6cdcac178d62b'
  })

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @chrubyenv = <<~CHRUBYEOF
      # chruby configuration
      source #{CREW_PREFIX}/share/chruby/chruby.sh
    CHRUBYEOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/chruby", @chrubyenv)
  end
end
