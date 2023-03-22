require 'package'

class Coreutils < Package
  description 'The GNU Core Utilities are the basic file, shell and text manipulation utilities of the GNU operating system.'
  homepage 'https://www.gnu.org/software/coreutils/coreutils.html'
  version '9.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/coreutils/coreutils-9.2.tar.xz'
  source_sha256 '6885ff47b9cdb211de47d368c17853f406daaf98b148aaecdf10de29cc04b0b3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/coreutils/9.2_armv7l/coreutils-9.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/coreutils/9.2_armv7l/coreutils-9.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/coreutils/9.2_i686/coreutils-9.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/coreutils/9.2_x86_64/coreutils-9.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '39540783dbce98b48122fdba187de6a14622fdeec7bc6ceffe399e280379ec4f',
     armv7l: '39540783dbce98b48122fdba187de6a14622fdeec7bc6ceffe399e280379ec4f',
       i686: '0745b0227a7f39f3958403cb116974a11189dccc6953a23e2919768e83f769ee',
     x86_64: '354fc8cfaba39b4bc37cde938ea8bea330d242c3e51cad2835f78d1d4834a829'
  })

  depends_on 'libcap' # R
  no_patchelf

  def self.preflight
    %w[uutils_coreutils].each do |cutils|
      next unless File.exist? "#{CREW_PREFIX}/etc/crew/meta/#{cutils}.filelist"

      puts "#{cutils} is installed and conflicts with this version.".orange
      puts 'To install this version, execute the following:'.lightblue
      abort "crew remove #{cutils} && crew install coreutils".lightblue
    end
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
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
end
