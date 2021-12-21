require 'package'

class Julia < Package
  description 'Julia is a flexible dynamic language, appropriate for scientific and numerical computing'
  homepage 'https://julialang.org/'
  version '1.6.4'
  license 'MIT'
  compatibility 'all'
  source_url ({
    aarch64: 'https://julialang-s3.julialang.org/bin/linux/armv7l/1.6/julia-1.6.4-linux-armv7l.tar.gz',
     armv7l: 'https://julialang-s3.julialang.org/bin/linux/armv7l/1.6/julia-1.6.4-linux-armv7l.tar.gz',
       i686: 'https://julialang-s3.julialang.org/bin/linux/x86/1.6/julia-1.6.4-linux-i686.tar.gz',
     x86_64: 'https://julialang-s3.julialang.org/bin/linux/x64/1.6/julia-1.6.4-linux-x86_64.tar.gz',
  })
  source_sha256 ({
    aarch64: '9ad3f6bd71eb6840d4cef1569855da20c0b4931a2bdf77703a64df672b0702a1',
     armv7l: '9ad3f6bd71eb6840d4cef1569855da20c0b4931a2bdf77703a64df672b0702a1',
       i686: '9d43d642174cf22cf0fde18dc2578c84f357d2c619b9d846d3a6da4192ba48cf',
     x86_64: '52244ae47697e8073dfbc9d1251b0422f0dbd1fbe1a41da4b9f7ddf0506b2132',
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/julia"
    FileUtils.cp_r Dir['.'], "#{CREW_DEST_PREFIX}"
    if ARCH == 'x86_64'
      FileUtils.cd "#{CREW_DEST_PREFIX}/lib/julia" do
        system "find . -type f -exec ln -s #{CREW_PREFIX}/lib/julia/{} #{CREW_DEST_LIB_PREFIX}/julia/{} \\;"
        system "find . -type l -exec ln -s #{CREW_PREFIX}/lib/julia/{} #{CREW_DEST_LIB_PREFIX}/julia/{} \\;"
      end
    end
  end
end
