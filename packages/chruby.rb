require 'package'

class Chruby < Package
  description 'Changes the current Ruby'
  homepage 'https://github.com/postmodern/chruby'
  version '0.3.9-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz'
  source_sha256 '7220a96e355b8a613929881c091ca85ec809153988d7d691299e0a16806b42fd'
  binary_compression 'tar.xz'

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
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/chruby", @chrubyenv)
  end
end
