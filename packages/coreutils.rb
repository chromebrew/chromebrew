require 'buildsystems/autotools'

class Coreutils < Autotools
  description 'The GNU Core Utilities are the basic file, shell and text manipulation utilities of the GNU operating system.'
  homepage 'https://www.gnu.org/software/coreutils/coreutils.html'
  version '9.7'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/coreutils/coreutils-#{version}.tar.xz"
  source_sha256 'cd328edeac92f6a665de9f323c93b712af1858bc2e0d88f3f7100469470a1b8a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9843e5c79b8156cab059bf1f03dd224c3d5dcb9e88d1f95f293b56093de74004',
     armv7l: '9843e5c79b8156cab059bf1f03dd224c3d5dcb9e88d1f95f293b56093de74004',
       i686: 'edb52c0f44efa3810fd4c0880585a676ccbf474e6cb79c918edca93ad3cf2bec',
     x86_64: 'b7ce9bbed82fdeea4007d463eeb45c34f6bda3b0766f054e09998dbbd188a52f'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libcap' # R
  depends_on 'openssl' # R

  def self.preflight
    %w[uutils_coreutils].each do |cutils|
      next unless File.exist? "#{CREW_PREFIX}/etc/crew/meta/#{cutils}.filelist"

      puts "#{cutils} is installed and conflicts with this version.".orange
      puts 'To install this version, execute the following:'.lightblue
      abort "crew remove #{cutils} && crew install coreutils".lightblue
    end
  end

  def self.prebuild
    File.write 'arch', <<~EOF
      #!/bin/bash
      echo #{ARCH}
    EOF
  end

  configure_options '--disable-year2038' unless ARCH.include?('x86_64')

  configure_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'arch', "#{CREW_DEST_PREFIX}/bin/arch", mode: 0o755
    # Remove conflicts with psmisc package.
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.rm %w[kill uptime]
    end
  end

  # FAIL: tests/tail/inotify-dir-recreate.sh
  # run_tests
end
