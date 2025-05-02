require 'package'

class Hello_world_chromebrew < Package
  description 'Chromebrew Package Build Test (for use in PR Actions)'
  homepage 'https://github.com/chromebrew/chromebrew'
  version '1.2'
  license 'MIT'       # Package license (eg. GPL-3, MIT, etc.)
  compatibility 'all' # Package architecture compatibility (eg. aarch64, armv7l, i686, x86_64 or all)
  source_url 'https://github.com/chromebrew/chromebrew/raw/master/tools/hello_world_chromebrew.c'
  source_sha256 'ff3632aba26639630ff8c1d91ebc168e185c2cb4fda8c856e61f33d53215aac3'
  binary_compression 'tar.zst'

  # These are needed to successfully build and check for dependencies.

  binary_sha256({
    aarch64: 'd2fb648b2f41ea10f851fc66602a15e595866a7e0b6cd999969e038a3af74bc1',
     armv7l: 'd2fb648b2f41ea10f851fc66602a15e595866a7e0b6cd999969e038a3af74bc1',
       i686: '9303a26a1a3c9ad93edf874da13148ccd823e9c5f4739ca8675d141065eac9ab',
     x86_64: '486eac7f7f9cbc5010d667c7bdd3991c4da6ef79040afc68775cbe7f0ee6a167'
  })

  # Register dependencies (use the following line as a basis)

  # Runtime dependencies:
  # depends_on '*' # R
  # Build dependencies:
  # depends_on '*' => :build

  # Function to perform patch operations prior to build from source.
  def self.patch
    system "sed -i 's/Hello Chromebrew/Hello, Chromebrew/' hello_world_chromebrew.c"
  end

  # Function to perform pre-build operations prior to build from source.
  def self.prebuild; end

  # Function to perform build from source.
  def self.build
    system "gcc #{CREW_COMMON_FLAGS} #{CREW_LINKER_FLAGS} -o hello hello_world_chromebrew.c"
  end

  # Function to perform check from source build.
  # This is executed only during `crew build`.
  def self.check
    system './hello'
  end

  # Function to perform install from source build.
  def self.install
    FileUtils.install 'hello', "#{CREW_DEST_PREFIX}/bin/hello_chromebrew", mode: 0o755
  end

  # Function to perform post-install for both source build and binary distribution
  def self.postinstall
    system "#{CREW_PREFIX}/bin/hello_chromebrew"
  end
end
