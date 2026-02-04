require 'buildsystems/autotools'

class Coreutils < Autotools
  description 'The GNU Core Utilities are the basic file, shell and text manipulation utilities of the GNU operating system.'
  homepage 'https://www.gnu.org/software/coreutils/coreutils.html'
  version '9.10'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/coreutils/coreutils-#{version}.tar.xz"
  source_sha256 '664f2b1654c363a6348b688d5d475ed9ec0e7ef3c72f6f315f37fe97a2fe63eb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dc31fef5f6f47c6d75ac30b4c0b000060c0a2e2e74c6a593769bbe0f6a72facf',
     armv7l: 'dc31fef5f6f47c6d75ac30b4c0b000060c0a2e2e74c6a593769bbe0f6a72facf',
       i686: 'fde10cb818b39b8178f6b8a95b5a2d43ba71423268f937c5959b7595826b79cb',
     x86_64: '1a8c1b3b069844e4d5325c7f7a188988fd4f0a029a7c3e0e06735f0a77cf26af'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libcap' # R
  depends_on 'openssl' # R

  CREW_IN_CONTAINER ? conflicts_ok : (conflicts_with 'uutils_coreutils')

  def self.prebuild
    File.write 'arch', <<~EOF
      #!/bin/bash
      echo #{ARCH}
    EOF
  end

  autotools_configure_options '--disable-year2038' unless ARCH.include?('x86_64')

  autotools_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'arch', "#{CREW_DEST_PREFIX}/bin/arch", mode: 0o755
    # Remove conflicts with psmisc package.
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      %w[kill uptime].each do |f|
        FileUtils.rm f if File.file?(f)
      end
    end
  end

  # FAIL: tests/tail/inotify-dir-recreate.sh
  # run_tests
end
