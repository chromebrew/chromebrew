require 'package'

class Julia < Package
  description 'Julia is a flexible dynamic language, appropriate for scientific and numerical computing'
  homepage 'https://julialang.org/'
  version '1.0.1'
  case ARCH
  when 'x86_64'
    source_url 'https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.1-linux-x86_64.tar.gz'
    source_sha256 '9ffbcf7f4a111e13415954caccdd1ce90b5c835cee9f62d6ac708f5b752c87dd'
  when 'i686'
    source_url 'https://julialang-s3.julialang.org/bin/linux/x86/1.0/julia-1.0.1-linux-i686.tar.gz'
    source_sha256 'e2ce5fa564242c2dbb836f9493166ce6eaaec8f46db9861b4cdad047497dd4c4'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

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
