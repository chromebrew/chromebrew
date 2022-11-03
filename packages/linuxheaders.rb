require 'package'

class Linuxheaders < Package
  description 'Linux headers for Chrome OS.'
  homepage 'https://kernel.org/'
  puts "CREW_KERNEL_VERSION is #{CREW_KERNEL_VERSION}"
  case CREW_KERNEL_VERSION
  when '4.14'
    version = "#{CREW_KERNEL_VERSION}-1"
  else
    version = CREW_KERNEL_VERSION
  end
  # version = CREW_KERNEL_VERSION == '4.14' ? "#{CREW_KERNEL_VERSION}-1" : CREW_KERNEL_VERSION
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  puts "linuxheaders version is #{version}"
  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/4.14-1_armv7l/linuxheaders-4.14-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/4.14-1_armv7l/linuxheaders-4.14-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/3.8_i686/linuxheaders-3.8-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/linuxheaders/4.14-1_x86_64/linuxheaders-4.14-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '75f253ac2cf0dd785ea8d9cdf9430d23d601ccc372e9f7afa95523a28273a340',
     armv7l: '75f253ac2cf0dd785ea8d9cdf9430d23d601ccc372e9f7afa95523a28273a340',
       i686: 'c16afcd95ebcffac67a026b724da19f498003ea80c13c87aeb613f09d412bb91',
     x86_64: '5d58b327ca9bab5630f0df387a3036125e1f367e6c43cd551f4734ee3e634073'
  })

  depends_on 'linux_sources' => :build

  def self.install
    ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'] = '1'
    reload_constants
    linux_src_dir = "#{CREW_PREFIX}/src/linux"
    Dir.chdir(linux_src_dir) do
      system 'make',
             'headers_install',
             "INSTALL_HDR_PATH=#{CREW_DEST_PREFIX}"
    end
    Dir.chdir("#{CREW_DEST_PREFIX}/include") do
      system "for file in \$(find . -not -type d -name '.*'); do
                rm \${file};
              done"
    end
  end
end
