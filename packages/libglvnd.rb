require 'package'

class Libglvnd < Package
  description 'The GL Vendor-Neutral Dispatch library'
  homepage 'https://gitlab.freedesktop.org/glvnd/libglvnd'
  @_ver = '1.5.0'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/glvnd/libglvnd.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libglvnd/1.5.0-1_armv7l/libglvnd-1.5.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libglvnd/1.5.0-1_armv7l/libglvnd-1.5.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libglvnd/1.5.0-1_i686/libglvnd-1.5.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libglvnd/1.5.0-1_x86_64/libglvnd-1.5.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '977a403cea84ffa10f1d36699909679be3e1ebbb1c736c8334ea0885fd9ebd94',
     armv7l: '977a403cea84ffa10f1d36699909679be3e1ebbb1c736c8334ea0885fd9ebd94',
       i686: '9c9e4edbaff44cb62c30700363cfc1fd18c61e912d28446242e8419504d6456b',
     x86_64: '212b02d81595f1048de400fd2049b961912ce118ababdfaefa524ff7cd91ae6a'
  })

  depends_on 'libxext'
  depends_on 'libx11'
  depends_on 'glproto'
  depends_on 'python3' => :build
  depends_on 'glibc' # R

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
