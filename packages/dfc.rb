require 'package'

class Dfc < Package
  description 'dfc displays file system space usage using graphs and colors.'
  homepage 'https://projects.gw-computing.net/projects/dfc'
  version '3.1.1'
  compatibility 'all'
  source_url 'https://projects.gw-computing.net/attachments/download/615/dfc-3.1.1.tar.gz'
  source_sha256 '962466e77407dd5be715a41ffc50a54fce758a78831546f03a6bb282e8692e54'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dfc-3.1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dfc-3.1.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dfc-3.1.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dfc-3.1.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7ba375108b50a370f81a2916ae8636234470ccbdf20283146b5f9564513e0eca',
     armv7l: '7ba375108b50a370f81a2916ae8636234470ccbdf20283146b5f9564513e0eca',
       i686: 'dbd797ee89ac51aa65dbff47db4bbc6fe7d5c7a4b29cb98da5a54e0985ba95d9',
     x86_64: '9dccac46a97222d4f89002c7c5a8bc97b7b1d237b79a53251e03fdf9f4ff17e3',
  })

  depends_on 'cmake' => :build
  depends_on 'gettext'

  def self.build
    system "cmake . -DPREFIX=#{CREW_PREFIX} -DCMAKE_BUILD_TYPE=RELEASE"
  end

  def self.install
    system  "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
