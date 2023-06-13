require 'package'
# build order: harfbuzz => freetype => fontconfig => pango

class Fontconfig < Package
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/wiki/Software/fontconfig/'
  version '2.14.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/fontconfig/fontconfig.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.14.2_armv7l/fontconfig-2.14.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.14.2_armv7l/fontconfig-2.14.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.14.2_i686/fontconfig-2.14.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fontconfig/2.14.2_x86_64/fontconfig-2.14.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8bf542223e21a4c683aa148fa2b98f0f66758676fb64b01f819239cf0c6de686',
     armv7l: '8bf542223e21a4c683aa148fa2b98f0f66758676fb64b01f819239cf0c6de686',
       i686: '93a0f764c5352cf888849d4212519c06338b65cdc7099f2a01b9bdc28ee022e7',
     x86_64: '24a0a1cd2cc53c56bb7256e410592ac9b6398eecf02effc6c3944554dc840c77'
  })

  depends_on 'expat' # R
  depends_on 'jsonc' => :build
  depends_on 'gperf' => :build
  depends_on 'freetype' # R
  depends_on 'libpng' => :build
  depends_on 'util_linux' => :build
  depends_on 'graphite' => :build
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R

  no_fhs
  conflicts_ok # allowed to overwrite harfbuzz

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      --wrap-mode=default \
      -Dlocalstatedir=#{CREW_PREFIX}/cache \
      -Dtests=disabled \
      builddir"
    system 'meson configure builddir'
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    # The following are included the libpng package.
    FileUtils.rm "#{CREW_DEST_LIB_PREFIX}/libpng*"
    FileUtils.rm "#{CREW_DEST_PREFIX}/include/libpng16/png*"
    FileUtils.rm "#{CREW_DEST_LIB_PREFIX}/pkgconfig/libpng*"
  end
end
