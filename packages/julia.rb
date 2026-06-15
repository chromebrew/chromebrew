require 'package'

class Julia < Package
  description 'Julia is a flexible dynamic language, appropriate for scientific and numerical computing'
  homepage 'https://julialang.org/'
  version ARCH.eql?('x86_64') ? '1.12.6' : '1.7.3'
  license 'MIT'
  compatibility 'all'

  source_url({
    aarch64: 'https://julialang-s3.julialang.org/bin/linux/armv7l/1.7/julia-1.7.3-linux-armv7l.tar.gz',
     armv7l: 'https://julialang-s3.julialang.org/bin/linux/armv7l/1.7/julia-1.7.3-linux-armv7l.tar.gz',
       i686: 'https://julialang-s3.julialang.org/bin/linux/x86/1.7/julia-1.7.3-linux-i686.tar.gz',
     x86_64: "https://julialang-s3.julialang.org/bin/linux/x64/#{version.sub(/\.\d+$/, '')}/julia-#{version}-linux-x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'e9de15c56b9b62727c69d10da4b8e90fa6609d2e94e9cfb9f99128dfb59a8677',
     armv7l: 'e9de15c56b9b62727c69d10da4b8e90fa6609d2e94e9cfb9f99128dfb59a8677',
       i686: 'c1e1a4f9a53affee269c7e740cb8bd46740f9021414459c3ab3bb2c540d9d499',
     x86_64: 'bbabf3bef19421a9dbd24a767d807606ab85e444323b5a1c73ffe293fa3d079a'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :library
  depends_on 'libnghttp2' => :library
  depends_on 'libssh2' => :library
  depends_on 'libunwind' => :library
  depends_on 'openssl' => :library
  depends_on 'suitesparse' => :library
  depends_on 'zlib' => :library

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv Dir['*'], CREW_DEST_PREFIX
    FileUtils.mv "#{CREW_DEST_PREFIX}/LICENSE.md", "#{CREW_DEST_PREFIX}/share/julia"
    FileUtils.mv "#{CREW_DEST_PREFIX}/lib", CREW_DEST_LIB_PREFIX if ARCH.eql?('x86_64')
    # Remove conflict with gcc_lib.
    FileUtils.rm_f "#{CREW_DEST_LIB_PREFIX}/bfd-plugins/liblto_plugin.so"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.julia")
  end
end
