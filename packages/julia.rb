require 'package'

class Julia < Package
  description 'Julia is a flexible dynamic language, appropriate for scientific and numerical computing'
  homepage 'https://julialang.org/'
  version '1.7.2'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://julialang-s3.julialang.org/bin/linux/armv7l/1.7/julia-1.7.2-linux-armv7l.tar.gz',
     armv7l: 'https://julialang-s3.julialang.org/bin/linux/armv7l/1.7/julia-1.7.2-linux-armv7l.tar.gz',
       i686: 'https://julialang-s3.julialang.org/bin/linux/x86/1.7/julia-1.7.2-linux-i686.tar.gz',
     x86_64: 'https://julialang-s3.julialang.org/bin/linux/x64/1.7/julia-1.7.2-linux-x86_64.tar.gz'
  })
  source_sha256({
    aarch64: '837c93adf75a3e981eacf35f24f1d95cd2e4d9c490b84befd3865b2d558b730c',
     armv7l: '837c93adf75a3e981eacf35f24f1d95cd2e4d9c490b84befd3865b2d558b730c',
       i686: 'f5f8e6cbaf0acd473a5e13c23c80f0672207eb86408178fec221f4f7fb88f6d1',
     x86_64: 'a75244724f3b2de0e7249c861fbf64078257c16fb4203be78f1cf4dd5973ba95'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/julia"
    FileUtils.cp_r '.', CREW_DEST_PREFIX.to_s
    if ARCH == 'x86_64'
      FileUtils.cd "#{CREW_DEST_PREFIX}/lib/julia" do
        system "find . -type f -exec ln -s #{CREW_PREFIX}/lib/julia/{} #{CREW_DEST_LIB_PREFIX}/julia/{} \\;"
        system "find . -type l -exec ln -s #{CREW_PREFIX}/lib/julia/{} #{CREW_DEST_LIB_PREFIX}/julia/{} \\;"
      end
    end
  end
end
