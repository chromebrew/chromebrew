require 'package'

class Musl_libunbound < Package
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://nlnetlabs.nl/projects/unbound/about/'
  version '1.15.0'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url "https://nlnetlabs.nl/downloads/unbound/unbound-#{version}.tar.gz"
  source_sha256 'a480dc6c8937447b98d161fe911ffc76cfaffa2da18788781314e81339f1126f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '004be055e9469e11e3eb71de62e6c87ffbbfaca1456be4767557d77eab60509d',
     armv7l: '004be055e9469e11e3eb71de62e6c87ffbbfaca1456be4767557d77eab60509d',
       i686: '15257766348413069da6a5828767baaa60616ec16bf476cb2188e4ca9af698aa',
     x86_64: '1f98e9d769f46e7d707cbafa37c731bde2c37af3d8340d660948517d40998014'
  })

  depends_on 'musl_openssl' => :build
  depends_on 'musl_expat' => :build
  depends_on 'musl_native_toolchain' => :build

  is_musl
  is_static
  print_source_bashrc

  def self.patch
    system 'filefix'
  end

  def self.build
    system "#{MUSL_ENV_OPTIONS} ./configure \
      --prefix=#{CREW_MUSL_PREFIX} \
      --disable-shared \
      --enable-static \
      --with-pic \
      --with-ssl=#{CREW_MUSL_PREFIX} \
      --with-libexpat=#{CREW_MUSL_PREFIX} \
      --with-libunbound-only"
    system 'make'
  end

  def self.check
    # tests are broken on musl for this.
    # system 'make', 'test'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
