require 'package'

class Siege < Package
  description 'Siege is an http load testing and benchmarking utility.'
  homepage 'https://www.joedog.org/siege-home/'
  version '4.0.4'
  source_url 'http://download.joedog.org/siege/siege-4.0.4.tar.gz'
  source_sha256 '8f7dcf18bd722bb9cc92bc3ea4b59836b4a2f8d8f01d4a94c8d181f56d91ea6f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/siege-4.0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/siege-4.0.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/siege-4.0.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/siege-4.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '626dab09c5fe3682c416e379c3f3e3115f46658a0b1094786a3932afcc3286df',
     armv7l: '626dab09c5fe3682c416e379c3f3e3115f46658a0b1094786a3932afcc3286df',
       i686: '35b04a8f7c6a5fa298f617c9f6a3a1f387a0b2580504e493b6001a5bce96a6ef',
     x86_64: '3b56b8491da7d50beaa5b8cad9c481c99fabe8e7f04368a93025af8fd0619e8f',
  })

  depends_on 'compressdoc' => :build
  depends_on 'diffutils' => :build
  depends_on 'openssl'
  depends_on 'perl'
  depends_on 'zlibpkg'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
  end
end
