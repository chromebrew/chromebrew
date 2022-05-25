require 'package'

class Glm < Package
  description 'OpenGL Mathematics (GLM) is a header only C++ mathematics library for graphics software based on the OpenGL Shading Language (GLSL) specifications.'
  homepage 'http://glm.g-truc.net/'
  version '0.9.9.3'
  license 'HappyBunny or MIT'
  compatibility 'all'
  source_url 'https://github.com/g-truc/glm/releases/download/0.9.9.3/glm-0.9.9.3.zip'
  source_sha256 '496e855590b8aa138347429b7fc745d66707303fb82c1545260d1888472e137b'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glm/0.9.9.3_armv7l/glm-0.9.9.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glm/0.9.9.3_armv7l/glm-0.9.9.3-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glm/0.9.9.3_i686/glm-0.9.9.3-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glm/0.9.9.3_x86_64/glm-0.9.9.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd8d4e1467c5a2627cd97b70bdcc4b7f755e19aa2f201f7d69f0119ec2c25c014',
     armv7l: 'd8d4e1467c5a2627cd97b70bdcc4b7f755e19aa2f201f7d69f0119ec2c25c014',
       i686: 'b12e5fb4a67ea8cb4c349b433d34feb250f73b7e243513ec8b6ed02bae9c9ee5',
     x86_64: '924036ad0453354eb0b2dc61405795022b8c25b9cd230592984b8dc1e4615882'
  })

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_INSTALL_LIBDIR=#{ARCH_LIB} .."
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
