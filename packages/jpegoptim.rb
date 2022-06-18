require 'package'

class Jpegoptim < Package
  description 'Utility to optimize/compress JPEG files'
  homepage 'https://github.com/tjko/jpegoptim'
  version '1.4.7'
  license 'GPL-3.0'
  compatibility 'all'
  source_url 'https://github.com/tjko/jpegoptim/archive/v1.4.7.tar.gz'
  source_sha256 'c52616f2fb8d481315871680f9943b0f58c553d1e0c49a6bd4691a3e66d7e6de'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jpegoptim/1.4.7_armv7l/jpegoptim-1.4.7-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jpegoptim/1.4.7_armv7l/jpegoptim-1.4.7-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jpegoptim/1.4.7_i686/jpegoptim-1.4.7-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jpegoptim/1.4.7_x86_64/jpegoptim-1.4.7-chromeos-x86_64.tar.zst',
  })
  binary_sha256 ({
    aarch64: '8e2fb70c56a4d0afd63a766bb3baa8d9bd17be103393aef137d4026511e84edc',
     armv7l: '8e2fb70c56a4d0afd63a766bb3baa8d9bd17be103393aef137d4026511e84edc',
       i686: '0502e5b79febacbdb1d0469c6a1951e8b1b7fe004fc3ebe3ffc4f6a32f6c802a',
     x86_64: '9c3f331ec059b3f6f9580845be871658467ae7ee00fed66021bdbeee497c3a82',
  })

  depends_on 'libjpeg'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
    system 'make', 'strip'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
