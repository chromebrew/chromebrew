require 'buildsystems/meson'

class Pcsc_lite < Meson
  description 'PCSC is middleware to access a smart card using SCard API (PC/SC).'
  homepage 'https://pcsclite.apdu.fr/'
  version '2.5.2'
  compatibility 'aarch64 armv7l x86_64'
  license 'BSD, ISC, MIT, GPL-3+ and GPL-2'
  source_url 'https://salsa.debian.org/debian/pcsc-lite.git'
  git_hashtag "debian/#{version}-1"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cd0696f99f49ceaed74131ea9f91875d25b4e762aa49cd7d4dd01fe5c4fd739b',
     armv7l: 'cd0696f99f49ceaed74131ea9f91875d25b4e762aa49cd7d4dd01fe5c4fd739b',
     x86_64: 'c73ed6c47c4c3e9b856c501d439fa00fb74c4a1d02421e1f52693da36ac6c03b'
  })

  depends_on 'elogind'
  depends_on 'eudev' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'polkit' => :executable

  def self.patch
    system "for i in \$(cat debian/patches/series); do patch -Np1 -i debian/patches/\${i}; done"
  end

  meson_options "-Dlibsystemd=false -Dlibusb=false -Dlibudev=true -Dpolkit=true \
    -Dusb=true -Dserial=true -Dserialconfdir=#{CREW_PREFIX}/etc/reader.conf.d \
    -Dusbdropdir=#{CREW_LIB_PREFIX}/pcsc/drivers -Dipcdir=#{CREW_PREFIX}/var/run/pcscd"

  meson_install_extras do
    FileUtils.mv "#{CREW_DEST_PREFIX}/sysusers.d", "#{CREW_DEST_PREFIX}/etc"
    FileUtils.mv "#{CREW_DEST_PREFIX}/lib/systemd", CREW_DEST_LIB_PREFIX.to_s if ARCH.eql?('x86_64')
    system "sed -i 's,/usr/bin/python3,#{CREW_PREFIX}/bin/python3,' #{CREW_DEST_PREFIX}/bin/pcsc-spy"
  end

  run_tests
end
