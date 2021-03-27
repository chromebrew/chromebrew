require 'package'

class Chruby < Package
  description 'Changes the current Ruby'
  homepage 'https://github.com/postmodern/chruby'
  version '0.3.9-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz'
  source_sha256 '7220a96e355b8a613929881c091ca85ec809153988d7d691299e0a16806b42fd'

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # chruby configuration
      source #{CREW_PREFIX}/share/chruby/chruby.sh
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/chruby", @env)
  end
end
