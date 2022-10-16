require 'package'

class P11kit < Package
  description "Provides a standard configuration setup for installing PKCS#11 modules in such a way that they're discoverable."
  homepage 'https://p11-glue.freedesktop.org/p11-kit.html'
  version '0.24.0-1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/p11-glue/p11-kit/archive/0.24.0.tar.gz'
  source_sha256 '284d209e045ebc7e30ccb479c7b559edfcb5433d665b497386dd35291826e39c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/p11kit/0.24.0-1_armv7l/p11kit-0.24.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/p11kit/0.24.0-1_armv7l/p11kit-0.24.0-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/p11kit/0.24.0-1_i686/p11kit-0.24.0-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/p11kit/0.24.0-1_x86_64/p11kit-0.24.0-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5eb5c9e6046d6a124235c797c14d06e2c82dde0161ba55bec3caa2463cdc0d0f',
     armv7l: '5eb5c9e6046d6a124235c797c14d06e2c82dde0161ba55bec3caa2463cdc0d0f',
       i686: 'ebb1bfdd6933dbde83ea6e2684070814ea1532a9b1dbabfce0b2918d7a74082c',
     x86_64: '8259e4144eea281d3da641b7973e807518f521db62c552691a2e8d65f879ee87'
  })

  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'libtasn1' # R

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
