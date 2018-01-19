require 'package'

class Liblapack < Package                 # The first character of the class name must be upper case
  description 'Lapack is a linear algebra package.'
  homepage 'http://www.netlib.org/lapack/#_lapack_version_3_8_0'
  version '3.8.0'
  source_url 'http://www.netlib.org/lapack/lapack-3.8.0.tar.gz'
  source_sha256 'deb22cc4a6120bff72621155a9917f485f96ef8319ac074a7afbc68aab88bcf6'   # Use the command "sha256sum"

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/liblapack-3.8.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/liblapack-3.8.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/liblapack-3.8.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/liblapack-3.8.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b0a873d5eae0a920c67c7fd7101b1c4d8f2486f46a553632b5bc1e3792618c6d',
     armv7l: 'b0a873d5eae0a920c67c7fd7101b1c4d8f2486f46a553632b5bc1e3792618c6d',
       i686: 'df07a794c858335da05f4ca3ad547d8aa86e4a5472035c32e83524288315ef6c',
     x86_64: '049da8a6932acae411f33f603ce0a4a2b1544cfda49627033068947f323cf36e',
  })

  depends_on 'cmake' => :build

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
    system "cmake .. -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_INSTALL_LIBDIR=#{CREW_DEST_LIB_PREFIX}"
    system "make"
    end
  end

  def self.install
    Dir.chdir 'build' do
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end  
end
