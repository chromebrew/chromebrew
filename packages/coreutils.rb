require 'buildsystems/autotools'

class Coreutils < Autotools
  description 'The GNU Core Utilities are the basic file, shell and text manipulation utilities of the GNU operating system.'
  homepage 'https://www.gnu.org/software/coreutils/coreutils.html'
  version '9.5'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/coreutils/coreutils-9.5.tar.xz'
  source_sha256 'cd328edeac92f6a665de9f323c93b712af1858bc2e0d88f3f7100469470a1b8a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '589080263eeed8575d1efe1ec994816c7b74228890d225824454aebec12ae70d',
     armv7l: '589080263eeed8575d1efe1ec994816c7b74228890d225824454aebec12ae70d',
       i686: '24181cda251f24af6b3b4760e1fb8f25f08c1e0e7aa8fe10dfeaa5c17e74f8d2',
     x86_64: '954e7e7006f3640edbda07c4553d162efd3cc9c22566fb430e4eade322d07e4e'
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
    options = CREW_OPTIONS + year2038
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
