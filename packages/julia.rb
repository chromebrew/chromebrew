require 'package'

class Julia < Package
  description 'Julia is a flexible dynamic language, appropriate for scientific and numerical computing'
  homepage 'https://julialang.org/'
  version ARCH.eql?('x86_64') ? '1.11.6' : '1.7.3'
  license 'MIT'
  compatibility 'all'

  source_url({
    aarch64: 'https://julialang-s3.julialang.org/bin/linux/armv7l/1.7/julia-1.7.3-linux-armv7l.tar.gz',
     armv7l: 'https://julialang-s3.julialang.org/bin/linux/armv7l/1.7/julia-1.7.3-linux-armv7l.tar.gz',
       i686: 'https://julialang-s3.julialang.org/bin/linux/x86/1.7/julia-1.7.3-linux-i686.tar.gz',
     x86_64: 'https://julialang-s3.julialang.org/bin/linux/x64/1.11/julia-1.11.6-linux-x86_64.tar.gz'
  })
  source_sha256({
    aarch64: 'e9de15c56b9b62727c69d10da4b8e90fa6609d2e94e9cfb9f99128dfb59a8677',
     armv7l: 'e9de15c56b9b62727c69d10da4b8e90fa6609d2e94e9cfb9f99128dfb59a8677',
       i686: 'c1e1a4f9a53affee269c7e740cb8bd46740f9021414459c3ab3bb2c540d9d499',
     x86_64: 'e99e52e2029d845097c68f2372d836186f0eb3fb897a9dde0bdf9ee9250d03d5'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libnghttp2' # R
  depends_on 'zlib' # R

  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/julia"
    FileUtils.cp_r Dir['.'], CREW_DEST_PREFIX
    FileUtils.mv "#{CREW_DEST_PREFIX}/LICENSE.md", "#{CREW_DEST_PREFIX}/share/julia"
    if ARCH == 'x86_64'
      FileUtils.cd "#{CREW_DEST_PREFIX}/lib/julia" do
        system "find . -type f -exec ln -s #{CREW_PREFIX}/lib/julia/{} #{CREW_DEST_LIB_PREFIX}/julia/{} \\;"
        system "find . -type l -exec ln -s #{CREW_PREFIX}/lib/julia/{} #{CREW_DEST_LIB_PREFIX}/julia/{} \\;"
      end
    end
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.julia")
  end
end
