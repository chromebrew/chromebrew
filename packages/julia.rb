require 'package'

class Julia < Package
  description 'Julia is a flexible dynamic language, appropriate for scientific and numerical computing'
  homepage 'https://julialang.org/'
  version %w[aarch64 armv7l].include?(ARCH) ? '1.7.3' : '1.13.3'
  license 'MIT'
  compatibility 'all'

  source_url({
    aarch64: 'https://julialang-s3.julialang.org/bin/linux/armv7l/1.7/julia-1.7.3-linux-armv7l.tar.gz',
     armv7l: 'https://julialang-s3.julialang.org/bin/linux/armv7l/1.7/julia-1.7.3-linux-armv7l.tar.gz',
       i686: "https://julialang-s3.julialang.org/bin/linux/x86/#{version.split('.')[0..1].join('.')}/julia-#{version}-linux-i686.tar.gz",
     x86_64: "https://julialang-s3.julialang.org/bin/linux/x64/#{version.split('.')[0..1].join('.')}/julia-#{version}-linux-x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'e9de15c56b9b62727c69d10da4b8e90fa6609d2e94e9cfb9f99128dfb59a8677',
     armv7l: 'e9de15c56b9b62727c69d10da4b8e90fa6609d2e94e9cfb9f99128dfb59a8677',
       i686: 'df41358eddc884b022af86102de706e0ca11ea69792241570688943645cdb1bc',
     x86_64: '5c61cb4b40332cb5a3504e7779e2f5dac093caa4a1116ded19f01413f85c63e4'
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
