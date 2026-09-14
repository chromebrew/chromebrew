require 'buildsystems/autotools'

class Coreutils < Autotools
  description 'The GNU Core Utilities are the basic file, shell and text manipulation utilities of the GNU operating system.'
  homepage 'https://www.gnu.org/software/coreutils/coreutils.html'
  version '9.12'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/coreutils/coreutils-#{version}.tar.xz"
  source_sha256 'a480198559733e9b3da999e90543ac6f888a2caa544d8d664c5a1f17e528e210'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ac79ea5c5fa7e0901ffaad17d5ad5d9b45c78123f3d263a2531cf8ad954726a4',
     armv7l: 'ac79ea5c5fa7e0901ffaad17d5ad5d9b45c78123f3d263a2531cf8ad954726a4',
       i686: '91fdc86356fe80aa5798271fe78f0fbc80bf81f887fa35602843c10b0037cfd1',
     x86_64: '4c96f5744cd154bf19d961b0d5c04299ca5b5915fbe6cf8e8fcd56dc240239cf'
  })

  depends_on 'acl' => :executable
  depends_on 'attr' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc' => :library
  depends_on 'gmp' => :executable
  depends_on 'libcap' => :executable
  depends_on 'openssl' => :executable

  autotools_skip_autoreconf
  autotools_skip_bootstrap

  CREW_IN_CONTAINER ? conflicts_ok : (conflicts_with 'uutils_coreutils')

  def self.patch
    # The aclocal version is hardcoded.
    aclocal_version = `aclocal --version|head -1|cut -d' ' -f4`.chomp
    system "sed -i 's,1.18,#{aclocal_version},g' aclocal.m4"
    system "sed -i 's,1.18,#{aclocal_version},g' configure"
  end

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
