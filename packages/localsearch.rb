require 'buildsystems/meson'

class Localsearch < Meson
  description 'Collection of data extractors for Tracker/Nepomuk'
  homepage 'https://gitlab.gnome.org/GNOME/localsearch'
  version "3.11.1-#{CREW_ICU_VER}"
  license 'GPLv2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/localsearch.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4e3b82e659d1bb725007289a23f767352a99f4e3ac3cc09c5ca5c92ec9e7eca6',
     armv7l: '4e3b82e659d1bb725007289a23f767352a99f4e3ac3cc09c5ca5c92ec9e7eca6',
     x86_64: '28d81f81aebccef109a469db9894676d2e1f7425dc0a85beebf12fd75561479d'
  })

  depends_on 'exempi' => :library
  depends_on 'ffmpeg' => :library
  depends_on 'gcc_lib' => :build
  depends_on 'gexiv2' => :library
  depends_on 'giflib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gstreamer' => :library
  depends_on 'icu4c' => :library
  depends_on 'libcue' => :library
  depends_on 'libexif' => :build
  depends_on 'libgsf' => :library
  depends_on 'libgudev' => :build
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libpng' => :library
  depends_on 'libseccomp' => :executable
  depends_on 'libtiff' => :library
  depends_on 'libwebp' => :library
  depends_on 'libxml2' => :library
  depends_on 'poppler' => :library
  depends_on 'py3_asciidoc' => :build
  depends_on 'tinysparql' => :library
  depends_on 'vala' => :build

  gnome

  meson_options "-Dbattery_detection=none \
      -Ddbus_services_dir=#{CREW_PREFIX}/share/dbus-1/services/ \
      -Dfunctional_tests=false \
      -Dlandlock=disabled \
      -Dman=false \
      -Dsystemd_user_services=false"

  def self.patch
    Dir.chdir('src/common') do
      gettid_wrapper = <<~GETTID_WRAPPER_EOF
        #define _GNU_SOURCE
        #include <unistd.h>

        #else

        #include <sys/syscall.h>

        pid_t
        gettid(void)
        {

            return syscall(SYS_gettid);
        }
        #endif
      GETTID_WRAPPER_EOF
      File.write('gettid_wrapper', gettid_wrapper)
      system "sed -i '/#define ALLOW_RULE(call)/i #if __GLIBC_PREREQ(2,30)' tracker-seccomp.c"
      system "sed -i '/#if __GLIBC_PREREQ(2,30)/r gettid_wrapper' tracker-seccomp.c"
    end
  end
end
