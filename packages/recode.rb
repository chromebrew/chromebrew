require 'package'

class Recode < Package
  description 'Charset converter tool and library'
  homepage 'https://github.com/pinard/Recode'
  # This version is from the master branch since the stable versions could not be compiled
  version '2d7092'
  source_url 'https://github.com/pinard/Recode/archive/2d7092a9999194fc0e9449717a8048c8d8e26c18.tar.gz'
  source_sha256 'd7de37aa4793ec00b042a0315f142281a1dc480f6f6d7cb2cd2568e58c4f2e87'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
