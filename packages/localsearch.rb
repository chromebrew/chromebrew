require 'buildsystems/meson'

class Localsearch < Meson
  description 'Collection of data extractors for Tracker/Nepomuk'
  homepage 'https://gitlab.gnome.org/GNOME/localsearch'
  version "3.8.0-#{CREW_ICU_VER}"
  license 'GPLv2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/localsearch.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4e3b82e659d1bb725007289a23f767352a99f4e3ac3cc09c5ca5c92ec9e7eca6',
     armv7l: '4e3b82e659d1bb725007289a23f767352a99f4e3ac3cc09c5ca5c92ec9e7eca6',
     x86_64: 'b10791284109bbe2cb0fbb4ea0429cc2a85aa82cdf3bd301357008d2c7f313db'
  })

  depends_on 'exempi' # R
  depends_on 'gcc_lib' => :build
  depends_on 'gexiv2' # R
  depends_on 'giflib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gstreamer' # R
  depends_on 'icu4c' # R
  depends_on 'libcue' # R
  depends_on 'libexif' # R
  depends_on 'libgsf' # R
  depends_on 'libgudev' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'libseccomp' # R
  depends_on 'libtiff' # R
  depends_on 'libxml2' # R
  depends_on 'poppler' # R
  depends_on 'py3_asciidoc' => :build
  depends_on 'tinysparql' # R
  depends_on 'vala' => :build

  gnome

  meson_options "-Dbattery_detection=none \
      -Ddbus_services_dir=#{CREW_PREFIX}/share/dbus-1/services/ \
      -Dlandlock=disabled \
      -Dman=false \
      -Dsystemd_user_services=false"

  def self.patch
    Dir.chdir('src/libtracker-miners-common') do
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
