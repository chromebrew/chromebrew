require 'package'

class Dub < Package
  description 'Developer package manager for D programming language'
  homepage 'https://github.com/D-Programming-Language/dub'
  version '1.7.1'
  source_url 'https://github.com/dlang/dub/archive/v1.7.1.tar.gz'
  source_sha256 'baa8c533f59d83f74e89c06f5ec7e52daf3becb227c7177a9eeab7159ba86dbc'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ldc'

  def self.build
    system "echo \"module dub.version_;\" > source/dub/version_.d"
    system "echo 'enum dubVersion = \"1.7.1\";' >> source/dub/version_.d"
    system "ldmd2 -ofbin/dub -w -O -g -version=DubUseCurl -Isource -L-lcurl @build-files.txt"
  end

  def self.install
    system "install", "-Dm755",  "bin/dub", "#{CREW_DEST_PREFIX}/bin/dub"
  end
end
