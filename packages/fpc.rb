require 'package'

class Fpc < Package
  description 'Free Pascal is a 32, 64 and 16 bit professional Pascal compiler.'
  homepage 'https://www.freepascal.org/'
  version '3.0.4'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686'
    source_url 'http://downloads.sourceforge.net/project/freepascal/Linux/3.0.4/fpc-3.0.4.i386-linux.tar'
    source_sha256 'aa6da9a58d155bbaa71aaa7f414d64b02b3e450dc23eed7c161eac6d547fae17'
  when 'x86_64'
    source_url 'http://downloads.sourceforge.net/project/freepascal/Linux/3.0.4/fpc-3.0.4.x86_64-linux.tar'
    source_sha256 '7e965baf13c9822a0ff39e7bbfa040bd5599e94d0f3338f1ac4efa989081fd77'
  end

  def self.build
    system "sed -i 's,PREFIX=\"\$HOME/fpc-\$VERSION\",PREFIX=#{CREW_DEST_PREFIX},' install.sh"
    system "sed -i '264,272d' install.sh"
  end

  def self.install
    system './install.sh'
  end

  def self.postinstall
    puts
    puts "Type 'fp' to start.".lightblue
    puts
  end
end
