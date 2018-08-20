require 'package'

class Julia < Package
  description 'Julia is a flexible dynamic language, appropriate for scientific and numerical computing'
  homepage 'https://julialang.org/'
  version '1.0.0'
  case ARCH
  when 'x86_64'
    source_url 'https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.0-linux-x86_64.tar.gz'
    source_sha256 'bea4570d7358016d8ed29d2c15787dbefaea3e746c570763e7ad6040f17831f3'
  when 'i686'
    source_url 'https://julialang-s3.julialang.org/bin/linux/x86/1.0/julia-1.0.0-linux-i686.tar.gz'
    source_sha256 'c8c607a7682bfe08b5511aac616c3b393038e52edf4dbaac5e69727c4f1eaa8b'
  when 'aarch64', 'armv7l'
    source_url 'https://julialang-s3.julialang.org/bin/linux/armv7l/1.0/julia-1.0.0-linux-armv7l.tar.gz'
    source_sha256 '61e855e93c3bfe5e4f486a54a4c45194f4b020922e56af5fc104ff3fd3d8e41a'
  else
    puts "#{ARCH} architecture not supported.".lightred
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
	system "cp -r . #{CREW_DEST_PREFIX}"
	system "mv #{CREW_DEST_PREFIX}/lib #{CREW_DEST_PREFIX}/lib64" if ARCH == 'x86_64'
  end
end
