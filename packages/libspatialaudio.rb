require 'package'

class Libspatialaudio < Package
  description 'libspatialaudio is a library for Ambisonic encoding and decoding, filtering and binaural rendering.'
  homepage 'https://github.com/videolabs/libspatialaudio/'
  version '0.3.0+git20180730'
  compatibility 'all'
  license 'LGPL-2.1'
  source_url 'https://salsa.debian.org/multimedia-team/libspatialaudio.git'
  git_hashtag "debian/#{version}+dfsg1-2"

  depends_on 'libmysofa'

  def self.patch
    FileUtils.mkdir_p 'source/normal'
    Dir.chdir 'source/normal' do
      downloader 'https://github.com/greekgoddj/mit-hrtf-lib/raw/658657aebc58480d5511bd726b8dfa73b4f49ac7/source/normal/mit_hrtf_normal_44100.h',
                 'ffee6a5f1f1e771c863c1c02be3d01e7a23359d8553b1f5aa4dba014f1eb05dd'

      downloader 'https://github.com/greekgoddj/mit-hrtf-lib/raw/658657aebc58480d5511bd726b8dfa73b4f49ac7/source/normal/mit_hrtf_normal_48000.h',
                 '807de23e95e299692516ccaebfb907e1d8caf554f38e87dd8fd07caee41aae7f'

      downloader 'https://github.com/greekgoddj/mit-hrtf-lib/raw/658657aebc58480d5511bd726b8dfa73b4f49ac7/source/normal/mit_hrtf_normal_88200.h',
                 'f106a37cd87689cde5d958e3201e6f1d214998063caa60486d2dcf672deaa70b'

      downloader 'https://github.com/greekgoddj/mit-hrtf-lib/raw/658657aebc58480d5511bd726b8dfa73b4f49ac7/source/normal/mit_hrtf_normal_96000.h',
                 '37880838efe36fea8c1eff1c9a4b4b4fb0a44e61aaec6cfda716062ccbc75fe2'
    end

    File.foreach 'debian/patches/series' do |patch|
      system "patch -Np1 -i debian/patches/#{patch}"
    end
  end

  def self.build
    FileUtils.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G 'Ninja' #{CREW_CMAKE_OPTIONS} .."
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
