require 'buildsystems/autotools'

class Libffi < Autotools
  description 'The libffi library provides a portable, high level programming interface to various calling conventions.'
  homepage 'https://sourceware.org/libffi/'
  version '3.5.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libffi/libffi.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e386d85ff175495ea4288c508dae894620436be25ac838858858aae4155626cf',
     armv7l: 'e386d85ff175495ea4288c508dae894620436be25ac838858858aae4155626cf',
       i686: '1047e257453111344ef939927ea738ef1407936f761fec885ea8fe40431f8f3e',
     x86_64: '169e1fdd8636e3cb770eb89fe6ed36b040148b79d9c3c3a55846dc290df3edc3'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  # run_tests         # DejaGNU required

  # See https://git.launchpad.net/ubuntu/+source/libffi/tree/debian/rules?h=applied/ubuntu/plucky-devel
  autotools_configure_options "--build=#{CREW_TARGET}\
    --disable-builddir \
    --disable-docs \
    --disable-exec-static-tramp \
    --enable-shared \
    --enable-pax_emutramp=experimental \
    --host=#{CREW_TARGET} \
    --without-gcc-arch"

  def self.patch
    downloader 'https://git.launchpad.net/ubuntu/+source/libffi/plain/debian/patches/no-toolexeclibdir.diff?h=applied/ubuntu/noble', '53d01b0ff395e91c4f8fa4a2c55f5efb5d61ad532310bc7aa8b72869a9cb9b14', 'no-toolexeclibdir.diff'
    system 'patch -Np1 -i no-toolexeclibdir.diff'
  end

  autotools_install_extras do
    FileUtils.install '.libs/libffi_convenience.a', "#{CREW_DEST_LIB_PREFIX}/libffi_pic.a", mode: 0o644
  end
end
