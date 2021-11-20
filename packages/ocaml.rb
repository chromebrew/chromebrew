require 'package'

class Ocaml < Package
  description 'OCaml is an industrial strength programming language supporting functional, imperative and object-oriented styles'
  homepage 'http://ocaml.org/'
  version '4.13.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/ocaml/ocaml.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ocaml/4.13.1_armv7l/ocaml-4.13.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ocaml/4.13.1_armv7l/ocaml-4.13.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ocaml/4.13.1_x86_64/ocaml-4.13.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c7a6fbbfe966ed1396cbf9b9222fa1b11cffa294c11d86f3a4e45ae16f99f062',
     armv7l: 'c7a6fbbfe966ed1396cbf9b9222fa1b11cffa294c11d86f3a4e45ae16f99f062',
     x86_64: 'a641c92dc3f56eaa29c5abf31bda397bb0c5cd35319a3d56f0fda30808d5bbc5'
  })

  @crew_env_options = CREW_ENV_OPTIONS
  @cc = ''
  case ARCH
  when 'aarch64', 'armv7l'
    # the ocaml log module fails to build when ld.gold is used.
    @crew_env_options = CREW_ENV_OPTIONS.gsub('-fuse-ld=gold', '-fuse-ld=bfd')
    @cc = "CC='gcc -fuse-ld=bfd'"
  end

  def self.patch
    system 'filefix'
    # Fedora pass flags to ocaml patch from October 2021
    # https://pagure.io/fedora-ocaml/c/9966786a7389dc6621f2bc2dce7c690c5a38b67d.patch
    @fedora_ocaml_patch = <<~'OCAML_PATCH'
      diff --git a/configure.ac b/configure.ac
      index 3698c7c..e2a3cbe 100644
      --- a/configure.ac
      +++ b/configure.ac
      @@ -669,6 +669,10 @@ AS_CASE([$host],
             internal_cflags="$cc_warnings"],
           [common_cflags="-O"])])

      +# Allow CFLAGS and LDFLAGS to be added.
      +common_cflags="$common_cflags $CFLAGS"
      +cclibs="$cclibs $LDFLAGS"
      +
       internal_cppflags="-DCAML_NAME_SPACE $internal_cppflags"

       # Enable SSE2 on x86 mingw to avoid using 80-bit registers.
    OCAML_PATCH
    File.write('fedora_ocaml.patch', @fedora_ocaml_patch)
    system 'patch -Np1 -i fedora_ocaml.patch'
  end

  def self.prebuild; end

  def self.build
    system "#{@cc} #{@crew_env_options} \
      ./configure #{CREW_OPTIONS}"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/as", "#{CREW_BUILD}-as"
    system "#{@cc} PATH=$PATH:$(pwd) make -j#{CREW_NPROC}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    # ocaml packages complain about this if it isn't there.
    if !File.exist?("#{CREW_PREFIX}/bin/#{CREW_BUILD}-as") && File.exist?("#{CREW_PREFIX}/bin/as")
      FileUtils.ln_s "#{CREW_PREFIX}/bin/as",
                     "#{CREW_PREFIX}/bin/#{CREW_BUILD}-as"
    end
  end
end
