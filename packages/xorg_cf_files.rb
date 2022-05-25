require 'package'

class Xorg_cf_files < Package
  description 'X.org cf files for use with imake builds.'
  homepage 'https://x.org'
  version '1.0.7'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/util/xorg-cf-files-1.0.7.tar.gz'
  source_sha256 'a49478ba0c2138bc53de38979cd2dee073b6fd6728597c552d266a707747f472'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_cf_files/1.0.7_armv7l/xorg_cf_files-1.0.7-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_cf_files/1.0.7_armv7l/xorg_cf_files-1.0.7-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_cf_files/1.0.7_i686/xorg_cf_files-1.0.7-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_cf_files/1.0.7_x86_64/xorg_cf_files-1.0.7-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '9fa482169d3e253107419a1f05cb8e6d3e3c2f58846133c2b0f827cde7161565',
     armv7l: '9fa482169d3e253107419a1f05cb8e6d3e3c2f58846133c2b0f827cde7161565',
       i686: '265ed1b208b8a304e741a34c96160858df338269f3cbeb56fce312b5d3f101f2',
     x86_64: 'a5547a9bff2657d49b928e1979b1abf2aa0c6de2740b1d710fb20f6f3013b7d8'
  })

  depends_on 'font_util'

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
