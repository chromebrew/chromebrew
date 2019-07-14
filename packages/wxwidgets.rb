require 'package'

class Wxwidgets < Package
  description 'wxWidgets is a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base.'
  homepage 'https://www.wxwidgets.org/'
  version '3.1.2'
  source_url 'https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.2/wxWidgets-3.1.2.tar.bz2'
  source_sha256 '4cb8d23d70f9261debf7d6cfeca667fc0a7d2b6565adb8f1c484f9b674f1f27a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '96580aec6fe20137f5eee84a576cc748c0335315366ab4936cee018a9aed8b24',
     armv7l: '96580aec6fe20137f5eee84a576cc748c0335315366ab4936cee018a9aed8b24',
       i686: 'dc1e2b57c6a3fe3629dc1d214608a27a75c46170ad2888a074c04549ee46350b',
     x86_64: 'bbc30d233c7a63aa6ebfe0d49e835a918731f964b0774e0ac87e4ae0025ad15a',
  })

  depends_on 'gst_plugins_base'
  depends_on 'libnotify'
  depends_on 'libsdl'
  depends_on 'libsecret'
  depends_on 'libsoup'
  depends_on 'mesa'

  def self.build
    Dir.mkdir 'wxwidgets'
    Dir.chdir 'wxwidgets' do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '-DCMAKE_BUILD_TYPE=Release',
             '-DwxBUILD_TOOLKIT=gtk3',
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'wxwidgets' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      if ARCH == 'x86_64'
        FileUtils.mv "#{CREW_DEST_PREFIX}/lib", "#{CREW_DEST_LIB_PREFIX}"
      end
    end
  end
end
