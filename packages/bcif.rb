require 'package'

class Bcif < Package
  description 'The BCIF compression algorithm is an open source method for lossless image compression.'
  homepage 'http://www.researchandtechnology.net/bcif/index.php'
  version '1.0-beta'
  compatibility 'all'
  source_url 'http://www.researchandtechnology.net/bcif/downloads/bcif_sources_1_0_beta.zip'
  source_sha256 'fe1dde329fa60160d9ac8a0b9e4b9360a9377bc26177eab1a31e07479839d812'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bcif-1.0-beta-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bcif-1.0-beta-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bcif-1.0-beta-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bcif-1.0-beta-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b22852369924b599c2c372dc4e1e699cca535284ac1f52747bc6cc0ecefa5bf3',
     armv7l: 'b22852369924b599c2c372dc4e1e699cca535284ac1f52747bc6cc0ecefa5bf3',
       i686: '60e2fe10178bfda42bb081baa271b102d198dd2dad40f6fd8ceff95528f59b8a',
     x86_64: '48f1371c1ef59c68b0abc5eaf9312f396b9f5887daf4332ac423c46d516f8cc0',
  })

  depends_on 'unzip'

  def self.build
    FileUtils.cd('Cpp') do
      system "bash make.sh"
    end
  end

  def self.install
    FileUtils.cd('Cpp') do
      system "mkdir -p #{CREW_DEST_PREFIX}/bin"
      system "cp bcif #{CREW_DEST_PREFIX}/bin"
    end
  end
end
