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
    aarch64: '2b92a497fbf44d4d89339d79aa5497a71bcfd52bc7cfb44066eeb1de5d5fba63',
     armv7l: '2b92a497fbf44d4d89339d79aa5497a71bcfd52bc7cfb44066eeb1de5d5fba63',
       i686: 'f7f929d718adbaa506c1f87f738ef25da8792f952323900a191d0982cbe5eed6',
     x86_64: '6af9b35814f5e9bfa2f33a01fc7574be4a1d203ddc07b7c5f24f85abc0cbb979'
  })

  # Register dependencies (use the following line as a basis)

  # Runtime dependencies:
  # depends_on '*' # R
  # Build dependencies:
  # depends_on '*' => :build
  depends_on 'glibc' # R

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
