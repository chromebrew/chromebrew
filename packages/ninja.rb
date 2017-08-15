require 'package'

class Ninja < Package
  description 'a small build system with a focus on speed'
  homepage 'https://ninja-build.org'
  version '1.7.2'
  source_url 'https://github.com/ninja-build/ninja/archive/v1.7.2.tar.gz'
  source_sha256 '2edda0a5421ace3cf428309211270772dd35a91af60c96f93f90df6bc41b16d9'

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
