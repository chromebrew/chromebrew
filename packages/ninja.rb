require 'package'

class Ninja < Package
  description 'a small build system with a focus on speed'
  homepage 'https://ninja-build.org'
  version '1.8.2'
  source_url 'https://github.com/ninja-build/ninja/archive/v1.8.2.tar.gz'
  source_sha256 '86b8700c3d0880c2b44c2ff67ce42774aaf8c28cbf57725cb881569288c1c6f4'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python3'
  depends_on 'unzip'

  def self.build
    system "python3 configure.py --bootstrap"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp ninja #{CREW_DEST_DIR}/usr/local/bin/"
  end
end
