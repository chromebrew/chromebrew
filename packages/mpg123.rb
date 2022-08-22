require 'package'

class Mpg123 < Package
  description 'Fast console MPEG Audio Player and decoder library.'
  homepage 'http://www.mpg123.org/'
  version '1.29.3'
  compatibility 'all'
  license 'GPL-2 and LGPL-2.1'
  source_url 'https://sourceforge.net/projects/mpg123/files/mpg123/1.29.3/mpg123-1.29.3.tar.bz2'
  source_sha256 '963885d8cc77262f28b77187c7d189e32195e64244de2530b798ddf32183e847'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mpg123/1.29.3_armv7l/mpg123-1.29.3-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mpg123/1.29.3_armv7l/mpg123-1.29.3-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mpg123/1.29.3_i686/mpg123-1.29.3-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mpg123/1.29.3_x86_64/mpg123-1.29.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6fe2ab75f5e2dcaf0f5535dd303e0e8fbe216c20198089b917308695635e0fa8',
      armv7l: '6fe2ab75f5e2dcaf0f5535dd303e0e8fbe216c20198089b917308695635e0fa8',
        i686: '643101b7969e47a338e733856b562d3630d9ad0fff78e16e3c9bf1d6b2836293',
      x86_64: 'b03804b351e3601fe2f779e2bff6d02e6b170afa89fd30f933c114349d00453a'
  })

  depends_on 'alsa_lib'
  #  depends_on 'cras'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
            --with-audio=alsa" # should we also use pulseaudio and/or jack?
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
