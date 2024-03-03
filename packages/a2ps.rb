require 'buildsystems/autotools'

class A2ps < Autotools
  description 'GNU a2ps is an Any to PostScript filter.'
  homepage 'https://www.gnu.org/software/a2ps/'
  version '4.15'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/a2ps/a2ps-4.15.tar.gz'
  source_sha256 'a5adc5a9222f98448a57c6b5eb6948b72743eaf9a30c67a134df082e99c76652'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3611cd68968a4c8402ff4adb4a7c89579956543d085186199d64baf7d305605a',
     armv7l: '3611cd68968a4c8402ff4adb4a7c89579956543d085186199d64baf7d305605a',
       i686: '30d1558dbd5121b970c2dbfdee87d7d31de9a1de6faea090290fffecb1582171',
     x86_64: '8002a71b0d233f1243a9443ab0a3a5d2d7c894aab357514d244dbf6575b9cb0d'
  })

  depends_on 'gperf'
  depends_on 'filecmd'

  configure_options "--localstatedir=#{CREW_PREFIX}/tmp"
end
