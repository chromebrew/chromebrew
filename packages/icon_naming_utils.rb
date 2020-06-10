require 'package'

class Icon_naming_utils < Package
  description 'Icon naming utils'
  homepage 'http://tango-project.org/'
  version '0.8.90'
  compatibility 'all'
  source_url 'https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/icon-naming-utils/0.8.90-2/icon-naming-utils_0.8.90.orig.tar.gz'
  source_sha256 '044ab2199ed8c6a55ce36fd4fcd8b8021a5e21f5bab028c0a7cdcf52a5902e1c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/icon_naming_utils-0.8.90-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/icon_naming_utils-0.8.90-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/icon_naming_utils-0.8.90-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/icon_naming_utils-0.8.90-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7fce9929e3b4b040a53ae826ca30a36aac334ce4a4b8cfa2d31b105be7fa70a3',
     armv7l: '7fce9929e3b4b040a53ae826ca30a36aac334ce4a4b8cfa2d31b105be7fa70a3',
       i686: '33875835a122f6f17d17e9868a1232fcef80b1940bc3d14eb323762ae06cab9d',
     x86_64: '5e38dafcae1a96aee3eefef7bb27f34b60feff8650c098afec706e360f579e57',
  })

  depends_on 'perl_xml_simple'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
