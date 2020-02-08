require 'package'

class Julia < Package
  description 'Julia is a flexible dynamic language, appropriate for scientific and numerical computing'
  homepage 'https://julialang.org/'
  version '1.3.1'
  case ARCH
  when 'aarch64', 'armv7l'
   source_url 'https://julialang-s3.julialang.org/bin/linux/armv7l/1.3/julia-1.3.1-linux-armv7l.tar.gz'
   source_sha256 '965c8fab2214f8ce1b3d449d088561a6de61be42543b48c3bbadaed5b02bf824'
  when 'i686'
    source_url 'https://julialang-s3.julialang.org/bin/linux/x86/1.3/julia-1.3.1-linux-i686.tar.gz'
    source_sha256 '2cef14e892ac317707b39d2afd9ad57a39fb77445ffb7c461a341a4cdf34141a'
  when 'x86_64'
    source_url 'https://julialang-s3.julialang.org/bin/linux/x64/1.3/julia-1.3.1-linux-x86_64.tar.gz'
    source_sha256 'faa707c8343780a6fe5eaf13490355e8190acf8e2c189b9e7ecbddb0fa2643ad'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/julia"
    system "cp -r . #{CREW_DEST_PREFIX}"
    if ARCH == 'x86_64'
      FileUtils.cd "#{CREW_DEST_PREFIX}/lib/julia" do
        system "find . -type f -exec ln -s #{CREW_PREFIX}/lib/julia/{} #{CREW_DEST_LIB_PREFIX}/julia/{} \\;"
        system "find . -type l -exec ln -s #{CREW_PREFIX}/lib/julia/{} #{CREW_DEST_LIB_PREFIX}/julia/{} \\;"
      end
    end
  end
end
