require 'package'

class Weechat < Package
  description "WeeChat is a fast, light and extensible chat client."
  homepage 'http://www.weechat.org/'
  version '2.1'
  compatibility 'all'
  source_url 'https://weechat.org/files/src/weechat-2.1.tar.xz'
  source_sha256 'cda0f81ff8243fd25cca76c8e490e2fdb5b8fbb2554d7aa87cb3b0beda16ed38'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/weechat-2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/weechat-2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/weechat-2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/weechat-2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9b00d99af938abc66093f1b64287d71502a3d4967530d4d5f7e55756ba6fc00e',
     armv7l: '9b00d99af938abc66093f1b64287d71502a3d4967530d4d5f7e55756ba6fc00e',
       i686: '31ef7d36a76b8b41bcd2f1a352adcd20456deccc4ed2e452e882223c32b67ba3',
     x86_64: '4ab72526832466b8d2166ab093951fe87cf2e4faba1e29361c95c6bc966210bd',
  })

  depends_on 'libgcrypt'
  depends_on 'aspell' => :build
  depends_on 'curl' => :build
  depends_on 'lua' => :build
  depends_on 'tcl' => :build

  def self.build
    system 'cmake',
           "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
           '-DCMAKE_BUILD_TYPE=Release',
           '-DENABLE_MAN=ON',
           "-DPYTHON_EXECUTABLE=#{CREW_PREFIX}/bin/python2"
    system 'make'
  end

  def self.install
    system 'make', "LIBDIR=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
