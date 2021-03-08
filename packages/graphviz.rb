require 'package'

class Graphviz < Package
  description 'Graphviz is open source graph visualization software.'
  homepage 'https://www.graphviz.org/'
  @_ver = '2.46.1'
  version @_ver
  compatibility 'all'
  source_url "https://gitlab.com/graphviz/graphviz/-/archive/#{@_ver}/graphviz-#{@_ver}.tar.bz2"
  source_sha256 'e5d7580b3dfcbeb0b86f28dd3c2df76f32086bb428f67c8ae8512e5fd969324d'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.46.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.46.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.46.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.46.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd0cef37f5ff984c4dd87a9c8c99fca254b19764bd898b46a79665668dc812857',
     armv7l: 'd0cef37f5ff984c4dd87a9c8c99fca254b19764bd898b46a79665668dc812857',
       i686: '39f81cec1ac499d981af16aa448e0130a71a4ea5ac8d28eeee19a920d8366bd1',
     x86_64: '23ee20353fee590a3fe35c5185c0404c32f6f82749b2ecf612b8658f21c5ebdb'
  })

  depends_on 'libgd'
  depends_on 'pango'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -I#{CREW_PREFIX}/include/harfbuzz' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      AWK=#{CREW_PREFIX}/bin/mawk \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    Dir.chdir CREW_DEST_PREFIX do
      FileUtils.mv 'lib', 'lib64' if ARCH == 'x86_64'
    end
  end
end
