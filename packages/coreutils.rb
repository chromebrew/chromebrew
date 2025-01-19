require 'buildsystems/autotools'

class Coreutils < Autotools
  description 'The GNU Core Utilities are the basic file, shell and text manipulation utilities of the GNU operating system.'
  homepage 'https://www.gnu.org/software/coreutils/coreutils.html'
  version '9.6'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/coreutils/coreutils-#{version}.tar.xz"
  source_sha256 'cd328edeac92f6a665de9f323c93b712af1858bc2e0d88f3f7100469470a1b8a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c10a21d009873b1e05ab7279fa732cea5e92a8fd4441febbac479a389934885c',
     armv7l: 'c10a21d009873b1e05ab7279fa732cea5e92a8fd4441febbac479a389934885c',
       i686: '66c9eb64c9123f8c43827a2faac42419cde653830c99a496de6dc138e738ac60',
     x86_64: '6c38aa3231c204f40dec93ae098c0cf1f14a592f45e1b7ecaa3140d5d250a9a8'
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

  def self.build
    year2038 = ARCH == 'x86_64' ? '' : ' --disable-year2038'
    options = CREW_CONFIGURE_OPTIONS + year2038
    system "./configure #{options}"
    system 'make'
    arch = <<~EOF
      #!/bin/bash
      echo #{ARCH}
    EOF
    File.write 'arch', arch
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'arch', "#{CREW_DEST_PREFIX}/bin/arch", mode: 0o755
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Remove conflicts with psmisc package.
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.rm %w[kill uptime]
    end
  end

  # FAIL: tests/tail/inotify-dir-recreate.sh
  # run_tests
end
