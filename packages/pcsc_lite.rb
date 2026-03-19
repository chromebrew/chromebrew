require 'buildsystems/meson'

class Pcsc_lite < Meson
  description 'PCSC is middleware to access a smart card using SCard API (PC/SC).'
  homepage 'https://pcsclite.apdu.fr/'
  version '2.4.1'
  compatibility 'aarch64 armv7l x86_64'
  license 'BSD, ISC, MIT, GPL-3+ and GPL-2'
  source_url 'https://salsa.debian.org/debian/pcsc-lite.git'
  git_hashtag "debian/#{version}-1"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f6d708ac392d22ce6a00a1275b044abad44816b9554994d45f30a47b89c65fe',
     armv7l: '4f6d708ac392d22ce6a00a1275b044abad44816b9554994d45f30a47b89c65fe',
     x86_64: '69807f2673beff3c950149a6b58c5e1015c82adfff3c05c581b3407de7b7ae1c'
  })

  depends_on 'elogind'
  depends_on 'eudev' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' # R
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
