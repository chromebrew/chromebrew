require 'package'

class Libproxy < Package
  description 'libproxy is a library that provides automatic proxy configuration management.'
  homepage 'https://libproxy.github.io/libproxy/'
  @_ver = '0.4.17'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/libproxy/libproxy.git'
  git_hashtag @_ver

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libproxy/0.4.17_i686/libproxy-0.4.17-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libproxy/0.4.17_x86_64/libproxy-0.4.17-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: '43aede3ba83cc73fb0cbe8040e8e0c36db419bee4932550eae31cf004351af07',
  x86_64: '4b2a329496d51d6ef1c97bb30cf5530af784800c2df634abbae428f6cca4a04c'
  })

  depends_on 'dbus'
  depends_on 'vala' => :build
  depends_on 'glib'

  # ninja/samu doesn't work, makefiles do.
  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      # system "cmake -G Ninja #{CREW_CMAKE_OPTIONS} .."
      system "cmake -G 'Unix Makefiles' #{CREW_CMAKE_OPTIONS} \
              -DLIBEXEC_INSTALL_DIR=#{CREW_LIB_PREFIX} \
              -DLIB_INSTALL_DIR=#{CREW_LIB_PREFIX} \
              -DWITH_DBUS=ON \
              -DWITH_DOTNET=OFF \
              -DWITH_DUKTAPE=OFF \
              -DWITH_GNOME3=ON \
              -DWITH_KDE=ON \
              -DWITH_MOZJS=OFF \
              -DWITH_NATUS=OFF \
              -DWITH_NM=OFF \
              -DWITH_PERL=ON \
              -DWITH_PYTHON2=ON \
              -DWITH_PYTHON3=ON \
              -DWITH_VALA=ON \
              -DWITH_WEBKIT=OFF \
              -DWITH_WEBKIT3=ON \
              -DPERL_VENDORINSTALL=ON \
              -DBIPR=OFF \
              -Wno-dev .."
      system 'make'
    end
    # system 'samu -C builddir'
  end

  def self.install
    # system "samu -C builddir install"
    Dir.chdir 'builddir' do system "make DESTDIR=#{CREW_DEST_DIR} install" end
  end

  def self.check
    # system "samu -C builddir test"
    Dir.chdir 'builddir' do system 'make test' end
  end
end
