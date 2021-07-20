require 'package'

class P11kit < Package
  description "Provides a standard configuration setup for installing PKCS#11 modules in such a way that they're discoverable."
  homepage 'https://p11-glue.freedesktop.org/p11-kit.html'
  version '0.24.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/p11-glue/p11-kit/archive/0.24.0.tar.gz'
  source_sha256 '284d209e045ebc7e30ccb479c7b559edfcb5433d665b497386dd35291826e39c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/p11kit/0.24.0_armv7l/p11kit-0.24.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/p11kit/0.24.0_armv7l/p11kit-0.24.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/p11kit/0.24.0_i686/p11kit-0.24.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/p11kit/0.24.0_x86_64/p11kit-0.24.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2ca3f06bf7057b4ddddb2fd0338e995fce6bf7c609120698a6218687cebd4bb1',
     armv7l: '2ca3f06bf7057b4ddddb2fd0338e995fce6bf7c609120698a6218687cebd4bb1',
       i686: '600b55f9167934b5b838e6bff7df938c075467ea59dd7b044fb83392b16166a3',
     x86_64: '6d4c5565dcd978a0bab78300a512bc2decbb01cb66149f0502ecc4a7d0b0a94e'
  })

  depends_on 'libffi'
  depends_on 'libtasn1'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      build"
    system 'meson configure build'
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
