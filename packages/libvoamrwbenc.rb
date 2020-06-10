require 'package'

class Libvoamrwbenc < Package
  description 'Audio codecs extracted from Android Open Source Project.'
  homepage 'https://sourceforge.net/projects/opencore-amr/'
  version '0.1.3-0'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/opencore-amr/vo-amrwbenc/vo-amrwbenc-0.1.3.tar.gz'
  source_sha256 '5652b391e0f0e296417b841b02987d3fd33e6c0af342c69542cbb016a71d9d4e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libvoamrwbenc-0.1.3-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libvoamrwbenc-0.1.3-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libvoamrwbenc-0.1.3-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libvoamrwbenc-0.1.3-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '983297522b623ee92bc5886479b85636cd88ef5f67d36da4a4ea0b2374583cb7',
     armv7l: '983297522b623ee92bc5886479b85636cd88ef5f67d36da4a4ea0b2374583cb7',
       i686: 'bf93b9324bc99471aea25f4c2e36f24db682114a394e09c536fae23b95cd0b6d',
     x86_64: '10da147ed2bd9987882cd7dcaf9a755c1e8395a9719a3caed66710d7d4e8d332',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
