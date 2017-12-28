require 'package'

class Has < Package
  description 'checks presence of various command line tools and their versions on the path'
  homepage 'https://github.com/kdabir/has'
  version '1.1.0'
  source_url 'https://github.com/kdabir/has/archive/v1.1.0.tar.gz'
  source_sha256 'e06d9674bc1b9281c1d4391ad4366d2ef249768e7b0ada304695bf954786e9c4'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 has #{CREW_DEST_PREFIX}/bin/has"
  end
end
