require 'package'

class Chrx < Package
  description 'Install Linux onto your Chromebook. Dual-boot alongside ChromeOS for maximum flexibility.'
  homepage 'https://chrx.org/'
  version '3.0.2'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/chrx-3.0.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/chrx-3.0.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/chrx-3.0.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/chrx-3.0.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1ebaed82d042708976e490e9264dd407cc7c9216ae0fd54bb63cbfc71b65c9fb',
     armv7l: '1ebaed82d042708976e490e9264dd407cc7c9216ae0fd54bb63cbfc71b65c9fb',
       i686: '1bf51db2c3f745c5528db89dd7dc6aedcb1022ce7fd0657b2c853464fedeca41',
     x86_64: '2b9392a9b7f382634aa662b20ca8d8f31e7f607911b6f6ceb0b77b20d91572e7',
  })

  def self.install
    system 'curl -Lo chrx.tar.gz https://chrx.org/'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('chrx.tar.gz') ) == '5d679f3673db4651502c3a2b7bf3b77620606970c95cf9f00afea12834d184f2'
    FileUtils.mkdir_p CREW_DEST_PREFIX
    system "cat chrx.tar.gz | tar xzvfC - #{CREW_DEST_PREFIX}"
  end
end
