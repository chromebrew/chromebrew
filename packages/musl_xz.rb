require 'package'

class Musl_xz < Package
  description 'XZ is free general-purpose data compression software with a high compression ratio.'
  homepage 'http://tukaani.org/xz/'
  version '5.2.5-e7da-1'
  license 'public-domain, LGPL-2.1+ and GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/tukaani-project/xz.git'
  git_hashtag 'e7da44d5151e21f153925781ad29334ae0786101'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '4920c40308b221b02c82704f699de5ab302ac0f51643cf1fc30cc62837ca493d',
     armv7l: '4920c40308b221b02c82704f699de5ab302ac0f51643cf1fc30cc62837ca493d',
       i686: '6004dac184942b97e97315dbbc0bebdb3691b0a4437de7d085f1fc2a54088d32',
     x86_64: 'b88d42f2a8f3129c2b460257f539909d40205df41296b56d87cc6b3c96ba24f7'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'musl_native_toolchain' => :build

  is_static
  print_source_bashrc

  def self.build
    load "#{CREW_LIB_PATH}/lib/musl.rb"
    system 'NOCONFIGURE=1 ./autogen.sh --no-po4a'
    system "#{MUSL_ENV_OPTIONS} ./configure --prefix=#{CREW_MUSL_PREFIX} \
      --libdir=#{CREW_MUSL_PREFIX}/lib \
      --disable-doc \
      --disable-shared \
      --enable-static \
      --with-pic \
      --disable-rpath"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "LIBDIR=#{CREW_MUSL_PREFIX}/lib", 'install'
  end
end
