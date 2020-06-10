require 'package'

class Chruby < Package
  description 'Changes the current Ruby'
  homepage 'https://github.com/postmodern/chruby'
  version '0.3.9'
  compatibility 'all'
  source_url 'https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz'
  source_sha256 '7220a96e355b8a613929881c091ca85ec809153988d7d691299e0a16806b42fd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/chruby-0.3.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/chruby-0.3.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/chruby-0.3.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/chruby-0.3.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dbd2de39de5e82f32af9659ff2b13827f06d4b6921c69bc2f7c8a2601f505257',
     armv7l: 'dbd2de39de5e82f32af9659ff2b13827f06d4b6921c69bc2f7c8a2601f505257',
       i686: '180c8642ca54c7372f4ddba770bec5791b3b158edbf91e1482330d5b523c3d81',
     x86_64: 'b33bbb7216f5599f57b1a19e0db653345199a8818e27e41944f2b46fc580bc2d',
  })

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.postinstall
    puts
    puts "To finish the installation, execute the following:".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/share/chruby/chruby.sh ]; then' >> ~/.bashrc".lightblue
    puts "echo '  source #{CREW_PREFIX}/share/chruby/chruby.sh' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
