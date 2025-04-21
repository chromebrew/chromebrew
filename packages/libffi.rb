require 'buildsystems/autotools'

class Libffi < Autotools
  description 'The libffi library provides a portable, high level programming interface to various calling conventions.'
  homepage 'https://sourceware.org/libffi/'
  version '3.4.8'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libffi/libffi.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1e9431c4a784a86722fba6a8ab5ad15ae94710488acb6324fb0c2dbcb1f1470f',
     armv7l: '1e9431c4a784a86722fba6a8ab5ad15ae94710488acb6324fb0c2dbcb1f1470f',
       i686: '4e75ad692cfe86fb99e50a0a4f29deb6fcd26bd1b13e7611a08b08a37b721283',
     x86_64: '93abcc410d41c3797724d1fb79fabce71daa8ea660f105b56babb1b03345544a'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  # run_tests         # DejaGNU required

  # See https://git.launchpad.net/ubuntu/+source/libffi/tree/debian/rules?h=applied/ubuntu/plucky-devel
  configure_options "--build=#{CREW_TARGET}\
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

  configure_install_extras do
    FileUtils.install '.libs/libffi_convenience.a', "#{CREW_DEST_LIB_PREFIX}/libffi_pic.a", mode: 0o644
  end
end
