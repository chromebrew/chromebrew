require 'buildsystems/meson'

class Pkgconf < Meson
  description 'Package compiler and linker metadata toolkit'
  homepage 'https://github.com/pkgconf/pkgconf'
  version '3.0.3'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/pkgconf/pkgconf.git'
  git_hashtag "pkgconf-#{version}"
  source_sha256 '06f86a2e276e6c63992b31bc69b66517d537b8f7cfb8b7be4f255887010d3586'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '990899f4e70aa31e33446b341125ba5a343be203f3b0bf8d6d94a998749b082c',
     armv7l: '990899f4e70aa31e33446b341125ba5a343be203f3b0bf8d6d94a998749b082c',
       i686: 'e1f598320c96233e24d214352e1176d1cd46f8686590d99d109213f5a0ce5931',
     x86_64: 'a2523b392bd2feec25d544de71ac65f559b6e660e0ecb617d9eb001a85e4f447'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  conflicts_ok # Conflicts with pkg_config

  meson_options "-Dwith-system-libdir=#{CREW_LIB_PREFIX} \
    -Dwith-system-includedir=#{CREW_PREFIX}/include"

  meson_install_extras do
    File.write 'pkgconf_envd', <<~PKGCONFEOF
      export PKG_CONFIG=#{CREW_PREFIX}/bin/pkgconf
    PKGCONFEOF
    FileUtils.install 'pkgconf_envd', "#{CREW_DEST_PREFIX}/etc/env.d/pkgconf", mode: 0o644
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/pkgconf", "#{CREW_DEST_PREFIX}/bin/pkg-config"
  end
end
