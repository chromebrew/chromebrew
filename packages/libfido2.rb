require 'package'

class Libfido2 < Package
  description 'Provides library functionality for FIDO 2.0, including communication with a device over USB.'
  homepage 'https://github.com/PJK/libcbor'
  version '1.8.0'
  license 'BSD 2-clause'
  compatibility 'all'
  source_url 'https://github.com/Yubico/libfido2/archive/refs/tags/1.8.0.tar.gz'
  source_sha256 '554291188f24ab595cb947f9d2b6ec40ce5afe39d9257c1e2cd0bdef8bf7fd1d'

  depends_on 'libcbor'
  depends_on 'openssl'
  depends_on 'zlibpkg'
  depends_on 'pkgconfig'
  depends_on 'eudev'
  depends_on 'cmake' => :build

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end

end
