require 'package'

class Liblapack < Package                 # The first character of the class name must be upper case
  description 'Lapack is a linear algebra package.'
  homepage 'http://www.netlib.org/lapack/#_lapack_version_3_8_0'
  version '3.8.0'
  source_url 'http://www.netlib.org/lapack/lapack-3.8.0.tar.gz'
  source_sha256 'deb22cc4a6120bff72621155a9917f485f96ef8319ac074a7afbc68aab88bcf6'   # Use the command "sha256sum"

  depends_on 'cmake' => :build

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
    system "cmake ..-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_INSTALL_LIBDIR=#{CREW_DEST_LIB_PREFIX}"
    system "make"
    end
  end

  def self.install
    Dir.chdir 'build' do
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end  
end
