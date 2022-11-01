require 'package'

class Dav1d < Package
  description '**dav1d** is a new **AV1** cross-platform **d**ecoder, open-source, and focused on speed and correctness.'
  homepage 'https://code.videolan.org/videolan/dav1d'
  @_ver = '1.0.0'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url "https://get.videolan.org/dav1d/#{@_ver}/dav1d-#{@_ver}.tar.xz"
  source_sha256 '51737db7e4897e599684f873a4725176dd3c779e639411d7c4fce134bb5ebb82'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dav1d/1.0.0_armv7l/dav1d-1.0.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dav1d/1.0.0_armv7l/dav1d-1.0.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dav1d/1.0.0_i686/dav1d-1.0.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dav1d/1.0.0_x86_64/dav1d-1.0.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '51476f6a5e6db4907ef7d670ba0d9d1f83f7ceee0a049fd17e98b2dc21358c15',
     armv7l: '51476f6a5e6db4907ef7d670ba0d9d1f83f7ceee0a049fd17e98b2dc21358c15',
       i686: '0abd43b1a7df5cdd434a0f4375353a8c38fd0fe3fdd8c537da4527003219c692',
     x86_64: '4fd10733af9b1806b2ec43188cdcbd03650975672fd63772a61d7840dc9b0669'
  })

  depends_on 'nasm' => :build
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
