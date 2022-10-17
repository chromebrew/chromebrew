require 'package'

class Libspatialaudio < Package
  description 'libspatialaudio is a library for Ambisonic encoding and decoding, filtering and binaural rendering.'
  homepage 'https://github.com/videolabs/libspatialaudio/'
  @_ver = '0.3.0+git20180730'
  version @_ver
  compatibility 'all'
  license 'LGPL-2.1'
  source_url 'https://salsa.debian.org/multimedia-team/libspatialaudio.git'
  git_hashtag "debian/#{@_ver}+dfsg1-2"

  binary_url({
    aarch64: 'file:///usr/local/tmp/packages/libspatialaudio-0.3.0+git20180730-chromeos-armv7l.tpxz',
      armv7l: 'file:///usr/local/tmp/packages/libspatialaudio-0.3.0+git20180730-chromeos-armv7l.tpxz',
        i686: 'file:///usr/local/tmp/packages/libspatialaudio-0.3.0+git20180730-chromeos-i686.tpxz',
      x86_64: 'file:///usr/local/tmp/packages/libspatialaudio-0.3.0+git20180730-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '98c19eda328ea764f9ee707ab6f580394c16bbb983896c67403fb0e39e8b2110',
      armv7l: '98c19eda328ea764f9ee707ab6f580394c16bbb983896c67403fb0e39e8b2110',
        i686: 'c7262162350e091cadd3d46e43774f5c9efefde3feb6c979b6a46c37f0a09ff6',
      x86_64: '11691fca3f27b34be0bd225666f8f799f214afa372a31182a424dd9a7e7f782d'
  })

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
