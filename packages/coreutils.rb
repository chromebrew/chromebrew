require 'package'

class Coreutils < Package
  description 'The GNU Core Utilities are the basic file, shell and text manipulation utilities of the GNU operating system.'
  homepage 'https://www.gnu.org/software/coreutils/coreutils.html'
  @_ver = '9.0'
  version @_ver
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/gnu/coreutils/coreutils-#{@_ver}.tar.xz"
  source_sha256 'ce30acdf4a41bc5bb30dd955e9eaa75fa216b4e3deb08889ed32433c7b3b97ce'

  binary_url({
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/coreutils/9.0_i686/coreutils-9.0-chromeos-i686.tar.xz',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/coreutils/9.0_armv7l/coreutils-9.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/coreutils/9.0_armv7l/coreutils-9.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/coreutils/9.0_x86_64/coreutils-9.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
       i686: 'a4d1a88a16e68ca55aa4c2daa9dac4dfe202c20a0c91ff4caee7ba3062e81f2f',
    aarch64: '5d94db6870ae7f5d62af972eb7640b53ba96199e387e707bd39ba9aaee67cd06',
     armv7l: '5d94db6870ae7f5d62af972eb7640b53ba96199e387e707bd39ba9aaee67cd06',
     x86_64: '905824619128baca70687e6d998debca143b8cac871e2874490dfff8d3c4e127'
  })

  def self.build
    system "env #{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    system "cat <<'EOF'> #{CREW_DEST_PREFIX}/bin/arch
#!/bin/bash
echo \"#{ARCH}\"
EOF"
    system "chmod +x #{CREW_DEST_PREFIX}/bin/arch"
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
