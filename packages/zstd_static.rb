require 'package'

class Zstd_static < Package
  description 'Zstandard - Fast real-time compression algorithm'
  homepage 'https://facebook.github.io/zstd/'
  version '1.5.7-1'
  license 'BSD or GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '3656581e4d8ab2cd9fd49d5b280139092bf6ec44970715142dc7a44af320f4b2',
     armv7l: '3656581e4d8ab2cd9fd49d5b280139092bf6ec44970715142dc7a44af320f4b2',
       i686: '9caa7aa0ce6b7b71165cc0b16d82ad83b9e609311225b381b574cd92acf18ae9',
     x86_64: '5f108a937cc27bb1ff05e7bc05bdb9e3eceb91204d76880f96103acdaa29a884'
  })

  conflicts_ok
  no_source_build
  no_zstd

  case ARCH
  when 'i686'
    @cross = 'i686-linux-musl'
  when 'x86_64'
    @cross = 'x86_64-linux-musl'
  when 'aarch64', 'armv7l'
    @cross = 'arm-linux-musleabihf'
  end

  def self.build
    File.write 'crew-static-builder.sh', <<~'BUILDER_EOF'
      #!/bin/bash
      # From https://gist.github.com/ryancdotorg/84275935f0b82578d8c222e2e915fc78
      # built binaries at https://ryanc-musl-bins.s3.amazonaws.com/SHA256SUMS.html

      set -eo pipefail
      set -x

      export BUILD_SCRIPT_DATE="$(date -r "$0" -Iseconds)"

      PV_VERSION=1.8.5
      SOCAT_VERSION=1.8.0.0
      NCURSES_VERSION=6.4
      READLINE_VERSION=8.2
      OPENSSL_VERSION=1.1.1w
      LIBPCAP_VERSION=1.10.4
      ZLIB_VERSION=1.3.1
      TCPDUMP_VERSION=4.99.4
      RSYNC_VERSION=3.3.0
      XZ_VERSION=5.8.1
      LZ4_VERSION=v1.10.0
      ZSTD_VERSION=v1.5.7
      XXHASH_VERSION=v0.8.2
      DROPBEAR_VERSION=2022.83
      GPGERROR_VERSION=1.48
      GCRYPT_VERSION=1.10.2
      GLIB_VERSION=2.80.0
      CARES_VERSION=1.28.1
      PCRE_VERSION=8.45
      WIRESHARK_VERSION=4.0.11
      LIBSODIUM_VERSION=1.0.19-RELEASE
      MINISIGN_VERSION=v0.11-ryanc.4
      SHA2SUM_VERSION=v0.3.1
      MULTICALL_VERSION=v0.0.6

      BASE_DIR=`pwd`
      SOURCE_DIR="$BASE_DIR/source"
      BUILD_DIR="$BASE_DIR/build"
      SCRIPT_DIR="`pwd`"
      OUTPUT_DIR="$SCRIPT_DIR/output"

      ORIG_PATH=$PATH

      function setcross() {
          MUSL_CROSS=${1:-armv7l-linux-musleabihf}
          CROSS_BIN="$BUILD_DIR/$MUSL_CROSS-cross/bin"
          CROSS_PFX="$CROSS_BIN/$MUSL_CROSS"
          BIN_DIR="$OUTPUT_DIR/$MUSL_CROSS"
          mkdir -p $BIN_DIR

          if command -v _ccache > /dev/null; then
              export CC="ccache $CROSS_PFX-gcc"
              export CXX="ccache $CROSS_PFX-g++"
          else
              export CC=$CROSS_PFX-gcc
              export CXX=$CROSS_PFX-g++
          fi

          export AR=$CROSS_PFX-ar
          export AS=$CROSS_PFX-as
          export LD=$CROSS_PFX-ld
          export RANLIB=$CROSS_PFX-ranlib

          export PATH=$CROSS_BIN:$ORIG_PATH
          export STRIP="$CROSS_PFX-strip -s -R .comment -R .hash -R .gnu.hash"
          export LDFLAGS="-flto -Wl,--gc-sections"
          export CFLAGS="-flto -fno-inline-small-functions -ffunction-sections -fdata-sections -Wl,--gc-sections -static -Os"
          export CXXFLAGS="$CFLAGS"
          export MAKEFLAGS="-sj$((`grep -c '^processor' /proc/cpuinfo` * 125 / 100))"
      }

      function setnative() {
          MUSL_CROSS=${1:-armv7l-linux-musleabihf}
          CROSS_BIN="$BUILD_DIR/$MUSL_CROSS-native/bin"
          # CROSS_PFX="$CROSS_BIN/$MUSL_CROSS"
          CROSS_PFX="$CROSS_BIN/"
          BIN_DIR="$OUTPUT_DIR/$MUSL_CROSS"
          mkdir -p $BIN_DIR

          if command -v _ccache > /dev/null; then
              export CC="ccache gcc"
              export CXX="ccache g++"
          else
              export CC=${CROSS_PFX}gcc
              export CXX=${CROSS_PFX}g++
          fi

          export AR=${CROSS_PFX}ar
          export AS=${CROSS_PFX}as
          export LD=${CROSS_PFX}ld
          export RANLIB=${CROSS_PFX}ranlib

          export PATH=$CROSS_BIN:$ORIG_PATH
          export STRIP="strip -s -R .comment -R .hash -R .gnu.hash"
          export LDFLAGS="-flto -Wl,--gc-sections"
          export CFLAGS="-flto -fno-inline-small-functions -ffunction-sections -fdata-sections -Wl,--gc-sections -static -Os"
          export CXXFLAGS="$CFLAGS"
          export MAKEFLAGS="-sj$((`grep -c '^processor' /proc/cpuinfo` * 125 / 100))"
      }

      function extract() {
          PACKAGE="$1"
          BASEURL="$2"
          FILEEXT="$3"
          VERSION="${4:-}"

          export PS4="+$arch:$PACKAGE+ "

          # Clean/Download/Extract
          mkdir -p "$BUILD_DIR"
          cd "$BUILD_DIR"

          if [ "$FILEEXT" = "git" ]; then
              if [ -d "$PACKAGE" ]; then
                  cd "$PACKAGE"
                  git clean -fdx
                  git reset --hard HEAD
                  if [[ ! -z "$VERSION" ]]; then
                      git checkout "$VERSION" \
                      || git fetch --depth 1 origin tag "$VERSION" --no-tags \
                      && git checkout "$VERSION"
                  else
                      git pull
                  fi
              else
                  if [[ ! -z "$VERSION" ]]; then
                      git clone --depth 1 --branch "$VERSION" "$BASEURL/$PACKAGE.$FILEEXT"
                  else
                      git clone --depth 1 "$BASEURL/$PACKAGE.$FILEEXT"
                  fi
                  cd "$PACKAGE"
              fi
              printf '%s  %s.git\n' $(git rev-parse HEAD) "$PACKAGE" >> "$BUILD_DIR/hashes"
          else
              if [ -d "$PACKAGE-$VERSION" ]; then rm -rf "$PACKAGE-$VERSION"; fi
              if ! tar -xaf "$PACKAGE-$VERSION.$FILEEXT" > /dev/null 2> /dev/null; then
                  curl -LO "$BASEURL/$PACKAGE-$VERSION.$FILEEXT"
                  if [ -d "$PACKAGE-$VERSION" ]; then rm -rf "$PACKAGE-$VERSION"; fi
                  tar -xaf "$PACKAGE-$VERSION.$FILEEXT"
              fi
              ln -fs "$PACKAGE-$VERSION" "$PACKAGE"
              sha256sum "$PACKAGE-$VERSION.$FILEEXT" >> "$BUILD_DIR/hashes"
              cd "$PACKAGE-$VERSION"
          fi

          # Patch
          if [ -d "$BUILD_DIR/patches" ]; then
              for f in "$BUILD_DIR/patches/$PACKAGE"-*.diff; do
                  [ -e "$f" ] || continue
                  patch -p1 < "$f"
              done
              for f in "$BUILD_DIR/patches/$PACKAGE"-*.sh; do
                  [ -e "$f" ] || continue
                  "$f"
              done
          fi
      }

      function output() {
          BIN="$1"
          DST="${2:-}"
          mkdir -p "$BIN_DIR"
          chmod 755 "$BIN"
          $STRIP "$BIN"
          cp "$BIN" "$BIN_DIR/$DST"
      }

      function get_musl() {
          cd "$BUILD_DIR"

          HASHES="musl.SHA512SUMS"
          FLAGS="-L -o $HASHES"
          if [ -e "$HASHES" ]; then
              FLAGS="$FLAGS -z $HASHES"
          fi
          curl $FLAGS https://musl.cc/SHA512SUMS

          if [ ! -e "$MUSL_CROSS-native.tgz" ]; then
              if [ -d "$MUSL_CROSS-native" ]; then
                 rm -rf "$MUSL_CROSS-native"
              fi
              curl -LO "https://musl.cc/$MUSL_CROSS-native.tgz"
          fi

          if (fgrep "$MUSL_CROSS-native.tgz" "$HASHES" | sha512sum --strict --warn --status -c -); then
              if [ ! -d "$MUSL_CROSS-native" ]; then
                  tar -xzf "$MUSL_CROSS-native.tgz"
              fi
          else
              rm "$MUSL_CROSS-native.tgz"
              get_musl
          fi
      }

      function build_pv() {
          # Download/extract
          extract pv https://www.ivarch.com/programs/sources tar.gz $PV_VERSION

          # Configure
          ./configure \
              --enable-static \
              --disable-nls \
              --disable-dependency-tracking

          # Build
          make
          output pv
          echo "** Finished building pv"
      }

      function build_openssl() {
          # Download/extract
          extract openssl https://www.openssl.org/source tar.gz $OPENSSL_VERSION

          TARGET="$1"
          if [ -z "$TARGET" ]; then
              case $MUSL_CROSS in
                  x86_64-linux-musl)
                  TARGET=linux-x86_64
                  ;;
                  aarch64-linux-musl)
                  TARGET=linux-aarch64
                  ;;
                  armv*-linux-*)
                  TARGET=linux-armv4
                  ;;
                  mips-linux-*)
                  TARGET=linux-mips32
                  ;;
                  mipsel-linux-*)
                  TARGET=linux-mips32
                  ;;
                  *)
                  TARGET=linux-generic32
                  ;;
              esac
          fi

          # Configure
          SOURCE_DATE_EPOCH="$(date -r CHANGES '+%s')" \
          ./Configure \
              --openssldir=/etc/ssl \
              no-shared no-async no-threads no-err no-hw no-engine no-dso \
              no-static-engine no-capieng no-comp \
              no-tests no-unit-test \
              no-ts no-cms \
              no-rfc3779 \
              no-srtp \
              no-ssl-trace no-ct no-multiblock \
              no-cmac no-blake2 no-asm \
              no-siphash \
              no-scrypt no-ocb no-egd \
              no-md4 no-whirlpool no-rmd160 \
              no-des no-bf no-rc2 no-rc4 no-rc5 \
              no-sm2 no-sm3 no-sm4 \
              no-gost no-idea no-cast no-seed no-camellia no-aria \
              no-chacha no-poly1305 \
              no-dh no-dsa no-psk no-srp \
              no-ec2m \
              no-weak-ssl-ciphers \
              no-dgram no-sctp \
              no-dtls no-ssl2 no-ssl3 no-tls1 no-tls1_1 \
              no-ssl3-method no-tls1-method no-tls1_1-method \
              no-dtls1-method no-dtls1_2-method \
              no-crypto-mdebug \
              $TARGET

          # Build
          SOURCE_DATE_EPOCH="$(date -r CHANGES '+%s')" \
          make
          output apps/openssl
          echo "** Finished building OpenSSL"
      }

      function build_gpgerror(){
          # Download/extract
          extract libgpg-error https://www.gnupg.org/ftp/gcrypt/libgpg-error tar.gz $GPGERROR_VERSION

          # Configure
          ./configure \
              --enable-silent-rules \
              --disable-languages \
              --disable-doc \
              --disable-tests \
              --disable-nls \
              --disable-dependency-tracking \
              --enable-static --disable-shared \
              --prefix="$BUILD_DIR/install" \
              --build=x86_64-linux-gnu \
              --host=$MUSL_CROSS

          # Build
          make install
          # no idea why this needs to be done...
          mkdir -p "$BUILD_DIR/install/bin"
          cp src/gpg-error-config "$BUILD_DIR/install/bin/"
          echo "** Finished building libgpg-error"
      }

      function build_gcrypt(){
          # Download/extract
          extract libgcrypt https://www.gnupg.org/ftp/gcrypt/libgcrypt tar.gz $GCRYPT_VERSION

          # Configure
          ./configure \
              --enable-silent-rules \
              --disable-doc \
              --disable-dependency-tracking \
              --enable-static --disable-shared \
              --enable-ciphers="aes chacha20" \
              --enable-pubkey-ciphers="ecc rsa" \
              --enable-digests="sha256 sha512" \
              --enable-kdfs="pkdf2" \
              --with-libgpg-error-prefix="$BUILD_DIR/install" \
              --prefix="$BUILD_DIR/install" \
              --build=x86_64-linux-gnu \
              --host=$MUSL_CROSS

          # Disable tests
          sed -Ei 's/(SUBDIRS\s*=.*)\s+tests(\s+.+)?/\1\2/' Makefile*

          # Build
          make install
          echo "** Finished building libgcrypt"
      }

      function build_cares(){
          # Download/extract
          extract c-ares https://c-ares.org/download tar.gz $CARES_VERSION

          # Configure
          ./configure \
              --prefix="$BUILD_DIR/install" \
              --build=x86_64-linux-gnu \
              --host=$MUSL_CROSS

          # Build
          make install
          echo "** Finished building c-ares"
      }

      function build_pcre(){
          # Download/extract
          extract pcre https://downloads.sourceforge.net/project/pcre/pcre/$PCRE_VERSION tar.gz $PCRE_VERSION

          # Configure
          ./configure \
              --prefix="$BUILD_DIR/install" \
              --build=x86_64-linux-gnu \
              --host=$MUSL_CROSS

          # Build
          make install
          echo "** Finished building pcre"
      }

      function build_glib(){
          # https://download.gnome.org/sources/glib/2.74/glib-2.74.5.tar.xz
          # Download/extract
          extract glib https://download.gnome.org/sources/glib/$(echo $GLIB_VERSION | cut -d . -f 1-2) tar.xz $GLIB_VERSION

          MESON_CROSS_FILE="cross_$MUSL_CROSS.txt"
          MESON_CROSS_OS=linux
          MESON_CROSS_ENDIAN=little
          MESON_CROSS_CPU=$(echo "$MUSL_CROSS" | cut -d - -f 1)
          case $MUSL_CROSS in
              x86_64-linux-musl)
              MESON_CROSS_FAMILY=x86_64
              #MESON_CROSS_WRAPPER=qemu-x86_64-static
              ;;
              aarch64-linux-musl)
              MESON_CROSS_FAMILY=aarch64
              MESON_CROSS_WRAPPER=qemu-aarch64-static
              ;;
              armv*-linux-musl*)
              MESON_CROSS_FAMILY=arm
              MESON_CROSS_WRAPPER=qemu-arm-static
              ;;
              mips-linux-musl*)
              MESON_CROSS_ENDIAN=big
              MESON_CROSS_FAMILY=mips
              MESON_CROSS_WRAPPER=qemu-mips-static
              ;;
              mipsel-linux-musl*)
              MESON_CROSS_FAMILY=mipsel
              MESON_CROSS_WRAPPER=qemu-mipsel-static
              ;;
              *)
              MESON_CROSS_FAMILY=unknown
              ;;
          esac

          cat > "$MESON_CROSS_FILE" <<EoF
      [binaries]
      c = '$CROSS_PFX-gcc'
      cpp = '$CROSS_PFX-g++'
      ar = '$CROSS_PFX-ar'
      as = '$CROSS_PFX-as'
      ld = '$CROSS_PFX-ld'
      strip = '$CROSS_PFX-strip'

      [host_machine]
      system = '$MESON_CROSS_OS'
      cpu_family = '$MESON_CROSS_FAMILY'
      cpu = '$MESON_CROSS_CPU'
      endian = '$MESON_CROSS_ENDIAN'
      ${MESON_CROSS_WRAPPER+exe_wrapper = "'$MESON_CROSS_WRAPPER'"}
      EoF

          # XXX this is probably a terrible idea...
          if [ "$MESON_CROSS_FAMILY" = "x86_64" ]; then
              # insert lines overriding check
              sed -i '0,/^if not gl_cv_func_frexpl_works and/s//gl_cv_func_frexpl_broken_beyond_repair = false\n&/' glib/gnulib/meson.build
          fi

          # Configure
          CFLAGS="" CPPFLAGS="" LDFLAGS="" \
          meson setup \
              --prefix "$BUILD_DIR/install" \
              --buildtype minsize \
              --prefer-static \
              --default-library static \
              --cross-file "$MESON_CROSS_FILE" \
              -Dtests=false \
              "build_$MUSL_CROSS"

          # Build
          pushd "build_$MUSL_CROSS"
          meson compile
          meson install
          popd
          echo "** Finished building glib"
      }

      function build_wireshark(){
          # Download/extract
          extract wireshark https://www.wireshark.org/download/src/all-versions tar.xz $WIRESHARK_VERSION


          # Configure
          #sed -Ei \
          #    "s!/opt/local/lib!$BUILD_DIR/glib-$GLIB_VERSION/build_$MUSL_CROSS/install/usr/local/lib!" \
          #    cmake/modules/Find{GLIB2,GMODULE2,GTHREAD2}.cmake
          mkdir build
          pushd build
          PKG_CONFIG_LIBDIR="$BUILD_DIR/install/lib/pkgconfig" \
          CMAKE_PREFIX_PATH="$BUILD_DIR/install" \
          CFLAGS="-I$BUILD_DIR/install/include $CFLAGS" \
          CPPFLAGS="-I$BUILD_DIR/install/include $CPPFLAGS" \
          LDFLAGS="-L$BUILD_DIR/install/lib $CPPFLAGS" \
          cmake \
              -DBUILD_wireshark=OFF -DBUILD_sharkd=OFF -DBUILD_tshark=OFF \
              -DBUILD_capinfos=OFF -DBUILD_captype=OFF -DBUILD_dftest=OFF \
              -DBUILD_randpkt=OFF -DBUILD_dumpcap=OFF -DBUILD_rawshark=OFF \
              -DUSE_STATIC=ON -DENABLE_STATIC=ON -DENABLE_PLUGINS=OFF \
              -DBUILD_editcap=ON \
              -DBUILD_mergecap=ON \
              -DBUILD_reordercap=ON \
              -DBUILD_text2pcap=ON \
              -DENABLE_ZLIB=ON \
              ..

          # Build
          make
          output run/editcap
          output run/mergecap
          output run/text2pcap
          output run/reordercap
          popd
          echo "** Finished building wireshark"
      }

      function build_libpcap(){
          # Download/extract
          extract libpcap https://www.tcpdump.org/release tar.gz $LIBPCAP_VERSION

          # Configure
          CFLAGS="-I$BUILD_DIR/openssl-$OPENSSL_VERSION/include -DNETDB_INTERNAL=-1 $CFLAGS" \
          LDFLAGS="-L$BUILD_DIR/openssl-$OPENSSL_VERSION $LDFLAGS" \
          ./configure \
              --enable-remote \
              --disable-usb \
              --disable-netmap \
              --disable-bluetooth \
              --disable-dbus \
              --disable-rdma \
              --disable-shared \
              --prefix="$BUILD_DIR/install" \
              --build=x86_64-linux-gnu \
              --host=$MUSL_CROSS

          # Build
          make
          make install
          output rpcapd/rpcapd
          echo "** Finished building libpcap"
      }

      function build_tcpdump(){
          # Download/extract
          extract tcpdump https://www.tcpdump.org/release tar.gz $TCPDUMP_VERSION

          # The configure script fails to detect OpenSSL if DES is disabled...
          fgrep -rl DES_cbc_encrypt . \
          | xargs perl -i -pe 's/DES_cbc_encrypt/AES_cbc_encrypt/g'

          # Configure
          CFLAGS="-I$BUILD_DIR/openssl-$OPENSSL_VERSION/include -DNETDB_INTERNAL=-1 $CFLAGS" \
          LDFLAGS="-L$BUILD_DIR/openssl-$OPENSSL_VERSION $LDFLAGS" \
          ./configure \
              --build=x86_64-linux-gnu \
              --host=$MUSL_CROSS

          # Build
          make
          output tcpdump
          echo "** Finished building tcpdump"
      }

      function build_proberelay(){
          $CROSS_PFX-gcc \
              -I$BUILD_DIR/install/include $CFLAGS \
              -L$BUILD_DIR/install/lib $LDFLAGS \
              -o "$BIN_DIR/proberelay" \
              "$BUILD_DIR/proberelay.c" \
              -lpcap
          $STRIP "$BIN_DIR/proberelay"

          echo "** Finished building proberelay"
      }

      function build_ncurses() {
          # Download/extract
          extract ncurses https://invisible-mirror.net/archives/ncurses tar.gz $NCURSES_VERSION

          # Configure
          ./configure \
              --disable-shared \
              --enable-static \
              --build=x86_64-linux-gnu \
              --host=$MUSL_CROSS

          # Build
          make libs
          echo "** Finished building ncurses"
      }

      function build_zlib() {
          extract zlib https://zlib.net tar.gz $ZLIB_VERSION

          # Configure
          ./configure --static

          # Build
          make libz.a
          echo "** Finished building zlib"
      }

      function build_xz() {
          # Download/extract
          extract xz https://tukaani.org/xz tar.xz $XZ_VERSION

          # Configure
          ./configure \
              --disable-debug \
              --disable-dependency-tracking \
              --disable-silent-rules \
              --disable-shared \
              --disable-nls \
              --disable-lzmadec \
              --disable-lzmainfo \
              --disable-microlzma \
              --disable-lzip-decoder \
              --disable-scripts \
              --disable-doc \
              --enable-small \
              --enable-static \
              --prefix="$BUILD_DIR/install"

          # fuck it, we'll use violence to get static binaries
          sed -Ei \
              's/^(\s+..LIBTOOLFLAGS.\s+--mode=link.*)\\$/\1-all-static \\/' \
              src/xz{,dec}/Makefile

          # Build
          make install
          output "$BUILD_DIR/install/bin/xz"
      }

      function build_xzdec() {
          # Download/extract
          extract xz https://tukaani.org/xz tar.xz $XZ_VERSION

          # Configure for barebones xzdec
          ./configure \
              --disable-debug \
              --disable-dependency-tracking \
              --disable-silent-rules \
              --disable-shared \
              --disable-nls \
              --disable-lzmadec \
              --disable-lzmainfo \
              --disable-microlzma \
              --disable-lzip-decoder \
              --disable-scripts \
              --disable-doc \
              --enable-small \
              --enable-static \
              --enable-checks=crc32 \
              --enable-decoders=lzma1,lzma2,delta,x86,arm,armthumb,arm64 \
              --prefix="$BUILD_DIR/install" \
              --build=$MUSL_CROSS \
              --host=$MUSL_CROSS

          # fuck it, we'll use violence to get static binaries
          sed -Ei \
              's/^(\s+..LIBTOOLFLAGS.\s+--mode=link.*)\\$/\1-all-static \\/' \
              src/xz{,dec}/Makefile

          # Rebuild
          make clean
          make install
          output "$BUILD_DIR/install/bin/xzdec"

          # Multicall object
          cd src/xzdec
          sed -E 's/^[ ]*//' <<EoF >> Makefile

          xzdec-main.o: xzdec.c
          	\$(AM_V_CC)\$(CC) \$(DEFS) \$(DEFAULT_INCLUDES) \$(INCLUDES) \$(xzdec_CPPFLAGS) \$(CPPFLAGS) \$(AM_CFLAGS) \$(CFLAGS) -c -DXZDEC_MAIN=xzdec_main -o xzdec-main.o `test -f 'xzdec.c' || echo '\$(srcdir)/'`xzdec.c

          xzdec-multicall.o: xzdec-main.o \$(xzdec_DEPENDENCIES) \$(EXTRA_xzdec_DEPENDENCIES)
          	\$(AM_V_CCLD)\$(LINK) --entry xzdec_main -r xzdec-main.o \$(filter-out xzdec-xzdec.o,\$(xzdec_OBJECTS)) ../../src/liblzma/.libs/liblzma.a
      EoF

          make xzdec-main.o xzdec-multicall.o
          echo "** Finished building xzdec"
      }

      function build_lz4() {
          extract lz4 https://github.com/lz4 git $LZ4_VERSION
          make
          #output programs/lz4
          echo "** Finished building lz4"
      }

      function build_xxHash() {
          extract xxHash https://github.com/Cyan4973 git $XXHASH_VERSION
          make
          #output xxhsum
          echo "** Finished building xxHash"
      }

      function build_zstd() {
          extract zstd https://github.com/facebook git $ZSTD_VERSION

          make clean
          CFLAGS="-I$BUILD_DIR/zlib-$ZLIB_VERSION -I$BUILD_DIR/lz4/lib $CFLAGS" \
          LDFLAGS="-L$BUILD_DIR/zlib-$ZLIB_VERSION -L$BUILD_DIR/lz4/lib $LDFLAGS" \
          FLAGS="$CFLAGS $LDFLAGS -Os" \
          make zstd ZSTD_LEGACY_SUPPORT=0 \
                    HAVE_ZLIB=0 HAVE_LZMA=0 HAVE_LZ4=0 BACKTRACE=0
          output programs/zstd zstd-only
          CFLAGS="-I$BUILD_DIR/zlib-$ZLIB_VERSION -I$BUILD_DIR/lz4/lib $CFLAGS" \
          LDFLAGS="-L$BUILD_DIR/zlib-$ZLIB_VERSION -L$BUILD_DIR/lz4/lib $LDFLAGS" \
          FLAGS="$CFLAGS $LDFLAGS -Os" \
          make -C programs zstd-decompress ZSTD_LEGACY_SUPPORT=0 \
                    HAVE_ZLIB=0 HAVE_LZMA=0 HAVE_LZ4=0 BACKTRACE=0
          output programs/zstd-decompress unzstd

          make clean
          CFLAGS="-I$BUILD_DIR/zlib-$ZLIB_VERSION -I$BUILD_DIR/lz4/lib $CFLAGS" \
          LDFLAGS="-L$BUILD_DIR/zlib-$ZLIB_VERSION -L$BUILD_DIR/lz4/lib $LDFLAGS" \
          FLAGS="$CFLAGS $LDFLAGS -DZSTD_NO_UNUSED_FUNCTIONS -Os" \
          make zstd ZSTD_LEGACY_SUPPORT=0 \
                    HAVE_ZLIB=0 HAVE_LZMA=0 HAVE_LZ4=0 \
                    HAVE_THREAD=0 ZSTD_LIB_MINIFY=1 BACKTRACE=0 ZSTD_NO_INLINE=1
          output programs/zstd zstd-mini
          CFLAGS="-I$BUILD_DIR/zlib-$ZLIB_VERSION -I$BUILD_DIR/lz4/lib $CFLAGS" \
          LDFLAGS="-L$BUILD_DIR/zlib-$ZLIB_VERSION -L$BUILD_DIR/lz4/lib $LDFLAGS" \
          FLAGS="$CFLAGS $LDFLAGS -DZSTD_NO_UNUSED_FUNCTIONS -Os" \
          make -C programs zstd-decompress ZSTD_LEGACY_SUPPORT=0 ZSTD_NOCOMPRESS=1 \
                    HAVE_ZLIB=0 HAVE_LZMA=0 HAVE_LZ4=0 \
                    HAVE_THREAD=0 ZSTD_LIB_MINIFY=1 BACKTRACE=0 ZSTD_NO_INLINE=1
          output programs/zstd-decompress unzstd-mini

          make clean
          CFLAGS="-I$BUILD_DIR/install/include $CFLAGS" \
          LDFLAGS="-L$BUILD_DIR/install/lib $LDFLAGS" \
          FLAGS="$CFLAGS $LDFLAGS -DZSTD_NO_UNUSED_FUNCTIONS -Os" \
          make zstd ZSTD_LEGACY_SUPPORT=0 \
                    HAVE_ZLIB=0 HAVE_LZMA=1 HAVE_LZ4=0 \
                    HAVE_THREAD=0 ZSTD_LIB_MINIFY=1 BACKTRACE=0 ZSTD_NO_INLINE=1
          output programs/zstd zstd-xz-mini

          make clean
          CFLAGS="-I$BUILD_DIR/zlib-$ZLIB_VERSION -I$BUILD_DIR/lz4/lib $CFLAGS" \
          LDFLAGS="-L$BUILD_DIR/zlib-$ZLIB_VERSION -L$BUILD_DIR/lz4/lib $LDFLAGS" \
          FLAGS="$CFLAGS $LDFLAGS -O3" \
          make zstd BACKTRACE=0 ZSTD_LEGACY_SUPPORT=2
          output programs/zstd zstd-fast

          make clean
          CFLAGS="-I$BUILD_DIR/install/include -I$BUILD_DIR/zlib-$ZLIB_VERSION -I$BUILD_DIR/lz4/lib $CFLAGS" \
          LDFLAGS="-L$BUILD_DIR/install/lib -L$BUILD_DIR/zlib-$ZLIB_VERSION -L$BUILD_DIR/lz4/lib $LDFLAGS" \
          FLAGS="$CFLAGS $LDFLAGS -O3" \
          make zstd BACKTRACE=0 ZSTD_LEGACY_SUPPORT=2
          output programs/zstd zstd-full

          make clean
          CFLAGS="-I$BUILD_DIR/zlib-$ZLIB_VERSION -I$BUILD_DIR/lz4/lib $CFLAGS" \
          LDFLAGS="-L$BUILD_DIR/zlib-$ZLIB_VERSION -L$BUILD_DIR/lz4/lib $LDFLAGS" \
          FLAGS="$CFLAGS $LDFLAGS -Os" \
          make
          output programs/zstd

          echo "** Finished building zstd"
      }

      function build_readline() {
          # Download/extract
          extract readline https://ftp.gnu.org/gnu/readline tar.gz $READLINE_VERSION

          # Prevent building examples (which can't be done when cross-compiling)
          sed -i -e 's|examples/Makefile||g' configure.ac

          # Configure
          autoconf
          ./configure \
              --disable-shared \
              --enable-static \
              --build=x86_64-linux-gnu \
              --host=$MUSL_CROSS

          # Build
          make

          # Note that socat looks for readline in <readline/readline.h>, so we need
          # that directory to exist.
          ln -s "$BUILD_DIR/readline-$READLINE_VERSION" "$BUILD_DIR/readline"
          echo "** Finished building readline"
      }

      function build_dropbear() {
          # Download/extract
          extract dropbear https://github.com/mkj git DROPBEAR_$DROPBEAR_VERSION

          if [ ! -e configure ]; then
              autoconf; autoheader
          fi

          SAVED_CFLAGS="$CFLAGS"
          CFLAGS="$CFLAGS -Wno-undef"

          # Configure
          ./configure \
              --build=x86_64-linux-gnu \
              --host=$MUSL_CROSS \
              --enable-static \
              --prefix=/ \
              --exec-prefix=/usr \
              --disable-zlib \
              --disable-lastlog \
              --disable-utmp --disable-utmpx \
              --disable-wtmp --disable-wtmpx \
              --disable-pututline --disable-pututxline \
              --enable-bundled-libtom

          # Set build options
          sed -E 's/^\s*//' <<EoF > localoptions.h
              #define INETD_MODE 0

              #define DROPBEAR_SVR_LOCALTCPFWD 0
              #define DROPBEAR_SVR_REMOTETCPFWD 0
              #define DROPBEAR_SVR_AGENTFWD 0

              #define DROPBEAR_USER_ALGO_LIST 0
              #define DROPBEAR_CHACHA20POLY1305 0
              #define DROPBEAR_AES128 1
              #define DROPBEAR_AES256 1

              #define DROPBEAR_ENABLE_CTR_MODE 1
              #define DROPBEAR_ENABLE_CBC_MODE 0
              #define DROPBEAR_ENABLE_GCM_MODE 1

              #define DROPBEAR_SHA1_HMAC 0
              #define DROPBEAR_SHA1_96_HMAC 0
              #define DROPBEAR_SHA2_256_HMAC 1

              #define DROPBEAR_RSA 0
              #define DROPBEAR_DSS 0
              #define DROPBEAR_ECDSA 0
              #define DROPBEAR_ED25519 1

              #define DROPBEAR_SK_RSA DROPBEAR_RSA
              #define DROPBEAR_SK_DSS DROPBEAR_DSS
              #define DROPBEAR_SK_ECDSA DROPBEAR_ECDSA
              #define DROPBEAR_SK_ED25519 DROPBEAR_ED25519

              #define DROPBEAR_DH_GROUP14_SHA1 0
              #define DROPBEAR_DH_GROUP14_SHA256 0
              #define DROPBEAR_DH_GROUP16 0
              #define DROPBEAR_DH_GROUP1 0
              #define DROPBEAR_ECDH 0
              #define DROPBEAR_CURVE25519 1

              #define DROPBEAR_SFTPSERVER 0
              #define DO_MOTD 0
      EoF
          # update version string
          sed -En "s/^(#define\s+DROPBEAR_VERSION\s+\"[0-9.]+).*/\1+$(git log -1 --format=%h)\"/p" \
              sysoptions.h >> localoptions.h
          # hide version banner
          sed -Ei 's/^(#define\s+LOCAL_IDENT).*/\1 "SSH-2.0-dropbear"/' sysoptions.h
          # Enable the delay hostkey option by default
          sed -Ei 's/^(\s*svr_opts.delay_hostkey\s*=\s*)0;/\11;/' svr-runopts.c
          # fully disable RSA
          sed -Ei 's/^(#define DROPBEAR_RSA_SHA1) 1$/\1 DROPBEAR_RSA/' default_options.h
          # fully disable DSA
          sed -Ei 's/^(#define DROPBEAR_DSS) 1$/\1 0/' sysoptions.h

          # actually compile
          if [ "$MUSL_CROSS" = "x86_64-linux-musl" ]; then
              sed -Ei 's/^(#define DROPBEAR_RSA) 0$/\1 1/' localoptions.h
              sed -Ei 's/^(#define DROPBEAR_ECDSA) 0$/\1 1/' localoptions.h
              sed -Ei 's/^(#define DROPBEAR_DSS) 0$/\1 1/' localoptions.h
              sed -Ei 's/^(#define DROPBEAR_DSS) 0$/\1 1/' sysoptions.h
              make PROGRAMS='dropbearconvert dropbearkey' MULTI=1
              output dropbearmulti dbkeyconv
          else
              export LTM_CFLAGS='-Os'
              make PROGRAMS='dropbear'
              output dropbear

              make PROGRAMS='dbclient'
              output dbclient

              make clean
              CFLAGS="$CFLAGS -DDROPBEARKEY_RETURN_TRUE=1" \
              make PROGRAMS='dropbear dropbearkey' MULTI=1
              output dropbearmulti dbmulti

              make clean
              CFLAGS="$CFLAGS -DDROPBEARKEY_RETURN_TRUE=1" \
              make PROGRAMS='dropbear dbclient dropbearkey' MULTI=1
              output dropbearmulti dbmulti-cli

              make clean
              CFLAGS="$CFLAGS -DDROPBEARKEY_RETURN_TRUE=1" \
              make PROGRAMS='dropbear dropbearconvert dropbearkey' MULTI=1
              output dropbearmulti dbmulti-conv

              make clean
              make PROGRAMS='dropbear dropbearkey' MULTI=1
              output dropbearmulti dbmulti-key

              make clean
              CFLAGS="$CFLAGS -DDROPBEARKEY_RETURN_TRUE=1" \
              make PROGRAMS='dropbear scp dropbearkey' MULTI=1
              output dropbearmulti dbmulti-scp

              make clean
              CFLAGS="$CFLAGS -DDROPBEARKEY_RETURN_TRUE=1" \
              make PROGRAMS='dropbear dbclient dropbearconvert dropbearkey' MULTI=1
              output dropbearmulti dbmulti-cli-conv

              make clean
              make PROGRAMS='dropbear dbclient dropbearkey' MULTI=1
              output dropbearmulti dbmulti-cli-key

              make clean
              CFLAGS="$CFLAGS -DDROPBEARKEY_RETURN_TRUE=1" \
              make PROGRAMS='dropbear dbclient scp dropbearkey' MULTI=1
              output dropbearmulti dbmulti-cli-scp

              make clean
              make PROGRAMS='dropbear dropbearconvert dropbearkey' MULTI=1
              output dropbearmulti dbmulti-conv-key

              make clean
              CFLAGS="$CFLAGS -DDROPBEARKEY_RETURN_TRUE=1" \
              make PROGRAMS='dropbear dropbearconvert scp dropbearkey' MULTI=1
              output dropbearmulti dbmulti-conv-scp

              make clean
              make PROGRAMS='dropbear dropbearkey scp' MULTI=1
              output dropbearmulti dbmulti-key-scp

              make clean
              make PROGRAMS='dropbear dbclient dropbearconvert dropbearkey' MULTI=1
              output dropbearmulti dbmulti-cli-conv-key

              make clean
              CFLAGS="$CFLAGS -DDROPBEARKEY_RETURN_TRUE=1" \
              make PROGRAMS='dropbear dbclient dropbearconvert scp dropbearkey' MULTI=1
              output dropbearmulti dbmulti-cli-conv-scp

              make clean
              make PROGRAMS='dropbear dbclient dropbearkey scp' MULTI=1
              output dropbearmulti dbmulti-cli-key-scp

              make clean
              make PROGRAMS='dropbear dropbearconvert dropbearkey scp' MULTI=1
              output dropbearmulti dbmulti-conv-key-scp

              make clean
              make PROGRAMS='dropbear dbclient dropbearconvert dropbearkey scp' MULTI=1
              output dropbearmulti dbmulti-cli-conv-key-scp
          fi
          echo "** Finished building dropbear"
          CFLAGS="$SAVED_CFLAGS"
      }

      function build_socat() {
          # Download/extract
          extract socat http://www.dest-unreach.org/socat/download tar.gz $SOCAT_VERSION

          # Configure
          SOURCE_DATE_EPOCH="$(date -r CHANGES '+%s')" \
          BUILD_DATE="$(date -r CHANGES '+%b %e %Y %H:%M:%S')" \
          CFLAGS="-I$BUILD_DIR -I$BUILD_DIR/openssl-$OPENSSL_VERSION/include -DNETDB_INTERNAL=-1 $CFLAGS" \
          LDFLAGS="-L$BUILD_DIR/readline-$READLINE_VERSION -L$BUILD_DIR/ncurses-$NCURSES_VERSION/lib -L$BUILD_DIR/openssl-$OPENSSL_VERSION $LDFLAGS" \
          LIBS="$BUILD_DIR/ncurses-$NCURSES_VERSION/lib/libncurses.a" \
          ./configure \
              --enable-openssl-base=$BUILD_DIR/openssl-$OPENSSL_VERSION \
              --enable-openssl \
              --enable-msglevel=info \
              --disable-tun \
              --disable-sctp \
              --disable-vsock \
              --disable-readline \
              --disable-sycls \
              --disable-filan \
              --disable-udplite \
              --disable-dccp \
              --build=x86_64-linux-gnu \
              --host=$MUSL_CROSS

          sed -Ei 's/#define\s+HAVE_GETPROTOBYNUMBER_R.*/#define HAVE_GETPROTOBYNUMBER_R 0/' config.h

          # Build
          SOURCE_DATE_EPOCH="$(date -r CHANGES '+%s')" \
          BUILD_DATE="$(date -r CHANGES '+%b %e %Y %H:%M:%S')" \
          make
          output socat socat-openssl

          make clean
          SOURCE_DATE_EPOCH="$(date -r CHANGES '+%s')" \
          BUILD_DATE="$(date -r CHANGES '+%b %e %Y %H:%M:%S')" \
          CFLAGS="-I$BUILD_DIR -DNETDB_INTERNAL=-1 $CFLAGS" \
          LDFLAGS="-L$BUILD_DIR/readline-$READLINE_VERSION -L$BUILD_DIR/ncurses-$NCURSES_VERSION/lib $LDFLAGS" \
          LIBS="$BUILD_DIR/ncurses-$NCURSES_VERSION/lib/libncurses.a" \
          ./configure \
              --disable-openssl \
              --enable-msglevel=info \
              --disable-tun \
              --disable-sctp \
              --disable-vsock \
              --disable-readline \
              --disable-sycls \
              --disable-filan \
              --disable-udplite \
              --disable-dccp \
              --build=x86_64-linux-gnu \
              --host=$MUSL_CROSS

          sed -Ei 's/#define\s+HAVE_GETPROTOBYNUMBER_R.*/#define HAVE_GETPROTOBYNUMBER_R 0/' config.h

          # Build
          SOURCE_DATE_EPOCH="$(date -r CHANGES '+%s')" \
          BUILD_DATE="$(date -r CHANGES '+%b %e %Y %H:%M:%S')" \
          make
          output socat

          echo "** Finished building socat"
      }

      function build_rsync() {
          # Download/extract
          extract rsync https://download.samba.org/pub/rsync/src tar.gz $RSYNC_VERSION

          OPTS="--disable-roll-simd --disable-roll-asm --disable-md2man --disable-debug --disable-locale"
          if [ "$MUSL_CROSS" != "x86_64-linux-musl" ]; then
              OPTS="$OPTS"
          else
              OPTS="$OPTS"
          fi

          # Configure
          CFLAGS="-I$BUILD_DIR/openssl-$OPENSSL_VERSION/include -I$BUILD_DIR/zlib-$ZLIB_VERSION -I$BUILD_DIR/xxHash -I$BUILD_DIR/zstd/lib -I$BUILD_DIR/lz4/lib $CFLAGS" \
          CXXFLAGS="$CFLAGS" \
          LDFLAGS="-L$BUILD_DIR/openssl-$OPENSSL_VERSION -L$BUILD_DIR/zlib-$ZLIB_VERSION -L$BUILD_DIR/xxHash -L$BUILD_DIR/zstd/lib -L$BUILD_DIR/lz4/lib $LDFLAGS" \
          ./configure \
              --disable-debug $OPTS \
              --build=x86_64-linux-gnu \
              --host=$MUSL_CROSS

          # Build
          make
          output rsync rsync-openssl

          make clean
          # Configure
          CFLAGS="-I$BUILD_DIR/zlib-$ZLIB_VERSION -I$BUILD_DIR/xxHash -I$BUILD_DIR/zstd/lib -I$BUILD_DIR/lz4/lib $CFLAGS" \
          CXXFLAGS="$CFLAGS" \
          LDFLAGS="-L$BUILD_DIR/zlib-$ZLIB_VERSION -L$BUILD_DIR/xxHash -L$BUILD_DIR/zstd/lib -L$BUILD_DIR/lz4/lib $LDFLAGS" \
          ./configure \
              --disable-debug $OPTS \
              --disable-openssl \
              --build=x86_64-linux-gnu \
              --host=$MUSL_CROSS

          # Build
          make
          output rsync

          echo "** Finished building rsync"
      }

      function build_libsodium(){
          # Download/extract
          extract libsodium https://github.com/jedisct1 git $LIBSODIUM_VERSION

          # Configure
          ./configure \
              --enable-static \
              --disable-shared \
              --disable-asm \
              --disable-ssp \
              --without-pthreads \
              --prefix="$BUILD_DIR/install" \
              --build=x86_64-linux-gnu \
              --host=$MUSL_CROSS

          # Build
          make install
          echo "** Finished building libsodium"
      }

      function build_minisign(){
          # Download/extract
          extract minisign https://github.com/ryancdotorg git $MINISIGN_VERSION

          # Build
          WITH_PTHREADS=0 \
          CC="$CROSS_PFX-gcc" \
          CFLAGS="-I$BUILD_DIR/install/include $CFLAGS" \
          LDFLAGS="-L$BUILD_DIR/install/lib $LDFLAGS" \
          make bin/miniverify bin/minisign \
               obj/miniverify_multicall.o \
               obj/minisign_multicall.o
          output bin/miniverify
          output bin/minisign
          echo "** Finished building minisign"
      }

      function build_sha2sum(){
          # Download/extract
          extract sha2sum https://github.com/ryancdotorg git $SHA2SUM_VERSION

          # Build
          CFLAGS="-I$BUILD_DIR/install/include $CFLAGS" \
          make bin/sha2sum bin/sha256sum \
              obj/sha256sum_multicall.o \
              obj/sha2sum_nacl_sha512_multicall.o
          output bin/sha2sum
          output bin/sha256sum
          echo "** Finished building sha2sum"
      }

      function build_multicall(){
          # Download/extract
          extract multicall https://github.com/ryancdotorg git $MULTICALL_VERSION

          # Build
          LDFLAGS="-L$BUILD_DIR/install/lib $LDFLAGS" \
          make bin/multicall-miniverify-sha256sum{,-xzdec} \
               bin/multicall-mini{verify,sign}-sha2sum{,-xzdec}
          output bin/multicall-miniverify-sha256sum
          output bin/multicall-miniverify-sha256sum-xzdec
          output bin/multicall-miniverify-sha2sum
          output bin/multicall-miniverify-sha2sum-xzdec
          output bin/multicall-minisign-sha2sum
          output bin/multicall-minisign-sha2sum-xzdec
          echo "** Finished building multicall"
      }



      function unpack_patches() {
      # tar -C BUILD_DIR -cz --owner=0 --group=0 patches xxd.c | base64 -w79 \
      # | sed -e '/[<]_eof/,/^_eof/{//!d;r /dev/stdin' -e '}' builder.sh \
      # | sponge builder.sh
      base64 -d <<_eof | tar -C "$1" -xvz
      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
      zZ/78bp//B3xMHIIAGAEA
      _eof
      }

      function buildall() {
          [ -d "$BUILD_DIR/install" ] && rm -rf "$BUILD_DIR/install"
          # setcross "$1"
          setnative "$1"

          DISABLE_WIRESHARK=""

          if [ "$MUSL_CROSS" = "mips-linux-muslsf" ]; then
              DISABLE_WIRESHARK="1"
          fi

          get_musl

          ${CROSS_PFX}gcc $CFLAGS $LDFLAGS -o "$BIN_DIR/xxd" "$BUILD_DIR/xxd.c"
          $STRIP "$BIN_DIR/xxd"

          ${CROSS_PFX}gcc $CFLAGS $LDFLAGS -o "$BIN_DIR/sav" "$BUILD_DIR/sav.c"
          $STRIP "$BIN_DIR/sav"

          ${CROSS_PFX}gcc $CFLAGS $LDFLAGS -o "$BIN_DIR/pause" "$BUILD_DIR/pause.c" -nostartfiles
          $STRIP "$BIN_DIR/pause"

          build_xzdec

          build_pv

          build_zlib

          build_xz
          build_lz4
          build_zstd
      }

      function main() {
          HASH=$(sha256sum $0|head -c16)
          mkdir -p "$BUILD_DIR"

          if [ ! -f .gitignore ]; then
              echo -e 'output\npatches\n.gitignore' > .gitignore
          fi

          if [ ! -d "$BUILD_DIR/patches" ]; then
              unpack_patches "$BUILD_DIR"
          fi

          if [ ! -z "$1" ]; then
              if [ "$1" = "unpack" ]; then
                  true
              elif [ "$1" = "repack" -a -d "$BUILD_DIR/patches" ]; then
                  cp -a $0 $0.bak
                  tar -C $BUILD_DIR -cz --owner=0 --group=0 patches xxd.c sav.c proberelay.c pause.c | base64 -w79 \
                  | sed -e '/[<]_eof/,/^_eof/{//!d;r /dev/stdin' -e '}' $0 \
                  | sponge $0
              else
                  buildall "$1"
              fi
              exit 0
          fi

          # armel-linux-musleabihf
          # mips-linux-musl mips-linux-muslsf # mipsel-linux-musl mipsel-linux-muslsf mipsel-linux-musln32 mipsel-linux-musln32sf
          for arch in armv7l-linux-musleabihf x86_64-linux-musl mips-linux-muslsf armv5l-linux-musleabihf aarch64-linux-musl
          do
              echo "** building for $arch **"
              export arch
              export PS4="+$arch+ "
              buildall "$arch"
              echo "** finished $arch bins **"
          done

          echo "** Finished **"
      }

      main "$@"
      # vim:sw=4:ts=4:et:
    BUILDER_EOF
    Kernel.system "bash ./crew-static-builder.sh #{@cross}"
  end

  def self.install
    FileUtils.install "output/#{@cross}/zstd-full", "#{CREW_DEST_PREFIX}/bin/zstd", mode: 0o755
    FileUtils.install "output/#{@cross}/zstd-full", "#{CREW_DEST_PREFIX}/bin/zstd-static", mode: 0o755
  end
end
