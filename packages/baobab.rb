require 'package'

class Baobab < Package
  description 'Disk Usage Analyzer (also known as baobab) scans folders, devices or remote locations and and reports on the disk space consumed by each element.'
  homepage 'https://wiki.gnome.org/Apps/DiskUsageAnalyzer'
  version '3.35.1'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/baobab/3.35/baobab-3.35.1.tar.xz'
  source_sha256 '1b6b5e533802a9293bd061cd0a49049664c310f814e39e40b310ae954342fe83'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/baobab-3.35.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/baobab-3.35.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/baobab-3.35.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/baobab-3.35.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c71f8f044a796984990f52b33953c22e9a197ca547123f65cad0b810bd04a53f',
     armv7l: 'c71f8f044a796984990f52b33953c22e9a197ca547123f65cad0b810bd04a53f',
       i686: '5eda1f765da12d94fdc6b8e9de37b62608edf215e7b07941b3328523a3ebb074',
     x86_64: '0fac89defc368a81745bc7fae11dd16c9ea0008820a0bafabbf85d837426f9ae'
  })

  depends_on 'gtk3'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'itstool' => :build
  depends_on 'vala' => :build
  depends_on 'sommelier'

  def self.build
    system "meson  --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system "update-mime-database #{CREW_PREFIX}/share/mime"
  end
end
