require 'package'

class Xcb_util_renderutil < Package
  description 'The xcb-util-renderutil package provides additional extensions to the XCB library'
  homepage 'https://xcb.freedesktop.org/'
  version '0.3.9-1'
  compatibility 'all'
  license 'MIT-with-advertising'
  source_url 'https://xcb.freedesktop.org/dist/xcb-util-renderutil-0.3.9.tar.bz2'
  source_sha256 'c6e97e48fb1286d6394dddb1c1732f00227c70bd1bedb7d1acabefdd340bea5b'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_util_renderutil/0.3.9-1_armv7l/xcb_util_renderutil-0.3.9-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_util_renderutil/0.3.9-1_armv7l/xcb_util_renderutil-0.3.9-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_util_renderutil/0.3.9-1_i686/xcb_util_renderutil-0.3.9-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xcb_util_renderutil/0.3.9-1_x86_64/xcb_util_renderutil-0.3.9-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1129f723592633bc655e902f5a8715294fbb16b68de40e9113735cf1f24dc618',
     armv7l: '1129f723592633bc655e902f5a8715294fbb16b68de40e9113735cf1f24dc618',
       i686: '4100d5c0a01b165790d6993cd6bcc1e73b9e3ff6e2e7f5c09b3ac9425cf2bc59',
     x86_64: 'ffe1a614f538c63b4665b044c3ffe335f6fcf0331d850f8e10307ffa7ed24a2e'
  })

  depends_on 'libxcb'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
