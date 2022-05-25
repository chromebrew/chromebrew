require 'package'

class Xe < Package
  description 'simple xargs and apply replacement.'
  homepage 'https://github.com/chneukirchen/xe/'
  version '0.11'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/chneukirchen/xe/archive/v0.11.tar.gz'
  source_sha256 '4087d40be2db3df81a836f797e1fed17d6ac1c788dcf0fd6a904f2d2178a6f1a'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xe/0.11_armv7l/xe-0.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xe/0.11_armv7l/xe-0.11-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xe/0.11_i686/xe-0.11-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xe/0.11_x86_64/xe-0.11-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '731178af47f83d6918dfd9967d57113f6552c48dc68a98c0c11837469f044540',
     armv7l: '731178af47f83d6918dfd9967d57113f6552c48dc68a98c0c11837469f044540',
       i686: 'b0db75159f9e4462852175ac47cf07f0f9e3f2962ac262df3daaa90b6f792e0b',
     x86_64: '7ce6835e608e0638f5604eef58007735b42f9fcdc0e2d9f6811c93cf844aac27'
  })

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
