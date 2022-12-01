require 'package'

class Graphene < Package
  description 'A thin layer of graphic data types'
  homepage 'https://github.com/ebassi/graphene'
  version '1.10.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ebassi/graphene/archive/1.10.2.tar.gz'
  source_sha256 '87c682291fa38a131aaf9aaee17d053d7bd4ea5309d305a356619c95784b9b4d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphene/1.10.2_armv7l/graphene-1.10.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphene/1.10.2_armv7l/graphene-1.10.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphene/1.10.2_i686/graphene-1.10.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/graphene/1.10.2_x86_64/graphene-1.10.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'dbcb1dcb4f783438cf7b3f1cdc59e336be93a79bd69ce82d124bb57f022ac85e',
     armv7l: 'dbcb1dcb4f783438cf7b3f1cdc59e336be93a79bd69ce82d124bb57f022ac85e',
       i686: '467726c35c5cda9fc7faf720d349188070b904bfc0c4217c78db39949f37361b',
     x86_64: '0594d3faa99f8ce2520f87af671be452b1d401cbf4e400f8da52390772c389dc'
  })

  depends_on 'gobject_introspection' => :build

  def self.build
    ENV['CFLAGS'] = '-fuse-ld=lld'
    ENV['CXXFLAGS'] = '-fuse-ld=lld'
    system "meson setup #{CREW_MESON_FNO_LTO_OPTIONS} \
      -Darm_neon=false \
      -Dinstalled_tests=false \
      -Dtests=false \
      _build"
    system 'meson configure _build'
    system 'ninja -v -C _build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
