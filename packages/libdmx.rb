require 'package'

class Libdmx < Package
  description 'X.org X Window System DMX (Distributed Multihead X) extension library'
  homepage 'http://www.x.org'
  version '1.1.3-0'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libdmx-1.1.3.tar.gz'
  source_sha256 'c4b24d7e13e5a67ead7a18f0b4cc9b7b5363c9d04cd01b83b5122ff92b3b4996'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdmx-1.1.3-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdmx-1.1.3-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdmx-1.1.3-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdmx-1.1.3-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ac58dc16bc412a006f1c83d8c9ef3c0d6bba2fd0563165afab785f3754b15908',
     armv7l: 'ac58dc16bc412a006f1c83d8c9ef3c0d6bba2fd0563165afab785f3754b15908',
       i686: 'c943c38df5f29ba6f10e4c215437277b60be511da23e536292ef219971be8522',
     x86_64: 'afefd087d3752574ab61951788c05452944239c1b797753381c69ffb88a93e13',
  })

  depends_on 'libxext'
  depends_on 'libx11'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
