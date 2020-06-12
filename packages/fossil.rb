require 'package'

class Fossil < Package
  description 'Fossil is a simple, high-reliability, distributed software configuration management system'
  homepage 'http://www.fossil-scm.org/index.html/doc/trunk/www/index.wiki'
  version '2.6'
  compatibility 'all'
  source_url 'https://www.fossil-scm.org/fossil/uv/fossil-src-2.6.tar.gz'
  source_sha256 '76a794555918be179850739a90f157de0edb8568ad552b4c40ce186c79ff6ed9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fossil-2.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fossil-2.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fossil-2.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fossil-2.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1888721a262e9a4232f91ff46a1700d8e024969475f01bc769f5d04f2a00567d',
     armv7l: '1888721a262e9a4232f91ff46a1700d8e024969475f01bc769f5d04f2a00567d',
       i686: '944890663fabbff3fe75f23d3dda5c2ab2b865e8f5545cce3e69d1c1c38998ae',
     x86_64: 'e3de20c2f0f7d49d2cac73d9076fd866d8df5f781105473b15107fcc3c45b69d',
  })

  depends_on 'fuse'
  depends_on 'sqlite'

  def self.build
    system "bash configure --prefix=#{CREW_PREFIX}"
    system 'make'
    system 'gzip -9 fossil.1'
  end

  def self.install
    system "install -Dm755 fossil #{CREW_DEST_PREFIX}/bin/fossil"
    system "install -Dm644 fossil.1.gz #{CREW_DEST_PREFIX}/share/man/man1/fossil.1.gz"
  end
end
