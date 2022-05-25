require 'package'

class Fly < Package
  description 'fly is a C program that creates PNG, JPEG or GIF images on the fly from CGI and other programs.'
  homepage 'http://www.w3perl.com/fly/'
  version '1.6.5'
  license 'custom'
  compatibility 'all'
  source_url 'http://www.w3perl.com/fly/dist/fly-1.6.5.tar.gz'
  source_sha256 '8411915a9acd9a3d86896db5a53ac6bd4e35b44106c0f180cc0f96a6f02a62c9'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fly/1.6.5_armv7l/fly-1.6.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fly/1.6.5_armv7l/fly-1.6.5-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fly/1.6.5_i686/fly-1.6.5-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/fly/1.6.5_x86_64/fly-1.6.5-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '18e5b2d2e945f0192bc56de5c24a822421027c20477a1306ea9f61a8fc55eea9',
     armv7l: '18e5b2d2e945f0192bc56de5c24a822421027c20477a1306ea9f61a8fc55eea9',
       i686: '9a59d20d16c94b64b5efda732669b862c12544b0e1bec6570ad9d6dd6db71f47',
     x86_64: '6232f0497b3d6cd9956dcce7b372a23a26a2874210deca99d57556ffe9c61644'
  })

  depends_on 'libgd'

  def self.build
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "cp fly #{CREW_DEST_PREFIX}/bin"
  end
end
