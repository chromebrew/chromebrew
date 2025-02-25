require 'buildsystems/autotools'

class A2png < Autotools
  description 'Converts plain ASCII text into PNG bitmap images.'
  homepage 'https://sourceforge.net/projects/a2png/'
  version '0.1.5'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://sourceforge.net/projects/a2png/files/a2png/#{version}/a2png-#{version}.tar.bz2"
  source_sha256 'd3ae1c771f5180d93f35cded76d9bb4c4cc2023dbe65613e78add3eeb43f736b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3ef790b5997c7b3f0340b37253f36c0e896609761665a4e6b0754094a5be87dc',
     armv7l: '3ef790b5997c7b3f0340b37253f36c0e896609761665a4e6b0754094a5be87dc',
     x86_64: 'fb4c73c3466be4cff337047a28064b5cac5db85b0cb1d213309b9d1975762212'
  })

  depends_on 'cairo'

  def self.patch
    # Replace hardcoded /tmp path with CREW_PREFIX/tmp
    system "sed -i 's,/tmp,#{File.join(CREW_PREFIX, 'tmp')},g' test/Makefile.in"
    Dir.chdir 'src' do
      # FreeBSD patch to avoid -Wimplicit-function-declaration errors.
      downloader 'https://raw.githubusercontent.com/freebsd/freebsd-ports/06dfcbd2cbebaf3b3b81744ed8adaa903f1b24b7/graphics/a2png/files/patch-src_image.h', '86d2cb207854649c486485d215ffc6758a4af6ab9b1acd5f6b266dd793f5c80e', 'patch-src_image.h'
      system 'patch -i patch-src_image.h'
      # FreeBSD patch to avoid C99 inline semantics.
      downloader 'https://raw.githubusercontent.com/freebsd/freebsd-ports/06dfcbd2cbebaf3b3b81744ed8adaa903f1b24b7/graphics/a2png/files/patch-src_image.c', 'fece9703dbc73447135bbb9bc2fd4d3af6052f8025e516fff0592257aa1377e0', 'patch-src_image.c'
      downloader 'https://raw.githubusercontent.com/freebsd/freebsd-ports/06dfcbd2cbebaf3b3b81744ed8adaa903f1b24b7/graphics/a2png/files/patch-src_parse.c', '65d0bf84b659381b18536498bf82d83386fc347ac80b374f1393eaf1dc5d80b2', 'patch-src_parse.c'
      system 'patch -i patch-src_image.c'
      system 'patch -i patch-src_parse.c'
    end
  end

  # We use the lib64 directory on 64-bit systems, even though we don't have multilib support.
  # This is unnecessary under FHS 3.0, but is mandatory under FHS 2.3.
  # FHS 3.0: https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch03s10.html#idm236092711120
  # FHS 2.3: https://refspecs.linuxfoundation.org/FHS_2.3/fhs-2.3.html#LIB64
  # In regards to buildsystems, this is the default behaviour for CMake and Meson, but not for Autotools.
  # CMake: https://gitlab.kitware.com/cmake/cmake/-/blob/v3.29.3/Modules/GNUInstallDirs.cmake?ref_type=tags#L231-236
  # Meson: https://github.com/mesonbuild/meson/blob/1.4.0/mesonbuild/utils/universal.py#L1029-L1030
  # Autotools: https://www.gnu.org/software/automake/manual/1.16.5/html_node/Standard-Directory-Variables.html
  # a2png expects cairo to be in $prefix/lib and $prefix/include/cairo, but we sometimes have it in $prefix/lib64.
  # As a result, we have to pass both directories rather than just --with-cairo-prefix=#{CREW_PREFIX}.
  configure_options "--with-cairo-lib=#{CREW_LIB_PREFIX} --with-cairo-include=#{CREW_PREFIX}/include/cairo"

  run_tests
end
