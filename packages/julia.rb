require 'package'

class Julia < Package
  description 'Julia is a flexible dynamic language, appropriate for scientific and numerical computing'
  homepage 'https://julialang.org/'
  version '1.6.3'
  license 'MIT'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
   source_url 'https://julialang-s3.julialang.org/bin/linux/armv7l/1.6/julia-1.6.3-linux-armv7l.tar.gz'
   source_sha256 '7cf08affbad206bd3c1ef8bc117bf0aa6ac95d1666bf4c06f9d530cff29b2067'
  when 'i686'
    source_url 'https://julialang-s3.julialang.org/bin/linux/x86/1.6/julia-1.6.3-linux-i686.tar.gz'
    source_sha256 '06e3d64813e4ba6019d8d79e918c48af4943700bd1eb689c481d82a64f8c280a'
  when 'x86_64'
    source_url 'https://julialang-s3.julialang.org/bin/linux/x64/1.6/julia-1.6.3-linux-x86_64.tar.gz'
    source_sha256 'c7459c334cd7c3e4a297baf52535937c6bad640e60882f9201a73bab9394314b'
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
