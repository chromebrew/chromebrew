require 'package'

class Opus < Package
  description 'Opus is a totally open, royalty-free, highly versatile audio codec.'
  homepage 'https://opus-codec.org/'
  version '1.4'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/xiph/opus/releases/download/v1.4/opus-1.4.tar.gz'
  source_sha256 'c9b32b4253be5ae63d1ff16eea06b94b5f0f2951b7a02aceef58e3a3ce49c51f'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opus/1.4_armv7l/opus-1.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opus/1.4_armv7l/opus-1.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opus/1.4_i686/opus-1.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opus/1.4_x86_64/opus-1.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '63fe85dddd1151716ce4dd6df89216a35c4d5789396218d6d6310da6a12e6894',
     armv7l: '63fe85dddd1151716ce4dd6df89216a35c4d5789396218d6d6310da6a12e6894',
       i686: '1ab7a3f96a246f743148a426726fcf0af2b014f1bd8cfec757b207216e463bcb',
     x86_64: '3729cff69b9e8635f43cfb38e2a32617a0855333dc098ca3ca391b75a579fafe'
  })

  depends_on 'doxygen' => :build
  depends_on 'glibc' # R

  def self.patch
    # See https://github.com/xiph/opus/issues/273
    downloader 'https://patch-diff.githubusercontent.com/raw/xiph/opus/pull/267.patch',
               '39bcf3085978f1c113f6e2c60f39ccff638d2f5e1e0192ca603883e35632997c'
    system 'patch -Np1 -i 267.patch'
  end

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS.gsub('vfpv3-d16', 'neon')} \
      -Dcustom-modes=true \
      -Ddocs=disabled \
      -Dtests=disabled \
      builddir"
    system 'meson configure --no-pager builddir'
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
