require 'package'

class Dos2unix < Package
  description 'dos2unix includes utilities to convert text files with DOS or Mac line endings to Unix line endings and vice versa.'
  homepage 'http://freecode.com/projects/dos2unix'
  version '7.3.5'
  source_url 'https://downloads.sourceforge.net/project/dos2unix/dos2unix/7.3.5/dos2unix-7.3.5.tar.gz'
  source_sha256 'a72caa2fb5cb739403315472fe522eda41aabab2a02ad6f5589639330af262e5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dos2unix-7.3.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dos2unix-7.3.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dos2unix-7.3.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dos2unix-7.3.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '08909d923f63f79847ddcd923c1b4d92e5d666661833c51e776b1d37467e3fc9',
     armv7l: '08909d923f63f79847ddcd923c1b4d92e5d666661833c51e776b1d37467e3fc9',
       i686: 'b4469a6fdbfe6806d62be2b1c19137c522fb3481e00424af43e82be7d15aa259',
     x86_64: '1ccebaca6f44e1d5dc75e172c7c8acd34844c0e34a9a6f69df0e5ebe2bab08e9',
  })

  depends_on 'gettext' => :build

  def self.build
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp dos2unix #{CREW_DEST_DIR}/usr/local/bin"
    system "cp mac2unix #{CREW_DEST_DIR}/usr/local/bin"
    system "cp unix2dos #{CREW_DEST_DIR}/usr/local/bin"
    system "cp unix2mac #{CREW_DEST_DIR}/usr/local/bin"
  end
end
