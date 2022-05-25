require 'package'

class Double_conversion < Package
  description 'Efficient binary-decimal and decimal-binary conversion routines for IEEE doubles.'
  homepage 'https://github.com/google/double-conversion'
  version '3.1.5'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/google/double-conversion/archive/v3.1.5.tar.gz'
  source_sha256 'a63ecb93182134ba4293fd5f22d6e08ca417caafa244afaa751cbfddf6415b13'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/double_conversion/3.1.5_armv7l/double_conversion-3.1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/double_conversion/3.1.5_armv7l/double_conversion-3.1.5-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/double_conversion/3.1.5_i686/double_conversion-3.1.5-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/double_conversion/3.1.5_x86_64/double_conversion-3.1.5-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '30e4c14b0f6e37c9fbe05f14838e57fc9fccd9f9f79681a062012ca3114e9786',
     armv7l: '30e4c14b0f6e37c9fbe05f14838e57fc9fccd9f9f79681a062012ca3114e9786',
       i686: 'd378fa884903a2839320b2d45920cfb929fb4b9f3de7719f7bfb55c406e04730',
     x86_64: 'db6e20068fb804648d04f21244a9dc9abcc4e36e9aaeb48038e39f51039f845a'
  })

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             '-DCMAKE_BUILD_TYPE=Release',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '-DBUILD_SHARED_LIBS=ON',
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
