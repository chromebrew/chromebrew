require 'package'

class Libcbor < Package
  description 'CBOR Protocol implementation for C and others'
  homepage 'https://github.com/PJK/libcbor'
  version '0.8.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/PJK/libcbor/archive/0.8.0.tar.gz'
  source_sha256 '618097166ea4a54499646998ccaa949a5816e6a665cf1d6df383690895217c8b'

  depends_on 'cmake' => :build

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             '-DWITH_EXAMPLES=OFF',
             '-DBUILD_SHARED_LIBS=ON',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '..'
      system "make"
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end

end
