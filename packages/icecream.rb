# Adapted from Arch Linux icecream PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=icecream

require 'package'

class Icecream < Package
  description 'takes compile jobs from your build and distributes it to remote machines allowing a parallel build on several machines.'
  homepage 'https://github.com/icecc/icecream'
  version '1.4'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/icecc/icecream/archive/refs/tags/1.4.tar.gz'
  source_sha256 '249dcf74f0fc477ff9735ff0bdcdfaa4c257a864c4db5255d8b25c9f4fd20b6b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1e9f3f7b04cc40f8ed6a01baf6cd8bee2ec8079b3e35a701146d1ee7185ca706',
     armv7l: '1e9f3f7b04cc40f8ed6a01baf6cd8bee2ec8079b3e35a701146d1ee7185ca706',
       i686: '489103234caa73c4f9c9dd999c8b54cf12a4d69c89423337375e21caba242eac',
     x86_64: '7560a473bb913b928f84d207dac8d5d24bc0ba6dcfc1529dcb6f43165a1eb5fd'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'bzip2' # R
  depends_on 'docbook2x' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libarchive' # R
  depends_on 'libcap_ng' # R
  depends_on 'libxml2' # R
  depends_on 'llvm16_lib' => :build
  depends_on 'lz4' # R
  depends_on 'lzo' # R
  depends_on 'openssl' # R
  depends_on 'perl_xml_namespacesupport' => :build
  depends_on 'perl_xml_sax_base' => :build
  depends_on 'perl_xml_sax' => :build
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.patch
    downloader 'https://aur.archlinux.org/cgit/aur.git/plain/icecream.conf?h=icecream',
               '4c1b993761600955a2be53e945a698638ef861a513258956d8aac0e0f8df3dfe', 'icecream.conf'
    system "sed -i 's,/var,#{CREW_PREFIX}/var,g' icecream.conf"
  end

  def self.build
    system './autogen.sh'
    system "./configure --prefix=#{CREW_LIB_PREFIX}/icecream \
      --enable-shared \
      --disable-static \
      --enable-clang-wrappers \
      --enable-clang-rewrite-includes \
      --mandir=#{CREW_MAN_PREFIX} \
      --with-libcap_ng"
    system 'make'

    File.write 'ld-icecream.conf', <<~LD_ICECREAM_HEREDOC
      #{CREW_LIB_PREFIX}/icecream/lib
    LD_ICECREAM_HEREDOC

    File.write 'icecream-schedulerd', <<~ICECREAM_SCHEDULERD_HEREDOC
      #!/bin/sh

      . #{CREW_PREFIX}/etc/icecream.conf

      netname=
      if test -n "$ICECREAM_NETNAME"; then
          netname="-n $ICECREAM_NETNAME"
      fi
      logfile=""
      if test -n "$ICECREAM_LOG_FILE"; then
          touch $ICECREAM_LOG_FILE
          logfile="-l $ICECREAM_LOG_FILE"
      fi

      #{CREW_LIB_PREFIX}/icecream/sbin/icecc-scheduler ${netname} ${logfile} &>/dev/null
    ICECREAM_SCHEDULERD_HEREDOC

    File.write 'icecreamd', <<~ICECREAMD_HEREDOC
      #!/bin/bash
      . #{CREW_PREFIX}/etc/icecream.conf

      if test -n "${ICECREAM_NETNAME}"; then
          netname="-n ${ICECREAM_NETNAME}"
      fi
      logfile=""
      if test -n "${ICECREAM_LOG_FILE}"; then
          touch ${ICECREAM_LOG_FILE}
          chown icecream:icecream ${ICECREAM_LOG_FILE}
          logfile="-l ${ICECREAM_LOG_FILE}"
      fi
      nice=""
      if test -n "${ICECREAM_NICE_LEVEL}"; then
          nice="--nice ${ICECREAM_NICE_LEVEL}"
      fi
      scheduler=""
      if test -n "${ICECREAM_SCHEDULER_HOST}"; then
          scheduler="-s ${ICECREAM_SCHEDULER_HOST}"
      fi
      noremote=""
      if test "${ICECREAM_ALLOW_REMOTE}" = "no" 2> /dev/null; then
          noremote="--no-remote"
      fi
      maxjobs=""
      if test -n "${ICECREAM_MAX_JOBS}"; then
          if test "${ICECREAM_MAX_JOBS}" -eq 0 2> /dev/null; then
            maxjobs="-m 1"
            noremote="--no-remote"
          else
            maxjobs="-m ${ICECREAM_MAX_JOBS}"
          fi
      fi

      #{CREW_LIB_PREFIX}/icecream/sbin/iceccd -u icecream ${logfile} ${nice} ${scheduler} ${netname} -b "${ICECREAM_BASEDIR}" ${maxjobs} ${noremote}  &>/dev/null
    ICECREAMD_HEREDOC
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    FileUtils.install 'icecream.conf', "#{CREW_DEST_PREFIX}/etc/icecream.conf", mode: 0o644
    FileUtils.install 'icecreamd', "#{CREW_DEST_LIB_PREFIX}/icecream/icecreamd", mode: 0o755
    FileUtils.install 'icecream-schedulerd', "#{CREW_DEST_LIB_PREFIX}/icecream/icecream-schedulerd", mode: 0o755
    FileUtils.install 'ld-icecream.conf', "#{CREW_DEST_PREFIX}/etc/ld.so.conf.d/icecream.conf", mode: 0o644
    FileUtils.install "#{CREW_DEST_LIB_PREFIX}/icecream/lib/pkgconfig/icecc.pc",
                      "#{CREW_DEST_LIB_PREFIX}/pkgconfig/icecc.pc", mode: 0o644
    FileUtils.rm_rf "#{CREW_DEST_LIB_PREFIX}/icecream/lib/pkgconfig"
  end
end
