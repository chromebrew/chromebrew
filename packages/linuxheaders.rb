require 'package'

class Linuxheaders < Package
  description 'Linux headers for Chrome OS.'
  homepage 'https://kernel.org/'
  # KERNEL_VERSION = %x[uname -r].chomp.reverse.split('.',2).collect(&:reverse)[1]
  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    @_ver = '4.14'
    version "#{@_ver}-1"
  when 'i686'
    @_ver '3.8'
    version @_ver
  end
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/4.14_armv7l/linuxheaders-4.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/4.14_armv7l/linuxheaders-4.14-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/3.18_i686/linuxheaders-3.18-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/4.14_x86_64/linuxheaders-4.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4960ced072202049c4f90350ebfa6b13a3fe6750ae8a1f0d79c63ad976b66391',
     armv7l: '4960ced072202049c4f90350ebfa6b13a3fe6750ae8a1f0d79c63ad976b66391',
       i686: 'df0178926e599e8a6bb54a74c7c7cda734751e007a2bbb2e59f17a8fb3d4489f',
     x86_64: '1cbc54cf8c1af9996039c5aec487ed3f047c9c870341b08418c0d93fb40233a0',
  })

  depends_on 'linux_sources' => :build

  def self.install
    ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    linux_src_dir = CREW_PREFIX + '/src/linux'
    Dir.chdir(linux_src_dir) do
      system 'make',
             'headers_install',
             "INSTALL_HDR_PATH=#{CREW_DEST_PREFIX}"
    end
    Dir.chdir(CREW_DEST_PREFIX + '/include') do
      system "for file in \$(find . -not -type d -name '.*'); do
                rm \${file};
              done"
    end
  end
end
