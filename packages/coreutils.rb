require 'buildsystems/autotools'

class Coreutils < Autotools
  description 'The GNU Core Utilities are the basic file, shell and text manipulation utilities of the GNU operating system.'
  homepage 'https://www.gnu.org/software/coreutils/coreutils.html'
  version '9.4'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/coreutils/coreutils-9.4.tar.xz'
  source_sha256 'ea613a4cf44612326e917201bbbcdfbd301de21ffc3b59b6e5c07e040b275e52'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e3227e245094451d3dbc2f05aeef64b56149340b54da864c613ab124d2e5e413',
     armv7l: 'e3227e245094451d3dbc2f05aeef64b56149340b54da864c613ab124d2e5e413',
       i686: '2b432eb59bd0e97bee40786c054c9be4863f95727bc7ed6ffd98c57de686ec14',
     x86_64: '40c8e491fe8d37583cffd67323cf4a0304ca95d29289db00b5dee126b115c5cf'
  })

  depends_on 'libcap' # R

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
