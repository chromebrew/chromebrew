require 'package'

class Roswell < Package
  description 'A lisp installer and launcher for major environment.'
  homepage 'https://github.com/roswell/roswell'
  version '20.01.14.104'
  compatibility 'all'
  source_url 'https://github.com/roswell/roswell/archive/v20.01.14.104.tar.gz'
  source_sha256 '798b96fdcb8c89445b36692b31570bb99882d83719d6310d969ccfcb2a35a1d4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/roswell-20.01.14.104-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/roswell-20.01.14.104-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/roswell-20.01.14.104-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/roswell-20.01.14.104-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3c3a54706ecb418ded5e27b9672a6a11e29eaf778e0c6bb44b18ab16050ff463',
     armv7l: '3c3a54706ecb418ded5e27b9672a6a11e29eaf778e0c6bb44b18ab16050ff463',
       i686: '221ba9a7cadf7354584c53a200f9154b09e4cda6193a9bfa93fce1afed3a5369',
     x86_64: '4df5fe6db244b10c432cf45a5db394e7ccc2f25be37724a0e0ca436051bc0bbb',
  })

  depends_on 'brotli'
  depends_on 'curl'
  depends_on 'libcyrussasl'
  depends_on 'libnghttp2'
  depends_on 'openldap'
  depends_on 'rtmpdump'
  depends_on 'xdg_base'

  def self.build
    system 'sh bootstrap'
    system './configure', "--prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p CREW_DEST_HOME
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/.config/.roswell"
    FileUtils.ln_s "#{CREW_PREFIX}/.config/.roswell", "#{CREW_DEST_HOME}/.roswell"
  end

  def self.postinstall
    puts
    puts "To finish the installation, type 'ros'.".lightblue
    puts
    puts "To completely remove, execute the following:".lightblue
    puts "crew remove roswell".lightblue
    puts "rm -rf #{CREW_PREFIX}/.config/.roswell".lightblue
    puts
  end
end
