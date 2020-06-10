require 'package'

class Kwiml < Package
  description 'The Kitware Information Macro Library'
  homepage 'https://gitlab.kitware.com/utils/kwiml'
  version 'a079af'
  compatibility 'all'
  source_url 'https://gitlab.kitware.com/utils/kwiml/-/archive/a079afc646f46b81686676bec91fb0a8e3799e4a/kwiml-a079afc646f46b81686676bec91fb0a8e3799e4a.tar.bz2'
  source_sha256 '09607a32224091cb6deb605382772c69a4f51d16a5ccf065688e6e7d80e6f822'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/kwiml-a079af-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/kwiml-a079af-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/kwiml-a079af-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/kwiml-a079af-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0198974f4a579f5aadb1b2174690fc79d9deb1b7690e732d35f35214c687c4b1',
     armv7l: '0198974f4a579f5aadb1b2174690fc79d9deb1b7690e732d35f35214c687c4b1',
       i686: '636483cc21d186203c0cbe42ae760503567b42acc74ff047efae25edb34ad8be',
     x86_64: '231ad1f9a5968390ad1ad72dd39df1c218711ba61306f3f5596a93722dad8ae6',
  })

  def self.build
    system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_BUILD_TYPE=Release"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
