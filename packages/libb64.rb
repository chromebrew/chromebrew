require 'package'

class Libb64 < Package
  description 'library of ANSI C routines for fast encoding/decoding data into and from a base64-encoded format.'
  homepage 'https://libb64.sourceforge.net/'
  version '2.0.0.1'
  license 'Public Domain'
  compatibility 'all'
  source_url 'https://github.com/libb64/libb64/archive/v2.0.0.1.tar.gz'
  source_sha256 'ce8e578a953a591bd4a6f157eec310b9a4c2e6f10ade2fdda6ae6bafaf798b98'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libb64/2.0.0.1_armv7l/libb64-2.0.0.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libb64/2.0.0.1_armv7l/libb64-2.0.0.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libb64/2.0.0.1_i686/libb64-2.0.0.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libb64/2.0.0.1_x86_64/libb64-2.0.0.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a1b9bd71d3448bf6ac7b6f4cb3a255acf3689efb2319931e51d08953d053af53',
     armv7l: 'a1b9bd71d3448bf6ac7b6f4cb3a255acf3689efb2319931e51d08953d053af53',
       i686: '2b0ad34f049e7cc8ab1d9418db3f35b6d5bf90c20d0e835321c8821b56f29dd0',
     x86_64: 'b2df29d8418bcbfc46b34c56cb9c1f08e8462777c2d3c380e00976b51ece0f7d'
  })

  def self.build
    system 'make -C src'
    system 'make -C base64'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include"
    FileUtils.install 'base64/base64', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.install 'src/libb64.a', CREW_DEST_LIB_PREFIX, mode: 0o644
    FileUtils.cp_r 'include/b64', "#{CREW_DEST_PREFIX}/include"
  end
end
