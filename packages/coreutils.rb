require 'buildsystems/autotools'

class Coreutils < Autotools
  description 'The GNU Core Utilities are the basic file, shell and text manipulation utilities of the GNU operating system.'
  homepage 'https://www.gnu.org/software/coreutils/coreutils.html'
  version '9.11'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/coreutils/coreutils-#{version}.tar.xz"
  source_sha256 '394024eda0a5955217ceda9cd1201e65dc8fa3aa29c2951135a49521d57c3cc3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fa39da43df4459a4a591211c50b465b449c9ecc0b6e1c0ca5ce0281a34e76ed3',
     armv7l: 'fa39da43df4459a4a591211c50b465b449c9ecc0b6e1c0ca5ce0281a34e76ed3',
       i686: '5ebefc26d69481ed2541fc5da8b272f891d24ecfffcf2ad2cd1d56ede2ac6a38',
     x86_64: 'b448f293e47b1fce2a9d7ab1e10d4c05f580168bd1da31e50d4dcd2112bd4adb'
  })

  depends_on 'acl' => :executable
  depends_on 'attr' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc' => :library
  depends_on 'gmp' => :executable
  depends_on 'libcap' => :executable
  depends_on 'openssl' => :executable

  CREW_IN_CONTAINER ? conflicts_ok : (conflicts_with 'uutils_coreutils')

  def self.prebuild
    File.write 'arch', <<~EOF
      #!/bin/bash
      echo #{ARCH}
    EOF
    if LIBC_VERSION.to_f < 2.29
      # The fallback threads.h from the c11threads package does not work
      # here. See https://github.com/jtsiomb/c11threads/issues/29
      FileUtils.rm_f "#{CREW_PREFIX}/include/threads.h"
      puts 'Please reinstall c11threads after this build'.lightblue unless CREW_IN_CONTAINER
    end
  end

  autotools_configure_options '--disable-year2038' unless ARCH.include?('x86_64')

  autotools_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'arch', "#{CREW_DEST_PREFIX}/bin/arch", mode: 0o755
    # Remove conflicts with psmisc package.
    %w[kill uptime].each { |f| FileUtils.rm_f "#{CREW_DEST_PREFIX}/bin/#{f}" }
  end

  # FAIL: tests/tail/inotify-dir-recreate.sh
  # run_tests
end
