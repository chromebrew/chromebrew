require 'package'

class Qtfm < Package
  description 'Lightweight desktop independent Qt file manager'
  homepage 'https://qtfm.eu/'
  version '6.2.0'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://github.com/rodlie/qtfm/archive/6.2.0.tar.gz'
  source_sha256 '58c6af502b606e63f96e8aec96b65ca9125be18ecdd5e4680ccaf50e9c40b064'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qtfm-6.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qtfm-6.2.0-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qtfm-6.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bb5fb4098d06a1fe0e8c6ba11335da83f23b5057d40e3f451c8db1074b1008af',
     armv7l: 'bb5fb4098d06a1fe0e8c6ba11335da83f23b5057d40e3f451c8db1074b1008af',
     x86_64: 'ff50100f60fed4086578db1514178b897e834bcbe81c331b50711aa8d341010b',
  })

  depends_on 'qtbase'
  depends_on 'imagemagick7'
  depends_on 'ffmpeg'
  depends_on 'sommelier'

  def self.patch
    system "sed -i '12i#include <QPainterPath>' libfm/iconlist.h"
    system "sed -i '14i#include <QPainterPath>' libfm/iconview.h"
  end

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'qmake',
             "PREFIX=#{CREW_PREFIX}",
             "LIBDIR=#{CREW_LIB_PREFIX}",
             'CONFIG+=with_includes',
             'CONFIG+=with_magick',
             'CONFIG+=magick7',
             'CONFIG+=with_ffmpeg',
             'CONFIG+=sharedlib',
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
    end
  end
end
