require 'package'

class Pandoc < Package
  description 'Universal markup converter'
  homepage 'https://github.com/jgm/pandoc/'
  version '2.7.3'
  compatibility 'all'
  
  source_url 'https://github.com/jgm/pandoc/releases/download/2.7.3/pandoc-2.7.3-linux.tar.gz'
  source_sha256 'eb775fd42ec50329004d00f0c9b13076e707cdd44745517c8ce2581fb8abdb75'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pandoc-2.7.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pandoc-2.7.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pandoc-2.7.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pandoc-2.7.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2bdd58244cb9044771e1ef36adcb9749c56c045c8f040c3e199e6bbb047a78f5',
     armv7l: '2bdd58244cb9044771e1ef36adcb9749c56c045c8f040c3e199e6bbb047a78f5',
       i686: '7dd73da7ef9bcb0f9a2380a7e72b3906101bde0e99091483aeaa047b8e6c8808',
     x86_64: '7a6382e0dacaea978eb348feebaf02d8b58addc8cc14db179b68dcf552b7e260',
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
    system "cp -r share/ #{CREW_DEST_PREFIX}"
  end
end
