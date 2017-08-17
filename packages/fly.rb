require 'package'

class Fly < Package
  description 'fly is a C program that creates PNG, JPEG or GIF images on the fly from CGI and other programs.'
  homepage 'http://martin.gleeson.com/fly/index.html'
  version '1.6.5'
  source_url 'http://www.w3perl.com/fly/dist/fly-1.6.5.tar.gz'
  source_sha256 '8411915a9acd9a3d86896db5a53ac6bd4e35b44106c0f180cc0f96a6f02a62c9'

  depends_on 'libgd'

  def self.build
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp fly #{CREW_DEST_DIR}/usr/local/bin"
  end
end
