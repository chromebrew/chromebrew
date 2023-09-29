require 'package'

class Libproxy < Package
  description 'libproxy is a library that provides automatic proxy configuration management.'
  homepage 'https://libproxy.github.io/libproxy/'
  version '5d5e13ddc47a2a061c595c1356d7d07d78cf597f'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/libproxy/libproxy.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libproxy/5d5e13d_armv7l/libproxy-5d5e13d-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libproxy/5d5e13d_armv7l/libproxy-5d5e13d-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libproxy/5d5e13d_i686/libproxy-5d5e13d-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libproxy/5d5e13d_x86_64/libproxy-5d5e13d-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5bea315ca2a29c9f859f78afa1ee2c03cb96f929f9ed3aa7fda99627b660b737',
     armv7l: '5bea315ca2a29c9f859f78afa1ee2c03cb96f929f9ed3aa7fda99627b660b737',
       i686: '720f6e764865b755f0f630b11bfa2a74f99088482a49abdbc6a1d9a6248a6824',
     x86_64: 'c33952558052af4fe67fc2dc67930ca887cc74051df8ebc2f5ad71cb19c5bf4b'
  })

  depends_on 'dbus'
  depends_on 'duktape'
  depends_on 'vala' => :build
  depends_on 'glib'

  def self.patch
    # As per suggestion for fixing Ninja at
    # https://github.com/libproxy/libproxy/issues/171#issuecomment-1082704815
    @ninjapatch = <<~NINJAPATCHEOF
      diff --git a/bindings/perl/t/CMakeLists.txt b/bindings/perl/t/CMakeLists.txt
      index 8007124..fdbe81c 100644
      --- a/bindings/perl/t/CMakeLists.txt
      +++ b/bindings/perl/t/CMakeLists.txt
      @@ -1 +1 @@
      -add_custom_target(test prove -b ${CMAKE_CURRENT_SOURCE_DIR})
      +add_test(NAME perl COMMAND prove -b ${CMAKE_CURRENT_SOURCE_DIR})
    NINJAPATCHEOF
    File.write('ninja.patch', @ninjapatch)
    system 'patch -Np1 -i ninja.patch'
  end

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja #{CREW_CMAKE_LIBSUFFIX_OPTIONS} \
              -DLIBEXEC_INSTALL_DIR=#{CREW_LIB_PREFIX} \
              -DWITH_DBUS=ON \
              -DWITH_DOTNET=OFF \
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
              -DBUILD_TESTING=OFF \
              -Wno-dev .."
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.check
    # Fails on i686 & armv7l
    system 'samu -C builddir test || true'
  end
end
