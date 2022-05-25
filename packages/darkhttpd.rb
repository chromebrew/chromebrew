require 'package'

class Darkhttpd < Package
  description 'Minimal webserver written by Emil Mikulic'
  homepage 'https://unix4lyfe.org/darkhttpd/'
  version '1.12'
  license 'ISC'
  compatibility 'all'
  source_url 'https://unix4lyfe.org/darkhttpd/darkhttpd-1.12.tar.bz2'
  source_sha256 'a50417b622b32b5f421b3132cb94ebeff04f02c5fb87fba2e31147d23de50505'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/darkhttpd/1.12_armv7l/darkhttpd-1.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/darkhttpd/1.12_armv7l/darkhttpd-1.12-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/darkhttpd/1.12_i686/darkhttpd-1.12-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/darkhttpd/1.12_x86_64/darkhttpd-1.12-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2e0d63b59129bae92d3d957b655a9d4bf07a66586d5427f8fbe1b0d181541b0f',
     armv7l: '2e0d63b59129bae92d3d957b655a9d4bf07a66586d5427f8fbe1b0d181541b0f',
       i686: '56f4e98ccfe4f04ca4fd7bf3c1268de0dc44600da4b4257d32cc0cfe634485c9',
     x86_64: 'c60d1cb89689bd4ecbe0503b37cfeefa7b64a0db310644fbe4e987bfd3f6699e'
  })

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp 'darkhttpd', "#{CREW_DEST_PREFIX}/bin/"
  end
end
