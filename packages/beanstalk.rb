require 'package'

class Beanstalk < Package
  version '1.10'
  source_url 'https://github.com/kr/beanstalkd/archive/v1.10.tar.gz'
  source_sha1 'bfc0ccf99e15b15eac03ec1d8a57a3aaff143237'

  def self.build
    system "CC=\"gcc -m#{SHORTARCH}\" CFLAGS=\" -fPIC\" make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
