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
    aarch64: 'f5a2ea0f371e15d54b0ceb6b01a896faa13e32041c24a423cd062d1b9ab66456',
     armv7l: 'f5a2ea0f371e15d54b0ceb6b01a896faa13e32041c24a423cd062d1b9ab66456',
       i686: 'f50db114f6299bf933d426b02b410302fb42052a400b085b04bfb9b6362d475d',
     x86_64: 'fb1c417e9691075be0baeaca6bf29d672b43d29af14156c3820260de0c53c9f6'
  })

  depends_on 'acl' => :executable
  depends_on 'attr' => :executable
  depends_on 'glibc' => :executable
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
