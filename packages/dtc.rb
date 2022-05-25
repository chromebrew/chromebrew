# Adapted from Arch Linux dtc PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/dtc/trunk/PKGBUILD

require 'package'

class Dtc < Package
  description 'Device Tree Compiler'
  homepage 'https://www.devicetree.org/'
  version '1.6.1'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://www.kernel.org/pub/software/utils/dtc/dtc-1.6.1.tar.xz'
  source_sha256 '65cec529893659a49a89740bb362f507a3b94fc8cd791e76a8d6a2b6f3203473'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dtc/1.6.1_armv7l/dtc-1.6.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dtc/1.6.1_armv7l/dtc-1.6.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dtc/1.6.1_i686/dtc-1.6.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dtc/1.6.1_x86_64/dtc-1.6.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '79d681e53a8481baab0201a02c2ce28dba0eb2921b65bf5b2ade184467720b53',
     armv7l: '79d681e53a8481baab0201a02c2ce28dba0eb2921b65bf5b2ade184467720b53',
       i686: '75766da6ebda4666d3ce2f0712c19ffef25ba6d6fab25811a90b350570ed1d9b',
     x86_64: 'ce5a832fe339a6bea35699071330199ea36085f2bc7ad6af3c417014b27950d3'
  })

  depends_on 'libyaml'
  depends_on 'swig' => :build
  depends_on 'python3' => :build

  def self.patch
    downloader 'https://github.com/archlinux/svntogit-community/raw/packages/dtc/trunk/python310.patch',
               '767b6931887018a1dd7d41bfebebd16ab78a35de06a5689f530e376ab8c6b037'
    system 'patch -Np1 -i python310.patch'
    system "sed -i 's/-Werror//' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make SETUP_PREFIX=#{CREW_DEST_PREFIX} PREFIX=#{CREW_DEST_PREFIX} install"
  end
end
